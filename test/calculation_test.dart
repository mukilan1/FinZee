import 'package:finzee/application/financial_calculation_service.dart';
import 'package:finzee/core/money.dart';
import 'package:finzee/domain/entities.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final calc = FinancialCalculationService();
  final cash = Account(
    id: 'cash',
    name: 'Cash',
    type: AccountType.cash,
    openingBalance: Money.fromMajor(1000),
    createdAt: DateTime(2026, 1, 1),
  );
  final bank = Account(
    id: 'bank',
    name: 'Bank',
    type: AccountType.bank,
    openingBalance: Money.fromMajor(5000),
    createdAt: DateTime(2026, 1, 1),
  );

  test('transfers do not count as expenses', () {
    final txs = [
      FinanceTransaction(
        id: '1',
        type: TransactionType.transfer,
        amount: Money.fromMajor(500),
        date: DateTime(2026, 8, 2),
        accountId: 'bank',
        toAccountId: 'cash',
        createdAt: DateTime(2026, 8, 2),
      ),
      FinanceTransaction(
        id: '2',
        type: TransactionType.expense,
        amount: Money.fromMajor(200),
        date: DateTime(2026, 8, 3),
        accountId: 'cash',
        categoryId: 'food',
        createdAt: DateTime(2026, 8, 3),
      ),
    ];
    final dash = calc.dashboard(
      range: const MonthRange(2026, 8),
      accounts: [cash, bank],
      transactions: txs,
      categories: const [
        Category(id: 'food', name: 'Food', kind: CategoryKind.expense),
      ],
      allocations: const [],
      investments: const [],
      loans: const [],
      budgets: const [],
      extraAlerts: const [],
    );
    expect(dash.expenses, Money.fromMajor(200));
    expect(dash.income.isZero, true);
    final balances = calc.accountBalances([cash, bank], txs);
    expect(balances.firstWhere((b) => b.account.id == 'cash').balance, Money.fromMajor(1300));
    expect(balances.firstWhere((b) => b.account.id == 'bank').balance, Money.fromMajor(4500));
  });

  test('savings and investments do not inflate income', () {
    final txs = [
      FinanceTransaction(
        id: 'i',
        type: TransactionType.income,
        amount: Money.fromMajor(60000),
        date: DateTime(2026, 8, 1),
        accountId: 'bank',
        createdAt: DateTime(2026, 8, 1),
      ),
      FinanceTransaction(
        id: 's',
        type: TransactionType.saving,
        amount: Money.fromMajor(10000),
        date: DateTime(2026, 8, 2),
        accountId: 'bank',
        createdAt: DateTime(2026, 8, 2),
      ),
      FinanceTransaction(
        id: 'v',
        type: TransactionType.investment,
        amount: Money.fromMajor(5000),
        date: DateTime(2026, 8, 3),
        accountId: 'bank',
        createdAt: DateTime(2026, 8, 3),
      ),
    ];
    final dash = calc.dashboard(
      range: const MonthRange(2026, 8),
      accounts: [bank],
      transactions: txs,
      categories: const [],
      allocations: const [],
      investments: const [],
      loans: const [],
      budgets: const [],
      extraAlerts: const [],
    );
    expect(dash.income, Money.fromMajor(60000));
    expect(dash.savings, Money.fromMajor(10000));
    expect(dash.investments, Money.fromMajor(5000));
    expect(dash.expenses.isZero, true);
  });
}
