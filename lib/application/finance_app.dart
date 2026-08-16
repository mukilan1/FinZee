import 'dart:convert';

import '../application/app_lock_service.dart';
import '../core/errors.dart';
import '../core/features.dart';
import '../core/ids.dart';
import '../core/money.dart';
import '../core/validators.dart';
import '../database/finance_repository.dart';
import '../domain/entities.dart';
import 'alert_service.dart';
import 'backup_service.dart';
import 'demo_data.dart';
import 'financial_calculation_service.dart';
import 'monthly_planning_service.dart';

class FinanceApp {
  FinanceApp(
    this.repo, {
    this.loadDemoIfEmpty = false,
    AppLockService? lockService,
  })  : planning = MonthlyPlanningService(repo),
        backup = BackupService(repo),
        lockService = lockService ?? AppLockService();

  final FinanceRepository repo;
  final AppLockService lockService;
  final MonthlyPlanningService planning;
  final BackupService backup;
  final calc = FinancialCalculationService();
  final alertsEngine = AlertService();
  final bool loadDemoIfEmpty;
  Set<String> readAlertIds = {};
  Set<String> dismissedAlertIds = {};

  Map<AppFeature, bool> features = Map.from(defaultFeatureStates);
  List<Account> accounts = [];
  List<Category> categories = [];
  List<FinanceTransaction> transactions = [];
  List<AllocationItem> allocations = [];
  MonthlyPlan? plan;
  SalaryProfile? salary;
  List<SavingsGoal> savingsGoals = [];
  List<Investment> investments = [];
  List<Budget> budgets = [];
  List<RecurringBill> bills = [];
  List<Loan> loans = [];
  List<FinancialGoal> financialGoals = [];
  List<FinanceNote> notes = [];
  List<AllocationTemplateItem> templates = [];
  List<SalaryHistoryEntry> salaryHistory = [];
  List<AuditEvent> audits = [];

  bool enabled(AppFeature feature) => features[feature] ?? false;

  Future<void> bootstrap() async {
    await repo.seedIfEmpty();
    await reload();
    if (loadDemoIfEmpty && transactions.isEmpty) {
      await DemoDataLoader(this).load();
    }
    if (_lockEnabled) unlocked = false;
  }

  Future<void> loadSampleData({bool reset = false}) =>
      DemoDataLoader(this).load(reset: reset);

  Future<void> reload() async {
    features = await repo.loadFeatures();
    accounts = await repo.accounts();
    categories = await repo.categories();
    transactions = await repo.transactions();
    salary = await repo.activeSalary();
    salaryHistory = await repo.salaryHistory();
    savingsGoals = await repo.savingsGoals();
    investments = await repo.investments();
    bills = await repo.bills();
    loans = await repo.loans();
    financialGoals = await repo.financialGoals();
    notes = await repo.notes();
    templates = await repo.templates();
    audits = await repo.auditLog();
    final now = DateTime.now();
    budgets = await repo.budgetsFor(now.year, now.month);
    plan = await repo.planFor(now.year, now.month);
    allocations = plan == null ? [] : await repo.allocationsFor(plan!.id);
    await _loadLock();
    await _loadAlertState();
  }

  DashboardSnapshot dashboard([DateTime? now]) {
    final d = now ?? DateTime.now();
    return calc.dashboard(
      range: MonthRange(d.year, d.month),
      accounts: accounts,
      transactions: transactions,
      categories: categories,
      allocations: enabled(AppFeature.salaryPlanning) ? allocations : const [],
      investments: enabled(AppFeature.investments) ? investments : const [],
      loans: enabled(AppFeature.loans) ? loans : const [],
      budgets: enabled(AppFeature.budgets) ? budgets : const [],
      extraAlerts: allAlerts(d),
    );
  }

  List<LocalAlert> allAlerts([DateTime? now]) {
    final d = now ?? DateTime.now();
    return alertsEngine
        .build(
          now: d,
          features: features,
          accounts: accounts,
          transactions: transactions,
          allocations: enabled(AppFeature.salaryPlanning) ? allocations : const [],
          plan: enabled(AppFeature.salaryPlanning) ? plan : null,
          salary: enabled(AppFeature.salaryPlanning) ? salary : null,
          budgets: enabled(AppFeature.budgets) ? budgets : const [],
          bills: enabled(AppFeature.bills) ? bills : const [],
          loans: enabled(AppFeature.loans) ? loans : const [],
          savingsGoals: enabled(AppFeature.savingsGoals) ? savingsGoals : const [],
          investments: enabled(AppFeature.investments) ? investments : const [],
          financialGoals:
              enabled(AppFeature.financialGoals) ? financialGoals : const [],
        )
        .where((a) => !dismissedAlertIds.contains(a.id))
        .map((a) => a.copyWith(read: readAlertIds.contains(a.id)))
        .toList();
  }

  int unreadAlertCount([DateTime? now]) =>
      allAlerts(now).where((a) => !a.read).length;

  Future<void> markAlertsRead(Iterable<String> ids) async {
    readAlertIds = {...readAlertIds, ...ids};
    await repo.setSetting('alert_read_ids', jsonEncode(readAlertIds.toList()));
  }

  Future<void> dismissAlert(String id) async {
    dismissedAlertIds = {...dismissedAlertIds, id};
    readAlertIds = {...readAlertIds, id};
    await repo.setSetting(
      'alert_dismissed_ids',
      jsonEncode(dismissedAlertIds.toList()),
    );
    await repo.setSetting('alert_read_ids', jsonEncode(readAlertIds.toList()));
    await repo.audit('ALERT_DISMISSED', id);
  }

  Future<void> markInboxRead() async {
    await markAlertsRead(allAlerts().map((a) => a.id));
  }

  Future<void> _loadAlertState() async {
    readAlertIds = _decodeIdSet(await repo.setting('alert_read_ids'));
    dismissedAlertIds = _decodeIdSet(await repo.setting('alert_dismissed_ids'));
  }

  Set<String> _decodeIdSet(String? raw) {
    if (raw == null || raw.isEmpty) return {};
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return {};
      return decoded.whereType<String>().toSet();
    } catch (_) {
      return {};
    }
  }

  List<LocalAlert> localAlerts(DateTime now) => allAlerts(now);

  Future<void> setFeature(AppFeature feature, bool on) async {
    await repo.setFeature(feature, on);
    await repo.audit(on ? 'FEATURE_ENABLED' : 'FEATURE_DISABLED', feature.key);
    await reload();
  }

  Future<void> addTransaction({
    required TransactionType type,
    required Money amount,
    required DateTime date,
    required String accountId,
    String? toAccountId,
    String? categoryId,
    String? note,
    String? goalId,
  }) async {
    requirePositiveAmount(amount);
    requireValidDate(date);
    requireAccount(await repo.accountById(accountId));
    if (type == TransactionType.transfer) {
      if (toAccountId == null) {
        throw const ValidationError('Transfer requires a destination account.');
      }
      requireDifferentAccounts(accountId, toAccountId);
      requireAccount(await repo.accountById(toAccountId));
    }
    if (type == TransactionType.expense && categoryId != null) {
      requireCategory(await repo.categoryById(categoryId));
    }
    if (type == TransactionType.saving) {
      toAccountId ??= 'acc_savings';
      if (toAccountId == accountId) {
        throw const ValidationError('Savings must move into a different account.');
      }
    }
    String? investmentId;
    if (type == TransactionType.investment) {
      investmentId = newId();
      await repo.upsertInvestment(
        Investment(
          id: investmentId,
          name: note?.isNotEmpty == true ? note! : 'Investment',
          type: 'custom',
          amount: amount,
          date: date,
          accountId: accountId,
          currentValue: amount,
        ),
      );
    }
    if (type == TransactionType.saving && goalId != null) {
      final goal = await repo.savingsGoalById(goalId);
      if (goal != null) {
        await repo.upsertSavingsGoal(
          SavingsGoal(
            id: goal.id,
            name: goal.name,
            targetAmount: goal.targetAmount,
            currentAmount: goal.currentAmount + amount,
            targetDate: goal.targetDate,
            monthlyContribution: goal.monthlyContribution,
            priority: goal.priority,
            notes: goal.notes,
          ),
        );
      }
    }
    final tx = FinanceTransaction(
      id: newId(),
      type: type,
      amount: amount,
      date: date,
      accountId: accountId,
      toAccountId: toAccountId,
      categoryId: categoryId,
      note: note,
      goalId: goalId,
      investmentId: investmentId,
      createdAt: DateTime.now(),
    );
    await repo.insertTransaction(tx);
    await repo.audit('TRANSACTION_CREATED', tx.id);
    await reload();
  }

  Future<void> deleteTransaction(String id) async {
    final tx = await repo.transactionById(id);
    if (tx == null) return;
    if (tx.allocationItemId != null) {
      throw const ValidationError(
        'This transaction is tied to a monthly allocation and cannot be deleted.',
      );
    }
    if (tx.type == TransactionType.saving && tx.goalId != null) {
      final goal = await repo.savingsGoalById(tx.goalId!);
      if (goal != null) {
        final next = goal.currentAmount.minor - tx.amount.minor;
        await repo.upsertSavingsGoal(
          SavingsGoal(
            id: goal.id,
            name: goal.name,
            targetAmount: goal.targetAmount,
            currentAmount: Money(next < 0 ? 0 : next),
            targetDate: goal.targetDate,
            monthlyContribution: goal.monthlyContribution,
            priority: goal.priority,
            notes: goal.notes,
          ),
        );
      }
    }
    await repo.deleteTransaction(id);
    await repo.audit('TRANSACTION_DELETED', id);
    await reload();
  }

  Future<void> recordSalaryIncome({String? accountId, DateTime? date}) async {
    if (!enabled(AppFeature.salaryPlanning)) {
      throw const FeatureUnavailableError('Salary planning is disabled.');
    }
    if (salary == null) {
      throw const ValidationError('Set a salary profile first.');
    }
    final when = date ?? DateTime.now();
    final already = transactions.any(
      (t) =>
          t.type == TransactionType.income &&
          t.categoryId == 'inc_salary' &&
          t.date.year == when.year &&
          t.date.month == when.month,
    );
    if (already) {
      throw const ValidationError('Salary for this month is already recorded.');
    }
    await addTransaction(
      type: TransactionType.income,
      amount: salary!.baseAmount,
      date: when,
      accountId: accountId ?? 'acc_bank',
      categoryId: 'inc_salary',
      note: 'Salary',
    );
  }

  bool get lockEnabled => _lockEnabled;
  bool unlocked = true;
  bool _lockEnabled = false;

  Future<void> _loadLock() async {
    _lockEnabled = (await repo.setting('lock_enabled')) == '1';
    if (!_lockEnabled) unlocked = true;
  }

  Future<bool> deviceLockAvailable() => lockService.isDeviceSupported();

  Future<void> enableAppLock() async {
    if (!await lockService.isDeviceSupported()) {
      throw const AuthenticationError(
        'Device security is not available on this device.',
      );
    }
    final ok = await lockService.authenticate(
      reason: 'Confirm enabling app lock for FinZee',
    );
    if (!ok) {
      throw const AuthenticationError('Device authentication was cancelled.');
    }
    await repo.setSetting('lock_enabled', '1');
    _lockEnabled = true;
    unlocked = true;
    await repo.audit('FEATURE_ENABLED', 'app_lock');
    await reload();
  }

  Future<void> disableAppLock() async {
    if (_lockEnabled) {
      final ok = await lockService.authenticate(
        reason: 'Confirm disabling app lock for FinZee',
      );
      if (!ok) {
        throw const AuthenticationError('Device authentication was cancelled.');
      }
    }
    await repo.setSetting('lock_enabled', '0');
    _lockEnabled = false;
    unlocked = true;
    await repo.audit('FEATURE_DISABLED', 'app_lock');
    await reload();
  }

  Future<bool> unlockApp() async {
    final ok = await lockService.authenticate(
      reason: 'Unlock FinZee',
    );
    if (ok) unlocked = true;
    return ok;
  }

  void lockApp() {
    if (_lockEnabled) unlocked = false;
  }

  Future<bool> authenticateSensitiveAction(String reason) =>
      lockService.authenticate(reason: reason);

  Future<void> upsertAccount(Account account) async {
    requireValidCurrency(account.currency);
    await repo.upsertAccount(account);
    await repo.audit('ACCOUNT_CREATED', account.id);
    await reload();
  }

  Future<void> upsertCategory(Category category) async {
    await repo.upsertCategory(category);
    await reload();
  }

  Future<void> saveSalary(SalaryProfile profile) async {
    if (!enabled(AppFeature.salaryPlanning)) {
      throw const FeatureUnavailableError('Salary planning is disabled.');
    }
    requirePositiveAmount(profile.baseAmount);
    requirePayDay(profile.payDay);
    final previous = salary;
    await repo.insertSalaryProfile(profile);
    if (previous != null && previous.baseAmount != profile.baseAmount) {
      await repo.insertSalaryHistory(
        SalaryHistoryEntry(
          id: newId(),
          previousAmount: previous.baseAmount,
          newAmount: profile.baseAmount,
          effectiveDate: profile.effectiveFrom,
          reason: 'Salary revision',
        ),
      );
      await repo.audit('SALARY_UPDATED', profile.id);
    } else {
      await repo.audit('SALARY_CREATED', profile.id);
    }
    await reload();
  }

  Future<void> saveTemplate(List<AllocationTemplateItem> items) async {
    await repo.replaceTemplates(items);
    await reload();
  }

  Future<void> generateThisMonth() async {
    final now = DateTime.now();
    await planning.generatePlan(
      year: now.year,
      month: now.month,
      features: features,
    );
    await reload();
  }

  Future<void> confirmThisMonth() async {
    if (plan == null) throw const ValidationError('No plan to confirm.');
    await planning.confirmPlan(plan!.id);
    await reload();
  }

  Future<void> completeAllocation(String id, Money actual, String accountId) async {
    await planning.completeAllocation(
      allocationId: id,
      actual: actual,
      accountId: accountId,
    );
    await reload();
  }

  Future<void> skipAllocation(String id, SkipReason reason, String? note) async {
    await planning.skipAllocation(allocationId: id, reason: reason, note: note);
    await reload();
  }

  Future<void> upsertSavingsGoal(SavingsGoal goal) async {
    await repo.upsertSavingsGoal(goal);
    await reload();
  }

  Future<void> upsertInvestment(Investment item) async {
    await repo.upsertInvestment(item);
    await reload();
  }

  Future<void> upsertBudget(Budget budget) async {
    await repo.upsertBudget(budget);
    await reload();
  }

  Future<void> upsertBill(RecurringBill bill) async {
    await repo.upsertBill(bill);
    await reload();
  }

  Future<void> upsertLoan(Loan loan) async {
    await repo.upsertLoan(loan);
    await reload();
  }

  Future<void> upsertFinancialGoal(FinancialGoal goal) async {
    await repo.upsertFinancialGoal(goal);
    await reload();
  }

  Future<void> addNote(String body, {String? monthKey, String? goalId}) async {
    await repo.insertNote(
      FinanceNote(
        id: newId(),
        body: body,
        createdAt: DateTime.now(),
        monthKey: monthKey,
        goalId: goalId,
      ),
    );
    await reload();
  }

  MonthlyReport monthlyReport([DateTime? now]) {
    final d = now ?? DateTime.now();
    return calc.monthlyReport(
      range: MonthRange(d.year, d.month),
      transactions: transactions,
      categories: categories,
      allocations: allocations,
    );
  }

  YearlyReport yearlyReport([DateTime? now]) {
    final d = now ?? DateTime.now();
    final snap = dashboard(d);
    return calc.yearlyReport(
      year: d.year,
      transactions: transactions,
      netWorth: snap.netWorth,
    );
  }

  Future<void> updateTransaction(FinanceTransaction next) async {
    final prev = await repo.transactionById(next.id);
    if (prev == null) return;
    requirePositiveAmount(next.amount);
    requireValidDate(next.date);
    if (prev.allocationItemId != null) {
      if (prev.amount != next.amount ||
          prev.type != next.type ||
          prev.accountId != next.accountId ||
          prev.toAccountId != next.toAccountId) {
        throw const ValidationError(
          'Allocation-linked transactions can only change date or note.',
        );
      }
    }
    if (prev.type == TransactionType.saving && prev.goalId != null) {
      final oldGoal = await repo.savingsGoalById(prev.goalId!);
      if (oldGoal != null) {
        final revertedMinor = oldGoal.currentAmount.minor - prev.amount.minor;
        await repo.upsertSavingsGoal(
          SavingsGoal(
            id: oldGoal.id,
            name: oldGoal.name,
            targetAmount: oldGoal.targetAmount,
            currentAmount: Money(revertedMinor < 0 ? 0 : revertedMinor),
            targetDate: oldGoal.targetDate,
            monthlyContribution: oldGoal.monthlyContribution,
            priority: oldGoal.priority,
            notes: oldGoal.notes,
          ),
        );
      }
    }
    if (next.type == TransactionType.saving && next.goalId != null) {
      final goal = await repo.savingsGoalById(next.goalId!);
      if (goal != null) {
        await repo.upsertSavingsGoal(
          SavingsGoal(
            id: goal.id,
            name: goal.name,
            targetAmount: goal.targetAmount,
            currentAmount: goal.currentAmount + next.amount,
            targetDate: goal.targetDate,
            monthlyContribution: goal.monthlyContribution,
            priority: goal.priority,
            notes: goal.notes,
          ),
        );
      }
    }
    await repo.upsertTransaction(next);
    await repo.audit('TRANSACTION_UPDATED', next.id);
    await reload();
  }

  Future<void> deleteAccount(String id) async {
    final used = transactions.any((t) => t.accountId == id || t.toAccountId == id);
    if (used) {
      throw const ValidationError(
        'This account has transactions. Archive it or move the history first.',
      );
    }
    if (accounts.where((a) => !a.archived).length <= 1) {
      throw const ValidationError('Keep at least one account.');
    }
    await repo.deleteAccount(id);
    await repo.audit('ACCOUNT_DELETED', id);
    await reload();
  }

  Future<void> archiveAccount(String id) async {
    final matches = accounts.where((a) => a.id == id);
    if (matches.isEmpty) return;
    final account = matches.first;
    await repo.upsertAccount(
      Account(
        id: account.id,
        name: account.name,
        type: account.type,
        openingBalance: account.openingBalance,
        currency: account.currency,
        notes: account.notes,
        archived: true,
        createdAt: account.createdAt,
      ),
    );
    await repo.audit('ACCOUNT_ARCHIVED', id);
    await reload();
  }

  Future<void> deleteCategory(String id) async {
    final used = transactions.any((t) => t.categoryId == id);
    if (used) {
      throw const ValidationError(
        'This category is used by transactions and cannot be deleted.',
      );
    }
    await repo.deleteCategory(id);
    await repo.audit('CATEGORY_DELETED', id);
    await reload();
  }

  Future<void> updatePlan({required Money expectedIncome, DateTime? createdAt}) async {
    if (plan == null) throw const ValidationError('No plan to edit.');
    await repo.upsertPlan(
      MonthlyPlan(
        id: plan!.id,
        year: plan!.year,
        month: plan!.month,
        expectedIncome: expectedIncome,
        confirmed: plan!.confirmed,
        createdAt: createdAt ?? plan!.createdAt,
      ),
    );
    await repo.audit('PLAN_UPDATED', plan!.id);
    await reload();
  }

  Future<void> addAllocation({
    required String name,
    required AllocationKind kind,
    required Money plannedAmount,
    String? categoryId,
    String? goalId,
    String? investmentId,
  }) async {
    if (plan == null) throw const ValidationError('Generate a plan first.');
    requirePositiveAmount(plannedAmount);
    await repo.upsertAllocation(
      AllocationItem(
        id: newId(),
        planId: plan!.id,
        name: name,
        kind: kind,
        plannedAmount: plannedAmount,
        categoryId: categoryId,
        goalId: goalId,
        investmentId: investmentId,
        sortOrder: allocations.length,
      ),
    );
    await repo.audit('ALLOCATION_CREATED', name);
    await reload();
  }

  Future<void> updateAllocation(AllocationItem item) async {
    final existing = await repo.allocationById(item.id);
    if (existing == null) throw const ValidationError('Allocation not found.');
    if (existing.status == AllocationStatus.completed ||
        existing.status == AllocationStatus.skipped) {
      throw const ValidationError('Closed allocations cannot be edited.');
    }
    requirePositiveAmount(item.plannedAmount);
    await repo.upsertAllocation(item);
    await repo.audit('ALLOCATION_UPDATED', item.id);
    await reload();
  }

  Future<void> deleteAllocation(String id) async {
    final item = await repo.allocationById(id);
    if (item == null) return;
    if (item.status != AllocationStatus.pending) {
      throw const ValidationError(
        'Only pending allocations can be deleted. Closed items stay in history.',
      );
    }
    if (transactions.any((t) => t.allocationItemId == id)) {
      throw const ValidationError('This allocation already has a transaction.');
    }
    await repo.deleteAllocation(id);
    await repo.audit('ALLOCATION_DELETED', id);
    await reload();
  }

  Future<void> deleteSavingsGoal(String id) async {
    await repo.deleteSavingsGoal(id);
    await repo.audit('GOAL_DELETED', id);
    await reload();
  }

  Future<void> deleteInvestment(String id) async {
    await repo.deleteInvestment(id);
    await repo.audit('INVESTMENT_DELETED', id);
    await reload();
  }

  Future<void> deleteBudget(String id) async {
    await repo.deleteBudget(id);
    await repo.audit('BUDGET_DELETED', id);
    await reload();
  }

  Future<void> deleteBill(String id) async {
    await repo.deleteBill(id);
    await repo.audit('BILL_DELETED', id);
    await reload();
  }

  Future<void> deleteLoan(String id) async {
    await repo.deleteLoan(id);
    await repo.audit('LOAN_DELETED', id);
    await reload();
  }

  Future<void> deleteFinancialGoal(String id) async {
    await repo.deleteFinancialGoal(id);
    await repo.audit('FINANCIAL_GOAL_DELETED', id);
    await reload();
  }

  Future<void> updateNote(FinanceNote note) async {
    await repo.upsertNote(note);
    await reload();
  }

  Future<void> deleteNote(String id) async {
    await repo.deleteNote(id);
    await repo.audit('NOTE_DELETED', id);
    await reload();
  }

  Future<void> wipeAllData({
    required String typedPhrase,
    bool deviceAuthenticated = false,
  }) async {
    if (typedPhrase.trim() != 'DELETE') {
      throw const ValidationError('Type DELETE to confirm wiping this app.');
    }
    if (_lockEnabled && !deviceAuthenticated) {
      throw const AuthenticationError(
        'Device authentication is required to delete all data.',
      );
    }
    await repo.clearAll();
    await repo.seedDefaults();
    readAlertIds = {};
    dismissedAlertIds = {};
    await repo.audit('APP_WIPED');
    await reload();
  }
}
