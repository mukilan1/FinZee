import 'package:drift/drift.dart';

import '../core/features.dart';
import '../core/ids.dart';
import '../core/money.dart';
import '../domain/entities.dart';
import 'app_database.dart';
import 'mappers.dart';

class FinanceRepository {
  FinanceRepository(this.db);
  final AppDatabase db;

  Future<void> seedIfEmpty() async {
    final existing = await db.select(db.accounts).get();
    if (existing.isNotEmpty) return;
    await seedDefaults();
  }

  Future<void> seedDefaults() async {
    final now = DateTime.now();
    await db.batch((b) {
      b.insert(
        db.accounts,
        AccountsCompanion.insert(
          id: 'acc_cash',
          name: 'Cash',
          type: AccountType.cash.name,
          openingBalanceMinor: 0,
          createdAt: now,
        ),
      );
      b.insert(
        db.accounts,
        AccountsCompanion.insert(
          id: 'acc_bank',
          name: 'Bank',
          type: AccountType.bank.name,
          openingBalanceMinor: 0,
          createdAt: now,
        ),
      );
      b.insert(
        db.accounts,
        AccountsCompanion.insert(
          id: 'acc_savings',
          name: 'Savings',
          type: AccountType.savings.name,
          openingBalanceMinor: 0,
          createdAt: now,
        ),
      );
      b.insert(
        db.accounts,
        AccountsCompanion.insert(
          id: 'acc_invest',
          name: 'Investments',
          type: AccountType.investment.name,
          openingBalanceMinor: 0,
          createdAt: now,
        ),
      );

      final expenses = [
        'Food',
        'Transport',
        'Shopping',
        'Bills',
        'Housing',
        'Health',
        'Family',
        'Education',
        'Entertainment',
        'Travel',
        'Personal',
        'Other',
      ];
      for (var i = 0; i < expenses.length; i++) {
        b.insert(
          db.categories,
          CategoriesCompanion.insert(
            id: 'exp_${expenses[i].toLowerCase()}',
            name: expenses[i],
            kind: CategoryKind.expense.name,
            sortOrder: Value(i),
          ),
        );
      }
      final incomes = [
        'Salary',
        'Bonus',
        'Freelance',
        'Business',
        'Side Income',
        'Gift',
        'Refund',
        'Other',
      ];
      for (var i = 0; i < incomes.length; i++) {
        b.insert(
          db.categories,
          CategoriesCompanion.insert(
            id: 'inc_${incomes[i].toLowerCase().replaceAll(' ', '_')}',
            name: incomes[i],
            kind: CategoryKind.income.name,
            sortOrder: Value(i),
          ),
        );
      }

      for (final feature in AppFeature.values) {
        b.insert(
          db.featureSettings,
          FeatureSettingsCompanion.insert(
            featureKey: feature.key,
            enabled: defaultFeatureStates[feature] ?? false,
          ),
        );
      }
    });
  }

  Future<Map<AppFeature, bool>> loadFeatures() async {
    final rows = await db.select(db.featureSettings).get();
    final map = Map<AppFeature, bool>.from(defaultFeatureStates);
    for (final row in rows) {
      final match = AppFeature.values.where((f) => f.key == row.featureKey);
      if (match.isEmpty) continue;
      map[match.first] = row.enabled;
    }
    return map;
  }

  Future<void> setFeature(AppFeature feature, bool enabled) async {
    await db.into(db.featureSettings).insertOnConflictUpdate(
          FeatureSettingsCompanion.insert(
            featureKey: feature.key,
            enabled: enabled,
          ),
        );
  }

  Future<List<Account>> accounts({bool includeArchived = false}) async {
    final query = db.select(db.accounts);
    if (!includeArchived) {
      query.where((t) => t.archived.equals(false));
    }
    return (await query.get()).map(mapAccount).toList();
  }

  Future<Account?> accountById(String id) async {
    final row = await (db.select(db.accounts)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : mapAccount(row);
  }

  Future<void> upsertAccount(Account account) async {
    await db.into(db.accounts).insertOnConflictUpdate(
          AccountsCompanion.insert(
            id: account.id,
            name: account.name,
            type: account.type.name,
            openingBalanceMinor: account.openingBalance.minor,
            currency: Value(account.currency),
            notes: Value(account.notes),
            archived: Value(account.archived),
            createdAt: account.createdAt,
          ),
        );
  }

  Future<List<Category>> categories({CategoryKind? kind}) async {
    final query = db.select(db.categories)
      ..where((t) => t.archived.equals(false));
    if (kind != null) query.where((t) => t.kind.equals(kind.name));
    query.orderBy([(t) => OrderingTerm.asc(t.sortOrder)]);
    return (await query.get()).map(mapCategory).toList();
  }

  Future<Category?> categoryById(String id) async {
    final row = await (db.select(db.categories)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : mapCategory(row);
  }

  Future<void> upsertCategory(Category category) async {
    await db.into(db.categories).insertOnConflictUpdate(
          CategoriesCompanion.insert(
            id: category.id,
            name: category.name,
            kind: category.kind.name,
            parentId: Value(category.parentId),
            icon: Value(category.icon),
            sortOrder: Value(category.sortOrder),
            archived: Value(category.archived),
          ),
        );
  }

  Future<List<FinanceTransaction>> transactions({
    DateTime? from,
    DateTime? to,
    TransactionType? type,
  }) async {
    final query = db.select(db.transactions);
    if (from != null) query.where((t) => t.date.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.date.isSmallerThanValue(to));
    if (type != null) query.where((t) => t.type.equals(type.name));
    query.orderBy([(t) => OrderingTerm.desc(t.date)]);
    return (await query.get()).map(mapTransaction).toList();
  }

  Future<FinanceTransaction?> transactionById(String id) async {
    final row =
        await (db.select(db.transactions)..where((t) => t.id.equals(id)))
            .getSingleOrNull();
    return row == null ? null : mapTransaction(row);
  }

  Future<void> insertTransaction(FinanceTransaction tx) async {
    await db.into(db.transactions).insert(
          TransactionsCompanion.insert(
            id: tx.id,
            type: tx.type.name,
            amountMinor: tx.amount.minor,
            date: tx.date,
            accountId: tx.accountId,
            toAccountId: Value(tx.toAccountId),
            categoryId: Value(tx.categoryId),
            subcategoryId: Value(tx.subcategoryId),
            paymentMethod: Value(tx.paymentMethod),
            incomeSourceId: Value(tx.incomeSourceId),
            note: Value(tx.note),
            tagsJson: Value('[${tx.tags.map((e) => '"$e"').join(',')}]'),
            attachmentPath: Value(tx.attachmentPath),
            allocationItemId: Value(tx.allocationItemId),
            goalId: Value(tx.goalId),
            investmentId: Value(tx.investmentId),
            createdAt: tx.createdAt,
          ),
        );
  }

  Future<void> deleteTransaction(String id) async {
    await (db.delete(db.transactions)..where((t) => t.id.equals(id))).go();
  }

  Future<SalaryProfile?> activeSalary() async {
    final row = await (db.select(db.salaryProfiles)
          ..where((t) => t.active.equals(true))
          ..orderBy([(t) => OrderingTerm.desc(t.effectiveFrom)])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : mapSalary(row);
  }

  Future<List<SalaryHistoryEntry>> salaryHistory() async {
    final rows = await (db.select(db.salaryHistory)
          ..orderBy([(t) => OrderingTerm.desc(t.effectiveDate)]))
        .get();
    return rows.map(mapSalaryHistory).toList();
  }

  Future<void> insertSalaryProfile(SalaryProfile profile) async {
    await db.into(db.salaryProfiles).insertOnConflictUpdate(
          SalaryProfilesCompanion.insert(
            id: profile.id,
            baseAmountMinor: profile.baseAmount.minor,
            payDay: profile.payDay,
            frequency: Value(profile.frequency),
            currency: Value(profile.currency),
            source: Value(profile.source),
            effectiveFrom: profile.effectiveFrom,
            active: Value(profile.active),
          ),
        );
  }

  Future<void> insertSalaryHistory(SalaryHistoryEntry entry) async {
    await db.into(db.salaryHistory).insert(
          SalaryHistoryCompanion.insert(
            id: entry.id,
            previousAmountMinor: entry.previousAmount.minor,
            newAmountMinor: entry.newAmount.minor,
            effectiveDate: entry.effectiveDate,
            reason: Value(entry.reason),
            notes: Value(entry.notes),
          ),
        );
  }

  Future<List<AllocationTemplateItem>> templates() async {
    final rows = await (db.select(db.allocationTemplates)
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
    return rows.map(mapTemplate).toList();
  }

  Future<void> replaceTemplates(List<AllocationTemplateItem> items) async {
    await db.delete(db.allocationTemplates).go();
    await db.batch((b) {
      for (final item in items) {
        b.insert(
          db.allocationTemplates,
          AllocationTemplatesCompanion.insert(
            id: item.id,
            name: item.name,
            kind: item.kind.name,
            plannedAmountMinor: item.plannedAmount.minor,
            categoryId: Value(item.categoryId),
            goalId: Value(item.goalId),
            investmentId: Value(item.investmentId),
            billId: Value(item.billId),
            loanId: Value(item.loanId),
            accountId: Value(item.accountId),
            sortOrder: Value(item.sortOrder),
          ),
        );
      }
    });
  }

  Future<MonthlyPlan?> planFor(int year, int month) async {
    final row = await (db.select(db.monthlyPlans)
          ..where((t) => t.year.equals(year) & t.month.equals(month)))
        .getSingleOrNull();
    return row == null ? null : mapPlan(row);
  }

  Future<MonthlyPlan?> planById(String id) async {
    final row = await (db.select(db.monthlyPlans)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : mapPlan(row);
  }

  Future<void> upsertPlan(MonthlyPlan plan) async {
    await db.into(db.monthlyPlans).insertOnConflictUpdate(
          MonthlyPlansCompanion.insert(
            id: plan.id,
            year: plan.year,
            month: plan.month,
            expectedIncomeMinor: plan.expectedIncome.minor,
            confirmed: Value(plan.confirmed),
            createdAt: plan.createdAt,
          ),
        );
  }

  Future<List<AllocationItem>> allocationsFor(String planId) async {
    final rows = await (db.select(db.allocationItems)
          ..where((t) => t.planId.equals(planId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
    return rows.map(mapAllocation).toList();
  }

  Future<AllocationItem?> allocationById(String id) async {
    final row =
        await (db.select(db.allocationItems)..where((t) => t.id.equals(id)))
            .getSingleOrNull();
    return row == null ? null : mapAllocation(row);
  }

  Future<void> upsertAllocation(AllocationItem item) async {
    await db.into(db.allocationItems).insertOnConflictUpdate(
          AllocationItemsCompanion.insert(
            id: item.id,
            planId: item.planId,
            name: item.name,
            kind: item.kind.name,
            plannedAmountMinor: item.plannedAmount.minor,
            actualAmountMinor: Value(item.actualAmount?.minor),
            status: Value(item.status.name),
            categoryId: Value(item.categoryId),
            goalId: Value(item.goalId),
            investmentId: Value(item.investmentId),
            billId: Value(item.billId),
            loanId: Value(item.loanId),
            accountId: Value(item.accountId),
            skipReason: Value(item.skipReason?.name),
            skipNote: Value(item.skipNote),
            sortOrder: Value(item.sortOrder),
          ),
        );
  }

  Future<List<SavingsGoal>> savingsGoals() async {
    final rows = await (db.select(db.savingsGoals)
          ..where((t) => t.archived.equals(false)))
        .get();
    return rows.map(mapGoal).toList();
  }

  Future<SavingsGoal?> savingsGoalById(String id) async {
    final row =
        await (db.select(db.savingsGoals)..where((t) => t.id.equals(id)))
            .getSingleOrNull();
    return row == null ? null : mapGoal(row);
  }

  Future<void> upsertSavingsGoal(SavingsGoal goal) async {
    await db.into(db.savingsGoals).insertOnConflictUpdate(
          SavingsGoalsCompanion.insert(
            id: goal.id,
            name: goal.name,
            targetAmountMinor: goal.targetAmount.minor,
            currentAmountMinor: Value(goal.currentAmount.minor),
            targetDate: Value(goal.targetDate),
            monthlyContributionMinor: Value(goal.monthlyContribution?.minor),
            priority: Value(goal.priority),
            notes: Value(goal.notes),
            archived: Value(goal.archived),
          ),
        );
  }

  Future<List<Investment>> investments() async {
    return (await db.select(db.investments).get()).map(mapInvestment).toList();
  }

  Future<void> upsertInvestment(Investment item) async {
    await db.into(db.investments).insertOnConflictUpdate(
          InvestmentsCompanion.insert(
            id: item.id,
            name: item.name,
            type: item.type,
            amountMinor: item.amount.minor,
            date: item.date,
            accountId: Value(item.accountId),
            currentValueMinor: Value(item.currentValue?.minor),
            notes: Value(item.notes),
          ),
        );
  }

  Future<List<Budget>> budgetsFor(int year, int month) async {
    final rows = await (db.select(db.budgets)
          ..where((t) => t.year.equals(year) & t.month.equals(month)))
        .get();
    return rows.map(mapBudget).toList();
  }

  Future<void> upsertBudget(Budget budget) async {
    await db.into(db.budgets).insertOnConflictUpdate(
          BudgetsCompanion.insert(
            id: budget.id,
            categoryId: budget.categoryId,
            amountMinor: budget.amount.minor,
            year: budget.year,
            month: budget.month,
            warn75: Value(budget.warn75),
            warn90: Value(budget.warn90),
            warn100: Value(budget.warn100),
          ),
        );
  }

  Future<List<RecurringBill>> bills() async {
    final rows = await (db.select(db.bills)
          ..where((t) => t.archived.equals(false)))
        .get();
    return rows.map(mapBill).toList();
  }

  Future<void> upsertBill(RecurringBill bill) async {
    await db.into(db.bills).insertOnConflictUpdate(
          BillsCompanion.insert(
            id: bill.id,
            name: bill.name,
            amountMinor: bill.amount.minor,
            dueDay: bill.dueDay,
            frequency: Value(bill.frequency),
            accountId: Value(bill.accountId),
            categoryId: Value(bill.categoryId),
            reminder: Value(bill.reminder),
            autoPlan: Value(bill.autoPlan),
            archived: Value(bill.archived),
          ),
        );
  }

  Future<List<Loan>> loans() async {
    final rows = await (db.select(db.loans)
          ..where((t) => t.archived.equals(false)))
        .get();
    return rows.map(mapLoan).toList();
  }

  Future<void> upsertLoan(Loan loan) async {
    await db.into(db.loans).insertOnConflictUpdate(
          LoansCompanion.insert(
            id: loan.id,
            name: loan.name,
            principalMinor: loan.principal.minor,
            interestRate: loan.interestRate,
            emiMinor: loan.emi.minor,
            startDate: loan.startDate,
            endDate: loan.endDate,
            remainingMinor: loan.remaining.minor,
            accountId: Value(loan.accountId),
            archived: Value(loan.archived),
          ),
        );
  }

  Future<List<FinancialGoal>> financialGoals() async {
    return (await db.select(db.financialGoals).get())
        .map(mapFinancialGoal)
        .toList();
  }

  Future<void> upsertFinancialGoal(FinancialGoal goal) async {
    await db.into(db.financialGoals).insertOnConflictUpdate(
          FinancialGoalsCompanion.insert(
            id: goal.id,
            name: goal.name,
            targetAmountMinor: goal.targetAmount.minor,
            currentAmountMinor: Value(goal.currentAmount.minor),
            deadline: Value(goal.deadline),
            requiredMonthlyMinor: Value(goal.requiredMonthly?.minor),
            kind: Value(goal.kind),
            notes: Value(goal.notes),
          ),
        );
  }

  Future<List<FinanceNote>> notes() async {
    final rows = await (db.select(db.notes)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
    return rows.map(mapNote).toList();
  }

  Future<void> insertNote(FinanceNote note) async {
    await db.into(db.notes).insert(
          NotesCompanion.insert(
            id: note.id,
            body: note.body,
            createdAt: note.createdAt,
            transactionId: Value(note.transactionId),
            allocationId: Value(note.allocationId),
            goalId: Value(note.goalId),
            monthKey: Value(note.monthKey),
            accountId: Value(note.accountId),
          ),
        );
  }

  Future<void> audit(String action, [String? payload]) async {
    await db.into(db.auditLogs).insert(
          AuditLogsCompanion.insert(
            id: newId(),
            action: action,
            at: DateTime.now(),
            payload: Value(payload),
          ),
        );
  }

  Future<List<AuditEvent>> auditLog() async {
    final rows = await (db.select(db.auditLogs)
          ..orderBy([(t) => OrderingTerm.desc(t.at)]))
        .get();
    return rows.map(mapAudit).toList();
  }

  Future<void> insertNetWorthSnapshot({
    required Money assets,
    required Money liabilities,
  }) async {
    await db.into(db.netWorthSnapshots).insert(
          NetWorthSnapshotsCompanion.insert(
            id: newId(),
            at: DateTime.now(),
            assetsMinor: assets.minor,
            liabilitiesMinor: liabilities.minor,
            netMinor: assets.minor - liabilities.minor,
          ),
        );
  }

  Future<void> clearAll() async {
    await db.transaction(() async {
      await db.delete(db.transactions).go();
      await db.delete(db.allocationItems).go();
      await db.delete(db.monthlyPlans).go();
      await db.delete(db.allocationTemplates).go();
      await db.delete(db.savingsGoals).go();
      await db.delete(db.investments).go();
      await db.delete(db.budgets).go();
      await db.delete(db.bills).go();
      await db.delete(db.loans).go();
      await db.delete(db.financialGoals).go();
      await db.delete(db.notes).go();
      await db.delete(db.salaryHistory).go();
      await db.delete(db.salaryProfiles).go();
      await db.delete(db.incomeSources).go();
      await db.delete(db.auditLogs).go();
      await db.delete(db.netWorthSnapshots).go();
      await db.delete(db.categories).go();
      await db.delete(db.accounts).go();
      await db.delete(db.featureSettings).go();
      await db.delete(db.appSettings).go();
    });
  }
}
