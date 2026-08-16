import '../core/features.dart';
import '../domain/entities.dart';
import 'financial_calculation_service.dart';

/// Builds local inbox alerts from live financial state.
/// Feature OFF hides related alerts; records are not deleted.
class AlertService {
  AlertService({FinancialCalculationService? calc})
      : calc = calc ?? FinancialCalculationService();

  final FinancialCalculationService calc;

  List<LocalAlert> build({
    required DateTime now,
    required Map<AppFeature, bool> features,
    required List<Account> accounts,
    required List<FinanceTransaction> transactions,
    required List<AllocationItem> allocations,
    required MonthlyPlan? plan,
    required SalaryProfile? salary,
    required List<Budget> budgets,
    required List<RecurringBill> bills,
    required List<Loan> loans,
    required List<SavingsGoal> savingsGoals,
    required List<Investment> investments,
    required List<FinancialGoal> financialGoals,
  }) {
    final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    final range = MonthRange(now.year, now.month);
    final monthTx = transactions.where((t) => range.contains(t.date)).toList();
    bool on(AppFeature f) => features[f] ?? false;
    final alerts = <LocalAlert>[];

    alerts.addAll(_accountAlerts(accounts, transactions, monthKey));

    if (on(AppFeature.salaryPlanning)) {
      alerts.addAll(_salaryAlerts(now, monthKey, salary, monthTx, plan, allocations));
    }
    if (on(AppFeature.budgets)) {
      alerts.addAll(
        calc.budgetAlerts(budgets, monthTx).map(
          (a) => LocalAlert(
            id: '${a.id}_$monthKey',
            title: a.title,
            body: a.body,
            kind: a.kind,
            featureKey: AppFeature.budgets.key,
            severity: 2,
          ),
        ),
      );
    }
    if (on(AppFeature.bills)) {
      alerts.addAll(_billAlerts(now, monthKey, bills, allocations, monthTx));
    }
    if (on(AppFeature.loans)) {
      alerts.addAll(_loanAlerts(now, monthKey, loans, allocations));
    }
    if (on(AppFeature.savingsGoals)) {
      alerts.addAll(_savingsAlerts(now, savingsGoals));
    }
    if (on(AppFeature.investments)) {
      alerts.addAll(_investmentAlerts(investments));
    }
    if (on(AppFeature.financialGoals)) {
      alerts.addAll(_financialGoalAlerts(financialGoals));
    }

    alerts.sort((a, b) => b.severity.compareTo(a.severity));
    return alerts;
  }

  List<LocalAlert> _accountAlerts(
    List<Account> accounts,
    List<FinanceTransaction> transactions,
    String monthKey,
  ) {
    final alerts = <LocalAlert>[];
    final balances = calc.accountBalances(accounts, transactions);
    for (final b in balances.where((x) => !x.account.archived)) {
      if (!b.account.isLiability && b.balance.isNegative) {
        alerts.add(
          LocalAlert(
            id: 'neg_${b.account.id}_$monthKey',
            title: '${b.account.name} is overdrawn',
            body: 'Balance is ${b.balance.format()}. Review recent spending.',
            kind: 'account',
            severity: 2,
          ),
        );
      }
      if (b.account.isLiability && b.balance.minor > 0) {
        alerts.add(
          LocalAlert(
            id: 'card_${b.account.id}_$monthKey',
            title: 'Pay ${b.account.name}',
            body: 'Outstanding card balance ${b.balance.format()}.',
            kind: 'account',
            severity: 1,
          ),
        );
      }
    }
    return alerts;
  }

  List<LocalAlert> _salaryAlerts(
    DateTime now,
    String monthKey,
    SalaryProfile? salary,
    List<FinanceTransaction> monthTx,
    MonthlyPlan? plan,
    List<AllocationItem> allocations,
  ) {
    final alerts = <LocalAlert>[];
    if (salary != null && salary.payDay == now.day) {
      alerts.add(
        LocalAlert(
          id: 'salary_today_$monthKey',
          title: 'Salary expected today',
          body: '${salary.source} payday is today (${salary.baseAmount.format()}).',
          kind: 'salary',
          featureKey: AppFeature.salaryPlanning.key,
          severity: 1,
        ),
      );
    }
    if (salary != null && now.day >= salary.payDay) {
      final recorded = monthTx.any(
        (t) =>
            t.type == TransactionType.income && t.categoryId == 'inc_salary',
      );
      if (!recorded) {
        alerts.add(
          LocalAlert(
            id: 'salary_missing_$monthKey',
            title: 'Salary not recorded',
            body: 'Payday has passed and salary income is still missing this month.',
            kind: 'salary',
            featureKey: AppFeature.salaryPlanning.key,
            severity: 2,
          ),
        );
      }
    }
    if (plan == null) {
      alerts.add(
        LocalAlert(
          id: 'plan_missing_$monthKey',
          title: 'No monthly plan yet',
          body: 'Generate this month’s plan to allocate salary.',
          kind: 'allocation',
          featureKey: AppFeature.salaryPlanning.key,
          severity: 1,
        ),
      );
    } else if (!plan.confirmed) {
      alerts.add(
        LocalAlert(
          id: 'plan_unconfirmed_$monthKey',
          title: 'Plan not confirmed',
          body: 'Confirm the monthly plan before completing allocations.',
          kind: 'allocation',
          featureKey: AppFeature.salaryPlanning.key,
          severity: 1,
        ),
      );
    }
    final pending =
        allocations.where((a) => a.status == AllocationStatus.pending).length;
    if (pending > 0) {
      alerts.add(
        LocalAlert(
          id: 'alloc_pending_$monthKey',
          title: 'Allocations pending',
          body: 'You have $pending monthly allocations still open.',
          kind: 'allocation',
          featureKey: AppFeature.salaryPlanning.key,
          severity: 1,
        ),
      );
    }
    final partial =
        allocations.where((a) => a.status == AllocationStatus.partial).length;
    if (partial > 0) {
      alerts.add(
        LocalAlert(
          id: 'alloc_partial_$monthKey',
          title: 'Partial allocations',
          body: '$partial planned items were only partly completed.',
          kind: 'allocation',
          featureKey: AppFeature.salaryPlanning.key,
          severity: 1,
        ),
      );
    }
    final skipped =
        allocations.where((a) => a.status == AllocationStatus.skipped).toList();
    if (skipped.isNotEmpty) {
      alerts.add(
        LocalAlert(
          id: 'alloc_skipped_$monthKey',
          title: 'Skipped this month',
          body: skipped.map((a) => a.name).join(', '),
          kind: 'allocation',
          featureKey: AppFeature.salaryPlanning.key,
          severity: 1,
        ),
      );
    }
    return alerts;
  }

  List<LocalAlert> _billAlerts(
    DateTime now,
    String monthKey,
    List<RecurringBill> bills,
    List<AllocationItem> allocations,
    List<FinanceTransaction> monthTx,
  ) {
    final alerts = <LocalAlert>[];
    for (final bill in bills.where((b) => !b.archived && b.reminder)) {
      final paid = allocations.any(
            (a) =>
                a.billId == bill.id &&
                (a.status == AllocationStatus.completed ||
                    a.status == AllocationStatus.partial),
          ) ||
          monthTx.any(
            (t) =>
                t.type == TransactionType.expense &&
                t.categoryId == bill.categoryId &&
                t.note == bill.name,
          );
      if (paid) continue;
      final dueDay = bill.dueDay.clamp(1, 28);
      final delta = dueDay - now.day;
      if (delta < 0) {
        alerts.add(
          LocalAlert(
            id: 'bill_overdue_${bill.id}_$monthKey',
            title: '${bill.name} is overdue',
            body: '${bill.amount.format()} was due on day $dueDay.',
            kind: 'bill',
            featureKey: AppFeature.bills.key,
            severity: 2,
          ),
        );
      } else if (delta <= 3) {
        alerts.add(
          LocalAlert(
            id: 'bill_due_${bill.id}_$monthKey',
            title: '${bill.name} due soon',
            body: '${bill.amount.format()} is due on day $dueDay.',
            kind: 'bill',
            featureKey: AppFeature.bills.key,
            severity: 1,
          ),
        );
      }
    }
    return alerts;
  }

  List<LocalAlert> _loanAlerts(
    DateTime now,
    String monthKey,
    List<Loan> loans,
    List<AllocationItem> allocations,
  ) {
    final alerts = <LocalAlert>[];
    for (final loan in loans.where((l) => !l.archived)) {
      final paid = allocations.any(
        (a) =>
            a.loanId == loan.id &&
            (a.status == AllocationStatus.completed ||
                a.status == AllocationStatus.partial),
      );
      if (paid) continue;
      final dueDay = loan.startDate.day.clamp(1, 28);
      final delta = dueDay - now.day;
      if (delta <= 3) {
        alerts.add(
          LocalAlert(
            id: 'loan_${loan.id}_$monthKey',
            title: '${loan.name} EMI due',
            body: '${loan.emi.format()} toward remaining ${loan.remaining.format()}.',
            kind: 'loan',
            featureKey: AppFeature.loans.key,
            severity: 2,
          ),
        );
      }
    }
    return alerts;
  }

  List<LocalAlert> _savingsAlerts(DateTime now, List<SavingsGoal> goals) {
    final alerts = <LocalAlert>[];
    for (final goal in goals.where((g) => !g.archived)) {
      if (goal.targetDate == null) continue;
      final days = goal.targetDate!.difference(now).inDays;
      if (days <= 60 && goal.progress < 0.85) {
        alerts.add(
          LocalAlert(
            id: 'goal_${goal.id}',
            title: '${goal.name} needs attention',
            body:
                '${(goal.progress * 100).round()}% funded with $days days to the target date.',
            kind: 'goal',
            featureKey: AppFeature.savingsGoals.key,
            severity: days <= 14 ? 2 : 1,
          ),
        );
      }
    }
    return alerts;
  }

  List<LocalAlert> _investmentAlerts(List<Investment> investments) {
    final alerts = <LocalAlert>[];
    for (final inv in investments) {
      if (inv.marketValue.minor < inv.amount.minor) {
        alerts.add(
          LocalAlert(
            id: 'inv_down_${inv.id}',
            title: '${inv.name} is below cost',
            body:
                'Market ${inv.marketValue.format()} vs invested ${inv.amount.format()}.',
            kind: 'investment',
            featureKey: AppFeature.investments.key,
            severity: 1,
          ),
        );
      }
    }
    return alerts;
  }

  List<LocalAlert> _financialGoalAlerts(List<FinancialGoal> goals) {
    return goals
        .where((g) => !g.onTrack)
        .map(
          (g) => LocalAlert(
            id: 'fingoal_${g.id}',
            title: '${g.name} is behind',
            body:
                '${g.currentAmount.format()} of ${g.targetAmount.format()} so far.',
            kind: 'goal',
            featureKey: AppFeature.financialGoals.key,
            severity: 1,
          ),
        )
        .toList();
  }
}
