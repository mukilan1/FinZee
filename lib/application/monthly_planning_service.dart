import '../core/errors.dart';
import '../core/features.dart';
import '../core/ids.dart';
import '../core/money.dart';
import '../core/validators.dart';
import '../database/finance_repository.dart';
import '../domain/entities.dart';
import 'financial_calculation_service.dart';

class MonthlyPlanningService {
  MonthlyPlanningService(this.repo);
  final FinanceRepository repo;
  final _calc = FinancialCalculationService();

  Future<MonthlyPlan> generatePlan({
    required int year,
    required int month,
    required Map<AppFeature, bool> features,
  }) async {
    if (!(features[AppFeature.salaryPlanning] ?? false)) {
      throw const FeatureUnavailableError('Salary planning is disabled.');
    }
    final existing = await repo.planFor(year, month);
    if (existing != null) return existing;

    final salary = await repo.activeSalary();
    final expected = salary?.baseAmount ?? const Money(0);
    final plan = MonthlyPlan(
      id: newId(),
      year: year,
      month: month,
      expectedIncome: expected,
      createdAt: DateTime.now(),
    );
    await repo.upsertPlan(plan);

    var templates = await repo.templates();
    if (templates.isEmpty) {
      templates = await _defaultTemplate(features);
    }
    if (features[AppFeature.bills] ?? false) {
      final bills = await repo.bills();
      for (final bill in bills.where((b) => b.autoPlan)) {
        if (templates.any((t) => t.billId == bill.id)) continue;
        templates = [
          ...templates,
          AllocationTemplateItem(
            id: newId(),
            name: bill.name,
            kind: AllocationKind.bill,
            plannedAmount: bill.amount,
            billId: bill.id,
            categoryId: bill.categoryId,
            accountId: bill.accountId,
            sortOrder: templates.length,
          ),
        ];
      }
    }
    if (features[AppFeature.loans] ?? false) {
      final loans = await repo.loans();
      for (final loan in loans) {
        if (templates.any((t) => t.loanId == loan.id)) continue;
        templates = [
          ...templates,
          AllocationTemplateItem(
            id: newId(),
            name: '${loan.name} EMI',
            kind: AllocationKind.loanEmi,
            plannedAmount: loan.emi,
            loanId: loan.id,
            accountId: loan.accountId,
            sortOrder: templates.length,
          ),
        ];
      }
    }
    if (!(features[AppFeature.investments] ?? false)) {
      templates = templates.where((t) => t.kind != AllocationKind.investment).toList();
    }
    if (!(features[AppFeature.savingsGoals] ?? false)) {
      templates = templates.where((t) => t.kind != AllocationKind.savings).toList();
    }

    var order = 0;
    for (final t in templates) {
      await repo.upsertAllocation(
        AllocationItem(
          id: newId(),
          planId: plan.id,
          name: t.name,
          kind: t.kind,
          plannedAmount: t.plannedAmount,
          categoryId: t.categoryId,
          goalId: t.goalId,
          investmentId: t.investmentId,
          billId: t.billId,
          loanId: t.loanId,
          accountId: t.accountId,
          sortOrder: order++,
        ),
      );
    }
    await repo.audit('PLAN_GENERATED', plan.periodKey);
    return plan;
  }

  Future<List<AllocationTemplateItem>> _defaultTemplate(
    Map<AppFeature, bool> features,
  ) async {
    final items = <AllocationTemplateItem>[];
    if (features[AppFeature.savingsGoals] ?? false) {
      final goals = await repo.savingsGoals();
      for (final g in goals) {
        if (g.monthlyContribution == null) continue;
        items.add(
          AllocationTemplateItem(
            id: newId(),
            name: g.name,
            kind: AllocationKind.savings,
            plannedAmount: g.monthlyContribution!,
            goalId: g.id,
            sortOrder: items.length,
          ),
        );
      }
    }
    return items;
  }

  Future<void> confirmPlan(String planId) async {
    final plan = await repo.planById(planId);
    if (plan == null) throw const ValidationError('Plan not found.');
    await repo.upsertPlan(
      MonthlyPlan(
        id: plan.id,
        year: plan.year,
        month: plan.month,
        expectedIncome: plan.expectedIncome,
        confirmed: true,
        createdAt: plan.createdAt,
      ),
    );
    await repo.audit('PLAN_CONFIRMED', planId);
  }

  Future<FinanceTransaction> completeAllocation({
    required String allocationId,
    required Money actual,
    required String accountId,
    DateTime? date,
  }) async {
    requirePositiveAmount(actual);
    final item = await repo.allocationById(allocationId);
    if (item == null) throw const ValidationError('Allocation not found.');
    final account = await repo.accountById(accountId);
    requireAccount(account);

    final status = actual.minor >= item.plannedAmount.minor
        ? AllocationStatus.completed
        : AllocationStatus.partial;

    var goalId = item.goalId;
    var investmentId = item.investmentId;
    TransactionType type;
    String? toAccountId;
    String? categoryId = item.categoryId;

    switch (item.kind) {
      case AllocationKind.savings:
        type = TransactionType.saving;
        toAccountId = 'acc_savings';
        if (goalId != null) {
          final goal = await repo.savingsGoalById(goalId);
          if (goal == null) {
            throw const ValidationError('Allocation cannot reference a missing goal.');
          }
          await repo.upsertSavingsGoal(
            SavingsGoal(
              id: goal.id,
              name: goal.name,
              targetAmount: goal.targetAmount,
              currentAmount: goal.currentAmount + actual,
              targetDate: goal.targetDate,
              monthlyContribution: goal.monthlyContribution,
              priority: goal.priority,
              notes: goal.notes,
            ),
          );
          await repo.audit('GOAL_UPDATED', goal.id);
        }
      case AllocationKind.investment:
        type = TransactionType.investment;
        toAccountId = 'acc_invest';
        investmentId ??= newId();
        final existing = (await repo.investments())
            .where((i) => i.id == investmentId)
            .toList();
        if (existing.isEmpty) {
          await repo.upsertInvestment(
            Investment(
              id: investmentId,
              name: item.name,
              type: 'custom',
              amount: actual,
              date: date ?? DateTime.now(),
              accountId: accountId,
            ),
          );
        } else {
          final inv = existing.first;
          await repo.upsertInvestment(
            Investment(
              id: inv.id,
              name: inv.name,
              type: inv.type,
              amount: inv.amount + actual,
              date: inv.date,
              accountId: inv.accountId,
              currentValue: (inv.currentValue ?? inv.amount) + actual,
              notes: inv.notes,
            ),
          );
        }
      case AllocationKind.expense:
      case AllocationKind.bill:
      case AllocationKind.loanEmi:
        type = TransactionType.expense;
        categoryId ??= 'exp_other';
        if (item.kind == AllocationKind.loanEmi && item.loanId != null) {
          final loans = await repo.loans();
          final matches = loans.where((l) => l.id == item.loanId);
          final loan = matches.isEmpty ? null : matches.first;
          if (loan != null) {
            await repo.upsertLoan(
              Loan(
                id: loan.id,
                name: loan.name,
                principal: loan.principal,
                interestRate: loan.interestRate,
                emi: loan.emi,
                startDate: loan.startDate,
                endDate: loan.endDate,
                remaining: Money(
                  (loan.remaining.minor - actual.minor).clamp(0, loan.remaining.minor),
                ),
                accountId: loan.accountId,
              ),
            );
          }
        }
    }

    final tx = FinanceTransaction(
      id: newId(),
      type: type,
      amount: actual,
      date: date ?? DateTime.now(),
      accountId: accountId,
      toAccountId: toAccountId,
      categoryId: categoryId,
      allocationItemId: item.id,
      goalId: goalId,
      investmentId: investmentId,
      note: item.name,
      createdAt: DateTime.now(),
    );
    await repo.insertTransaction(tx);
    await repo.upsertAllocation(
      AllocationItem(
        id: item.id,
        planId: item.planId,
        name: item.name,
        kind: item.kind,
        plannedAmount: item.plannedAmount,
        actualAmount: actual,
        status: status,
        categoryId: item.categoryId,
        goalId: item.goalId,
        investmentId: investmentId,
        billId: item.billId,
        loanId: item.loanId,
        accountId: accountId,
        skipReason: item.skipReason,
        skipNote: item.skipNote,
        sortOrder: item.sortOrder,
      ),
    );
    await repo.audit(
      status == AllocationStatus.partial
          ? 'ALLOCATION_PARTIAL'
          : 'ALLOCATION_COMPLETED',
      item.id,
    );
    await repo.audit('TRANSACTION_CREATED', tx.id);
    _calc.assertFinancialInvariants([tx]);
    return tx;
  }

  Future<void> skipAllocation({
    required String allocationId,
    required SkipReason reason,
    String? note,
  }) async {
    if (reason == SkipReason.other && (note == null || note.trim().isEmpty)) {
      throw const ValidationError('Other requires a custom reason.');
    }
    final item = await repo.allocationById(allocationId);
    if (item == null) throw const ValidationError('Allocation not found.');
    await repo.upsertAllocation(
      AllocationItem(
        id: item.id,
        planId: item.planId,
        name: item.name,
        kind: item.kind,
        plannedAmount: item.plannedAmount,
        actualAmount: const Money(0),
        status: AllocationStatus.skipped,
        categoryId: item.categoryId,
        goalId: item.goalId,
        investmentId: item.investmentId,
        billId: item.billId,
        loanId: item.loanId,
        accountId: item.accountId,
        skipReason: reason,
        skipNote: note,
        sortOrder: item.sortOrder,
      ),
    );
    await repo.audit('ALLOCATION_SKIPPED', '$allocationId:${reason.name}');
    if (note != null && note.isNotEmpty) {
      await repo.insertNote(
        FinanceNote(
          id: newId(),
          body: note,
          createdAt: DateTime.now(),
          allocationId: allocationId,
        ),
      );
    }
  }
}
