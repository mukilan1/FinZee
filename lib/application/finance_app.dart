import '../core/errors.dart';
import '../core/features.dart';
import '../core/ids.dart';
import '../core/money.dart';
import '../core/validators.dart';
import '../database/finance_repository.dart';
import '../domain/entities.dart';
import 'backup_service.dart';
import 'financial_calculation_service.dart';
import 'monthly_planning_service.dart';

class FinanceApp {
  FinanceApp(this.repo)
      : planning = MonthlyPlanningService(repo),
        backup = BackupService(repo);

  final FinanceRepository repo;
  final MonthlyPlanningService planning;
  final BackupService backup;
  final calc = FinancialCalculationService();

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
  }

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
      extraAlerts: localAlerts(d),
    );
  }

  List<LocalAlert> localAlerts(DateTime now) {
    final alerts = <LocalAlert>[];
    if (enabled(AppFeature.salaryPlanning) && salary != null && salary!.payDay == now.day) {
      alerts.add(
        const LocalAlert(
          id: 'salary_today',
          title: 'Salary expected today',
          body: 'Your salary is expected today.',
          kind: 'salary',
        ),
      );
    }
    if (enabled(AppFeature.salaryPlanning)) {
      final pending =
          allocations.where((a) => a.status == AllocationStatus.pending).length;
      if (pending > 0) {
        alerts.add(
          LocalAlert(
            id: 'alloc_pending',
            title: 'Allocations pending',
            body: 'You have $pending monthly allocations pending.',
            kind: 'allocation',
          ),
        );
      }
    }
    return alerts;
  }

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
      createdAt: DateTime.now(),
    );
    await repo.insertTransaction(tx);
    await repo.audit('TRANSACTION_CREATED', tx.id);
    await reload();
  }

  Future<void> deleteTransaction(String id) async {
    await repo.deleteTransaction(id);
    await repo.audit('TRANSACTION_DELETED', id);
    await reload();
  }

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
}
