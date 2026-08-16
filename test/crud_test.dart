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

import 'support/mock_app_lock.dart';

void main() {
  late AppDatabase db;
  late FinanceApp app;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    app = FinanceApp(FinanceRepository(db));
    await app.bootstrap();
  });

  tearDown(() async => db.close());

  test('categories can be added, edited, and unused ones deleted', () async {
    await app.upsertCategory(
      Category(id: 'cat_custom', name: 'Pets', kind: CategoryKind.expense, sortOrder: 99),
    );
    expect(app.categories.any((c) => c.name == 'Pets'), isTrue);
    await app.upsertCategory(
      Category(id: 'cat_custom', name: 'Pets & vet', kind: CategoryKind.expense, sortOrder: 99),
    );
    expect(app.categories.any((c) => c.name == 'Pets & vet'), isTrue);
    await app.deleteCategory('cat_custom');
    expect(app.categories.any((c) => c.id == 'cat_custom'), isFalse);
  });

  test('used category cannot be deleted', () async {
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(10),
      date: DateTime.now(),
      accountId: 'acc_cash',
      categoryId: 'exp_food',
    );
    expect(() => app.deleteCategory('exp_food'), throwsA(isA<ValidationError>()));
  });

  test('accounts can be edited and empty ones deleted', () async {
    await app.upsertAccount(
      Account(
        id: 'acc_extra',
        name: 'UPI wallet',
        type: AccountType.upi,
        openingBalance: const Money(0),
        createdAt: DateTime.now(),
      ),
    );
    await app.upsertAccount(
      Account(
        id: 'acc_extra',
        name: 'PhonePe',
        type: AccountType.upi,
        openingBalance: Money.fromMajor(100),
        createdAt: DateTime.now(),
      ),
    );
    expect(app.accounts.any((a) => a.name == 'PhonePe'), isTrue);
    await app.deleteAccount('acc_extra');
    expect(app.accounts.any((a) => a.id == 'acc_extra'), isFalse);
  });

  test('investments are addable, editable, and deletable', () async {
    await app.setFeature(AppFeature.investments, true);
    await app.upsertInvestment(
      Investment(
        id: 'inv_x',
        name: 'ETF',
        type: 'etf',
        amount: Money.fromMajor(1000),
        date: DateTime(2026, 1, 2),
        currentValue: Money.fromMajor(1100),
      ),
    );
    await app.upsertInvestment(
      Investment(
        id: 'inv_x',
        name: 'Nifty ETF',
        type: 'etf',
        amount: Money.fromMajor(1000),
        date: DateTime(2026, 2, 2),
        currentValue: Money.fromMajor(1200),
      ),
    );
    expect(app.investments.single.name, 'Nifty ETF');
    expect(app.investments.single.date.month, 2);
    await app.deleteInvestment('inv_x');
    expect(app.investments, isEmpty);
  });

  test('transaction date can be edited', () async {
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(50),
      date: DateTime(2026, 1, 1),
      accountId: 'acc_cash',
      categoryId: 'exp_food',
      note: 'Tea',
    );
    final tx = app.transactions.first;
    await app.updateTransaction(
      FinanceTransaction(
        id: tx.id,
        type: tx.type,
        amount: tx.amount,
        date: DateTime(2026, 3, 15),
        accountId: tx.accountId,
        categoryId: tx.categoryId,
        note: 'Tea updated',
        createdAt: tx.createdAt,
      ),
    );
    expect(app.transactions.first.date.month, 3);
    expect(app.transactions.first.note, 'Tea updated');
  });

  test('pending allocation can be edited and deleted', () async {
    await app.setFeature(AppFeature.salaryPlanning, true);
    await app.saveSalary(
      SalaryProfile(
        id: newId(),
        baseAmount: Money.fromMajor(10000),
        payDay: 1,
        effectiveFrom: DateTime.now(),
      ),
    );
    await app.generateThisMonth();
    await app.addAllocation(
      name: 'Custom line',
      kind: AllocationKind.expense,
      plannedAmount: Money.fromMajor(500),
    );
    final item = app.allocations.firstWhere((a) => a.name == 'Custom line');
    await app.updateAllocation(
      AllocationItem(
        id: item.id,
        planId: item.planId,
        name: 'Custom line edited',
        kind: item.kind,
        plannedAmount: Money.fromMajor(700),
        sortOrder: item.sortOrder,
      ),
    );
    expect(app.allocations.any((a) => a.name == 'Custom line edited'), isTrue);
    await app.deleteAllocation(app.allocations.firstWhere((a) => a.name == 'Custom line edited').id);
    expect(app.allocations.any((a) => a.name == 'Custom line edited'), isFalse);
  });

  test('wipe requires DELETE and device auth when lock enabled', () async {
    final lockedApp = FinanceApp(
      FinanceRepository(db),
      lockService: mockAppLock(),
    );
    await lockedApp.bootstrap();
    await lockedApp.addTransaction(
      type: TransactionType.income,
      amount: Money.fromMajor(100),
      date: DateTime.now(),
      accountId: 'acc_bank',
    );
    expect(() => lockedApp.wipeAllData(typedPhrase: 'nope'), throwsA(isA<ValidationError>()));
    await lockedApp.enableAppLock();
    expect(
      () => lockedApp.wipeAllData(typedPhrase: 'DELETE'),
      throwsA(isA<AuthenticationError>()),
    );
    await lockedApp.wipeAllData(typedPhrase: 'DELETE', deviceAuthenticated: true);
    expect(lockedApp.transactions, isEmpty);
    expect(lockedApp.accounts, isNotEmpty);
  });
}
