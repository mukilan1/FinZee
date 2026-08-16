import 'package:drift/native.dart';
import 'package:finzee/application/demo_data.dart';
import 'package:finzee/application/finance_app.dart';
import 'package:finzee/core/errors.dart';
import 'package:finzee/core/features.dart';
import 'package:finzee/core/money.dart';
import 'package:finzee/database/app_database.dart';
import 'package:finzee/database/finance_repository.dart';
import 'package:finzee/domain/entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late FinanceApp app;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    app = FinanceApp(FinanceRepository(db));
    await app.bootstrap();
    await DemoDataLoader(app).load();
  });

  tearDown(() async => db.close());

  test('demo dataset fills every module', () async {
    expect(app.enabled(AppFeature.salaryPlanning), isTrue);
    expect(app.salary!.baseAmount, Money.fromMajor(60000));
    expect(app.salaryHistory, isNotEmpty);
    expect(app.accounts.length, greaterThanOrEqualTo(7));
    expect(app.accounts.any((a) => a.type == AccountType.upi), isTrue);
    expect(app.accounts.any((a) => a.type == AccountType.creditCard), isTrue);
    expect(app.accounts.any((a) => a.type == AccountType.wallet), isTrue);
    expect(app.transactions.length, greaterThan(80));
    expect(app.savingsGoals.length, greaterThanOrEqualTo(3));
    expect(app.financialGoals.length, greaterThanOrEqualTo(3));
    expect(app.investments.length, greaterThanOrEqualTo(4));
    expect(app.bills.length, greaterThanOrEqualTo(5));
    expect(app.loans.length, greaterThanOrEqualTo(2));
    expect(app.budgets.length, greaterThanOrEqualTo(6));
    expect(app.notes.length, greaterThanOrEqualTo(4));
    expect(app.plan, isNotNull);
    expect(app.plan!.confirmed, isTrue);
    expect(app.allocations, isNotEmpty);
    expect(
      app.allocations.any((a) => a.status == AllocationStatus.pending),
      isTrue,
    );
    expect(
      app.allocations.any((a) => a.status == AllocationStatus.partial),
      isTrue,
    );
    expect(
      app.categories.any((c) => c.id == 'exp_subscriptions'),
      isTrue,
    );
  });

  test('demo planned vs actual includes skip reason', () {
    final report = app.monthlyReport();
    expect(report.income.minor, greaterThan(0));
    expect(report.expenses.minor, greaterThan(0));
    expect(report.savings.minor, greaterThan(0));
    final sip = report.plannedVsActual.where((r) => r.name.contains('SIP'));
    expect(sip, isNotEmpty);
    expect(sip.first.actual.isZero, isTrue);
    expect(sip.first.reason, SkipReason.unexpectedExpense);
    expect(sip.first.note, contains('vehicle repair'));
    final food = report.plannedVsActual.where((r) => r.name == 'Food');
    expect(food, isNotEmpty);
    expect(food.first.actual, Money.fromMajor(6000));
    expect(food.first.variance.minor, lessThan(0));
  });

  test('demo dashboard, accounts, budgets, and net worth reconcile', () {
    final dash = app.dashboard();
    expect(dash.income.minor, greaterThan(0));
    expect(dash.expenses.minor, greaterThan(0));
    expect(dash.savings.minor, greaterThan(0));
    expect(dash.recent, isNotEmpty);
    expect(dash.categorySpend, isNotEmpty);
    expect(dash.allocationTotal, greaterThan(0));
    expect(dash.netWorth.minor, isNot(0));

    final balances = app.calc.accountBalances(app.accounts, app.transactions);
    for (final b in balances) {
      expect(b.account.id, isNotEmpty);
    }
    expect(
      balances.any((b) => b.account.id == 'acc_upi'),
      isTrue,
    );
    final foodBudget = app.calc.budgetUsage(
      app.budgets,
      app.transactions
          .where((t) =>
              t.date.year == DateTime.now().year &&
              t.date.month == DateTime.now().month)
          .toList(),
    );
    expect(foodBudget, isNotEmpty);

    final year = app.yearlyReport();
    expect(year.income.minor, greaterThan(dash.income.minor - 1));
    expect(year.savingsRate, greaterThan(0));
  });

  test('demo backup restore keeps the household story', () async {
    final json = await app.backup.exportJson();
    expect(json, contains('Emergency Fund'));
    expect(json, contains('PhonePe UPI'));
    final safety = await app.backup.exportJson();
    await app.backup.restore(json, safetyBackup: safety);
    await app.reload();
    expect(app.transactions.length, greaterThan(80));
    expect(app.savingsGoals.any((g) => g.name == 'Emergency Fund'), isTrue);
    expect(app.allocations.any((a) => a.status == AllocationStatus.skipped), isTrue);
    expect(app.loans.length, greaterThanOrEqualTo(2));
  });

  test('demo still works after optional modules are turned off', () async {
    final before = app.investments.length;
    await app.setFeature(AppFeature.investments, false);
    await app.setFeature(AppFeature.bills, false);
    await app.setFeature(AppFeature.loans, false);
    expect(app.investments.length, before);
    expect(app.dashboard().investments.isZero, isTrue);
    await app.setFeature(AppFeature.investments, true);
    expect(app.dashboard().investments.minor, greaterThanOrEqualTo(0));
  });

  test('new transfer on top of demo data stays a transfer', () async {
    final beforeExpenses = app.dashboard().expenses;
    await app.addTransaction(
      type: TransactionType.transfer,
      amount: Money.fromMajor(200),
      date: DateTime.now(),
      accountId: 'acc_bank',
      toAccountId: 'acc_cash',
      note: 'Extra cash',
    );
    expect(app.dashboard().expenses, beforeExpenses);
  });

  test('salary cannot be recorded twice in the same month', () async {
    expect(
      () => app.recordSalaryIncome(date: DateTime.now()),
      throwsA(isA<ValidationError>()),
    );
  });

  test('allocation-linked transactions cannot be deleted', () async {
    final linked = app.transactions.firstWhere((t) => t.allocationItemId != null);
    expect(
      () => app.deleteTransaction(linked.id),
      throwsA(isA<ValidationError>()),
    );
  });

  test('unlinked expense can be deleted', () async {
    final breakfast = app.transactions.firstWhere((t) => t.note == 'Breakfast');
    final before = app.transactions.length;
    await app.deleteTransaction(breakfast.id);
    expect(app.transactions.length, before - 1);
    expect(app.transactions.any((t) => t.id == breakfast.id), isFalse);
  });

  test('closed allocation cannot be completed again', () async {
    final rent = app.allocations.firstWhere((a) => a.name == 'Rent');
    expect(rent.status, AllocationStatus.completed);
    expect(
      () => app.completeAllocation(rent.id, Money.fromMajor(15000), 'acc_bank'),
      throwsA(isA<ValidationError>()),
    );
  });

  test('savings to a goal increase current amount and can be reversed', () async {
    final before = app.savingsGoals.firstWhere((g) => g.id == 'goal_vacation');
    await app.addTransaction(
      type: TransactionType.saving,
      amount: Money.fromMajor(500),
      date: DateTime.now(),
      accountId: 'acc_bank',
      goalId: 'goal_vacation',
      note: 'Extra Goa',
    );
    final after = app.savingsGoals.firstWhere((g) => g.id == 'goal_vacation');
    expect(after.currentAmount, before.currentAmount + Money.fromMajor(500));
    final extra = app.transactions.firstWhere((t) => t.note == 'Extra Goa');
    await app.deleteTransaction(extra.id);
    final reversed = app.savingsGoals.firstWhere((g) => g.id == 'goal_vacation');
    expect(reversed.currentAmount, before.currentAmount);
  });

  test('PIN lock verifies and rejects the wrong code', () async {
    await app.enablePin('2468');
    expect(app.lockEnabled, isTrue);
    app.unlocked = false;
    expect(() => app.unlockWithPin('0000'), throwsA(isA<AuthenticationError>()));
    await app.unlockWithPin('2468');
    expect(app.unlocked, isTrue);
    await app.disablePin();
    expect(app.lockEnabled, isFalse);
  });

  test('reloading sample data with reset reseeds the household', () async {
    final firstCount = app.transactions.length;
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(1),
      date: DateTime.now(),
      accountId: 'acc_cash',
      categoryId: 'exp_other',
      note: 'throwaway',
    );
    expect(app.transactions.length, firstCount + 1);
    await DemoDataLoader(app).load(reset: true);
    expect(app.transactions.any((t) => t.note == 'throwaway'), isFalse);
    expect(app.transactions.length, firstCount);
    expect(app.plan!.confirmed, isTrue);
  });

  test('credit card spend is not a bank cash expense mix-up', () {
    final cardSpend = app.transactions.where(
      (t) => t.accountId == 'acc_card' && t.type == TransactionType.expense,
    );
    expect(cardSpend, isNotEmpty);
    final balances = app.calc.accountBalances(app.accounts, app.transactions);
    final card = balances.firstWhere((b) => b.account.id == 'acc_card');
    expect(card.account.isLiability, isTrue);
  });

  test('history spans multiple months in the yearly report', () {
    final year = app.yearlyReport();
    expect(year.income.minor, greaterThan(Money.fromMajor(60000).minor));
    final monthsWithSalary = app.transactions
        .where(
          (t) =>
              t.categoryId == 'inc_salary' &&
              t.date.year == DateTime.now().year,
        )
        .map((t) => t.date.month)
        .toSet();
    expect(monthsWithSalary.length, greaterThanOrEqualTo(6));
  });
}
