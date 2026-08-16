import 'package:drift/native.dart';
import 'package:finzee/application/finance_app.dart';
import 'package:finzee/core/errors.dart';
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

  tearDown(() async => db.close());

  test('savings credit the destination account', () async {
    await app.addTransaction(
      type: TransactionType.income,
      amount: Money.fromMajor(20000),
      date: DateTime.now(),
      accountId: 'acc_bank',
    );
    await app.addTransaction(
      type: TransactionType.saving,
      amount: Money.fromMajor(5000),
      date: DateTime.now(),
      accountId: 'acc_bank',
    );
    final balances = app.calc.accountBalances(app.accounts, app.transactions);
    expect(balances.firstWhere((b) => b.account.id == 'acc_bank').balance, Money.fromMajor(15000));
    expect(balances.firstWhere((b) => b.account.id == 'acc_savings').balance, Money.fromMajor(5000));
    expect(app.dashboard().savings, Money.fromMajor(5000));
    expect(app.dashboard().expenses.isZero, true);
  });

  test('same-account transfer is rejected', () async {
    expect(
      () => app.addTransaction(
        type: TransactionType.transfer,
        amount: Money.fromMajor(100),
        date: DateTime.now(),
        accountId: 'acc_bank',
        toAccountId: 'acc_bank',
      ),
      throwsA(isA<ValidationError>()),
    );
  });

  test('investment is not income and is included in net worth once', () async {
    await app.addTransaction(
      type: TransactionType.income,
      amount: Money.fromMajor(10000),
      date: DateTime.now(),
      accountId: 'acc_bank',
    );
    await app.addTransaction(
      type: TransactionType.investment,
      amount: Money.fromMajor(2000),
      date: DateTime.now(),
      accountId: 'acc_bank',
      note: 'Index fund',
    );
    expect(app.dashboard().income, Money.fromMajor(10000));
    expect(app.dashboard().investments, Money.fromMajor(2000));
    expect(app.investments.length, 1);
    final nw = app.calc.netWorth(
      accounts: app.accounts,
      transactions: app.transactions,
      investments: app.investments,
      loans: app.loans,
    );
    expect(nw.$1, Money.fromMajor(10000));
  });

  test('cannot complete the same allocation twice', () async {
    await app.setFeature(AppFeature.salaryPlanning, true);
    await app.setFeature(AppFeature.savingsGoals, true);
    await app.saveSalary(
      SalaryProfile(
        id: newId(),
        baseAmount: Money.fromMajor(60000),
        payDay: 1,
        effectiveFrom: DateTime.now(),
      ),
    );
    await app.saveTemplate([
      AllocationTemplateItem(
        id: newId(),
        name: 'Rent',
        kind: AllocationKind.expense,
        plannedAmount: Money.fromMajor(1000),
        categoryId: 'exp_housing',
      ),
    ]);
    await app.generateThisMonth();
    final id = app.allocations.first.id;
    await app.completeAllocation(id, Money.fromMajor(1000), 'acc_bank');
    expect(
      () => app.completeAllocation(id, Money.fromMajor(1000), 'acc_bank'),
      throwsA(isA<ValidationError>()),
    );
  });

  test('salary income is recorded once per month', () async {
    await app.setFeature(AppFeature.salaryPlanning, true);
    await app.saveSalary(
      SalaryProfile(
        id: newId(),
        baseAmount: Money.fromMajor(60000),
        payDay: 1,
        effectiveFrom: DateTime.now(),
      ),
    );
    await app.recordSalaryIncome();
    expect(app.dashboard().income, Money.fromMajor(60000));
    expect(
      () => app.recordSalaryIncome(),
      throwsA(isA<ValidationError>()),
    );
  });

  test('bills and loans appear in a generated plan when enabled', () async {
    await app.setFeature(AppFeature.salaryPlanning, true);
    await app.setFeature(AppFeature.bills, true);
    await app.setFeature(AppFeature.loans, true);
    await app.saveSalary(
      SalaryProfile(
        id: newId(),
        baseAmount: Money.fromMajor(60000),
        payDay: 1,
        effectiveFrom: DateTime.now(),
      ),
    );
    await app.upsertBill(
      RecurringBill(
        id: newId(),
        name: 'Internet',
        amount: Money.fromMajor(999),
        dueDay: 5,
        categoryId: 'exp_bills',
      ),
    );
    await app.upsertLoan(
      Loan(
        id: newId(),
        name: 'Car',
        principal: Money.fromMajor(200000),
        interestRate: 9,
        emi: Money.fromMajor(8000),
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 365)),
        remaining: Money.fromMajor(200000),
      ),
    );
    await app.generateThisMonth();
    expect(app.allocations.any((a) => a.name == 'Internet'), isTrue);
    expect(app.allocations.any((a) => a.name.contains('EMI')), isTrue);
  });

  test('skip other requires a note', () async {
    await app.setFeature(AppFeature.salaryPlanning, true);
    await app.saveSalary(
      SalaryProfile(id: newId(), baseAmount: Money.fromMajor(1000), payDay: 1, effectiveFrom: DateTime.now()),
    );
    await app.saveTemplate([
      AllocationTemplateItem(id: newId(), name: 'Food', kind: AllocationKind.expense, plannedAmount: Money.fromMajor(100), categoryId: 'exp_food'),
    ]);
    await app.generateThisMonth();
    expect(
      () => app.skipAllocation(app.allocations.first.id, SkipReason.other, ''),
      throwsA(isA<ValidationError>()),
    );
  });

  test('deleting a saving reverses the goal', () async {
    final goal = SavingsGoal(
      id: newId(),
      name: 'Laptop',
      targetAmount: Money.fromMajor(50000),
      currentAmount: const Money(0),
    );
    await app.upsertSavingsGoal(goal);
    await app.addTransaction(
      type: TransactionType.saving,
      amount: Money.fromMajor(2000),
      date: DateTime.now(),
      accountId: 'acc_bank',
      goalId: goal.id,
    );
    expect(app.savingsGoals.first.currentAmount, Money.fromMajor(2000));
    await app.deleteTransaction(app.transactions.first.id);
    expect(app.savingsGoals.first.currentAmount.isZero, true);
  });

  test('PIN lock hashes and rejects a wrong PIN', () async {
    await app.enablePin('1234');
    expect(app.lockEnabled, isTrue);
    expect(
      () => app.unlockWithPin('0000'),
      throwsA(isA<AuthenticationError>()),
    );
    await app.unlockWithPin('1234');
    expect(app.unlocked, isTrue);
  });

  test('Money.parse rejects junk', () {
    expect(() => Money.parse('abc'), throwsA(isA<ValidationError>()));
    expect(() => Money.parse('0'), throwsA(isA<ValidationError>()));
    expect(Money.parse('1,250.50').minor, 125050);
  });
}
