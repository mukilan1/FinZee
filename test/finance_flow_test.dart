import 'package:drift/native.dart';
import 'package:finzee/application/finance_app.dart';
import 'package:finzee/core/features.dart';
import 'package:finzee/core/ids.dart';
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
  });

  tearDown(() async {
    await db.close();
  });

  test('Mode A works with salary planning off', () async {
    expect(app.enabled(AppFeature.salaryPlanning), isFalse);
    await app.addTransaction(
      type: TransactionType.income,
      amount: Money.fromMajor(1000),
      date: DateTime.now(),
      accountId: 'acc_bank',
      categoryId: 'inc_salary',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(250),
      date: DateTime.now(),
      accountId: 'acc_bank',
      categoryId: 'exp_food',
    );
    final dash = app.dashboard();
    expect(dash.income, Money.fromMajor(1000));
    expect(dash.expenses, Money.fromMajor(250));
  });

  test('salary → plan → complete savings → skip investment → report', () async {
    await app.setFeature(AppFeature.salaryPlanning, true);
    await app.setFeature(AppFeature.savingsGoals, true);
    await app.setFeature(AppFeature.investments, true);

    await app.saveSalary(
      SalaryProfile(
        id: newId(),
        baseAmount: Money.fromMajor(60000),
        payDay: 1,
        effectiveFrom: DateTime(2026, 8, 1),
      ),
    );

    final goal = SavingsGoal(
      id: newId(),
      name: 'Emergency Fund',
      targetAmount: Money.fromMajor(100000),
      currentAmount: Money.fromMajor(40000),
      monthlyContribution: Money.fromMajor(10000),
    );
    await app.upsertSavingsGoal(goal);

    await app.saveTemplate([
      AllocationTemplateItem(
        id: newId(),
        name: 'Emergency Savings',
        kind: AllocationKind.savings,
        plannedAmount: Money.fromMajor(10000),
        goalId: goal.id,
        sortOrder: 0,
      ),
      AllocationTemplateItem(
        id: newId(),
        name: 'Investment',
        kind: AllocationKind.investment,
        plannedAmount: Money.fromMajor(5000),
        sortOrder: 1,
      ),
      AllocationTemplateItem(
        id: newId(),
        name: 'Rent',
        kind: AllocationKind.expense,
        plannedAmount: Money.fromMajor(15000),
        categoryId: 'exp_housing',
        sortOrder: 2,
      ),
    ]);

    await app.generateThisMonth();
    expect(app.plan, isNotNull);
    expect(app.allocations.length, greaterThanOrEqualTo(2));

    final savingsItem = app.allocations.firstWhere((a) => a.kind == AllocationKind.savings);
    final investItem = app.allocations.firstWhere((a) => a.kind == AllocationKind.investment);

    await app.completeAllocation(savingsItem.id, Money.fromMajor(10000), 'acc_bank');
    await app.reload();
    final updatedGoal = app.savingsGoals.firstWhere((g) => g.id == goal.id);
    expect(updatedGoal.currentAmount, Money.fromMajor(50000));

    await app.skipAllocation(
      investItem.id,
      SkipReason.unexpectedExpense,
      'Used amount for emergency vehicle repair.',
    );

    final report = app.monthlyReport();
    final investRow = report.plannedVsActual.firstWhere((r) => r.name == 'Investment');
    expect(investRow.planned, Money.fromMajor(5000));
    expect(investRow.actual, const Money(0));
    expect(investRow.variance, Money.fromMajor(-5000));
    expect(investRow.reason, SkipReason.unexpectedExpense);
    expect(investRow.note, contains('vehicle repair'));

    final savingsTx = app.transactions.where((t) => t.type == TransactionType.saving);
    expect(savingsTx.length, 1);
    expect(app.dashboard().savings, Money.fromMajor(10000));
    expect(app.dashboard().investments.isZero, true);
  });

  test('disabling investments hides automation but keeps records', () async {
    await app.setFeature(AppFeature.investments, true);
    await app.upsertInvestment(
      Investment(
        id: newId(),
        name: 'Index fund',
        type: 'mutual_funds',
        amount: Money.fromMajor(5000),
        date: DateTime.now(),
      ),
    );
    expect(app.investments, isNotEmpty);
    await app.setFeature(AppFeature.investments, false);
    expect(app.enabled(AppFeature.investments), isFalse);
    expect(app.investments, isNotEmpty);
  });

  test('backup round trip preserves transactions', () async {
    await app.addTransaction(
      type: TransactionType.income,
      amount: Money.fromMajor(75000),
      date: DateTime.now(),
      accountId: 'acc_bank',
    );
    final json = await app.backup.exportJson();
    expect(json, contains('"schemaVersion": 1'));
    final summary = app.backup.summarize(json);
    expect(summary.transactionCount, 1);

    final safety = await app.backup.exportJson();
    await app.backup.restore(json, safetyBackup: safety);
    await app.reload();
    expect(app.transactions.length, 1);
    expect(app.transactions.first.amount, Money.fromMajor(75000));
  });

  test('invalid backup is rejected', () {
    expect(() => app.backup.summarize('not-json'), throwsA(isA<Exception>()));
  });
}
