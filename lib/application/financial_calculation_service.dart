import '../core/errors.dart';
import '../core/money.dart';
import '../domain/entities.dart';

class MonthRange {
  const MonthRange(this.year, this.month);
  final int year;
  final int month;

  DateTime get start => DateTime(year, month, 1);
  DateTime get endExclusive => DateTime(year, month + 1, 1);

  bool contains(DateTime d) => !d.isBefore(start) && d.isBefore(endExclusive);
}

class AccountBalance {
  const AccountBalance({required this.account, required this.balance});
  final Account account;
  final Money balance;
}

class CategorySpend {
  const CategorySpend({required this.category, required this.amount});
  final Category category;
  final Money amount;
}

class BudgetUsage {
  const BudgetUsage({
    required this.budget,
    required this.spent,
    required this.warningLevel,
  });
  final Budget budget;
  final Money spent;
  final int warningLevel;

  Money get remaining => budget.amount - spent;
  double get ratio =>
      budget.amount.minor == 0 ? 0 : spent.minor / budget.amount.minor;
}

class PlannedVsActualRow {
  const PlannedVsActualRow({
    required this.name,
    required this.planned,
    required this.actual,
    this.reason,
    this.note,
  });
  final String name;
  final Money planned;
  final Money actual;
  final SkipReason? reason;
  final String? note;

  Money get variance => actual - planned;
}

class DashboardSnapshot {
  const DashboardSnapshot({
    required this.totalBalance,
    required this.income,
    required this.expenses,
    required this.savings,
    required this.investments,
    required this.categorySpend,
    required this.recent,
    required this.allocationCompleted,
    required this.allocationTotal,
    required this.allocatedActual,
    required this.allocatedPlanned,
    required this.alerts,
    required this.netWorth,
    required this.assets,
    required this.liabilities,
  });

  final Money totalBalance;
  final Money income;
  final Money expenses;
  final Money savings;
  final Money investments;
  final List<CategorySpend> categorySpend;
  final List<FinanceTransaction> recent;
  final int allocationCompleted;
  final int allocationTotal;
  final Money allocatedActual;
  final Money allocatedPlanned;
  final List<LocalAlert> alerts;
  final Money netWorth;
  final Money assets;
  final Money liabilities;

  double get savingsRate =>
      income.minor == 0 ? 0 : savings.minor / income.minor;
}

class MonthlyReport {
  const MonthlyReport({
    required this.range,
    required this.income,
    required this.expenses,
    required this.savings,
    required this.investments,
    required this.remaining,
    required this.plannedVsActual,
    required this.categorySpend,
    required this.allocationSuccessRate,
  });

  final MonthRange range;
  final Money income;
  final Money expenses;
  final Money savings;
  final Money investments;
  final Money remaining;
  final List<PlannedVsActualRow> plannedVsActual;
  final List<CategorySpend> categorySpend;
  final double allocationSuccessRate;
}

class YearlyReport {
  const YearlyReport({
    required this.year,
    required this.income,
    required this.expenses,
    required this.savings,
    required this.investments,
    required this.netWorth,
    required this.savingsRate,
  });

  final int year;
  final Money income;
  final Money expenses;
  final Money savings;
  final Money investments;
  final Money netWorth;
  final double savingsRate;
}

class FinancialCalculationService {
  DashboardSnapshot dashboard({
    required MonthRange range,
    required List<Account> accounts,
    required List<FinanceTransaction> transactions,
    required List<Category> categories,
    required List<AllocationItem> allocations,
    required List<Investment> investments,
    required List<Loan> loans,
    required List<Budget> budgets,
    required List<LocalAlert> extraAlerts,
  }) {
    final monthTx = transactions.where((t) => range.contains(t.date)).toList();
    final income = _sum(monthTx, TransactionType.income);
    final expenses = _sum(monthTx, TransactionType.expense);
    final savings = _sum(monthTx, TransactionType.saving);
    final invest = _sum(monthTx, TransactionType.investment);
    final balances = accountBalances(accounts, transactions);
    final totalBalance = balances.fold(
      const Money(0),
      (p, b) => b.account.isLiability ? p - b.balance : p + b.balance,
    );
    final nw = netWorth(
      accounts: accounts,
      transactions: transactions,
      investments: investments,
      loans: loans,
    );
    final completed = allocations
        .where((a) => a.status == AllocationStatus.completed)
        .length;
    final allocatedActual = allocations.fold(
      const Money(0),
      (p, a) => p + (a.actualAmount ?? const Money(0)),
    );
    final allocatedPlanned = allocations.fold(
      const Money(0),
      (p, a) => p + a.plannedAmount,
    );
    return DashboardSnapshot(
      totalBalance: totalBalance,
      income: income,
      expenses: expenses,
      savings: savings,
      investments: invest,
      categorySpend: spendingByCategory(monthTx, categories),
      recent: (monthTx.toList()..sort((a, b) => b.date.compareTo(a.date)))
          .take(8)
          .toList(),
      allocationCompleted: completed,
      allocationTotal: allocations.length,
      allocatedActual: allocatedActual,
      allocatedPlanned: allocatedPlanned,
      alerts: extraAlerts,
      netWorth: nw.$1,
      assets: nw.$2,
      liabilities: nw.$3,
    );
  }

  Money _sum(Iterable<FinanceTransaction> txs, TransactionType type) {
    return txs
        .where((t) => t.type == type)
        .fold(const Money(0), (p, t) => p + t.amount);
  }

  List<AccountBalance> accountBalances(
    List<Account> accounts,
    List<FinanceTransaction> transactions,
  ) {
    return accounts.map((account) {
      var balance = account.openingBalance;
      for (final tx in transactions) {
        switch (tx.type) {
          case TransactionType.income:
            if (tx.accountId == account.id) balance += tx.amount;
          case TransactionType.expense:
          case TransactionType.investment:
            if (tx.accountId == account.id) balance -= tx.amount;
          case TransactionType.saving:
          case TransactionType.transfer:
            if (tx.accountId == account.id) balance -= tx.amount;
            if (tx.toAccountId == account.id) balance += tx.amount;
        }
      }
      return AccountBalance(account: account, balance: balance);
    }).toList();
  }

  List<CategorySpend> spendingByCategory(
    List<FinanceTransaction> transactions,
    List<Category> categories,
  ) {
    final byId = {for (final c in categories) c.id: c};
    final totals = <String, int>{};
    for (final tx in transactions.where((t) => t.type == TransactionType.expense)) {
      final id = tx.categoryId;
      if (id == null) continue;
      totals[id] = (totals[id] ?? 0) + tx.amount.minor;
    }
    return totals.entries
        .where((e) => byId.containsKey(e.key))
        .map((e) => CategorySpend(category: byId[e.key]!, amount: Money(e.value)))
        .toList()
      ..sort((a, b) => b.amount.minor.compareTo(a.amount.minor));
  }

  (Money, Money, Money) netWorth({
    required List<Account> accounts,
    required List<FinanceTransaction> transactions,
    required List<Investment> investments,
    required List<Loan> loans,
  }) {
    final balances = accountBalances(accounts, transactions);
    var assets = const Money(0);
    var liabilities = const Money(0);
    for (final b in balances) {
      if (b.account.isLiability) {
        liabilities += b.balance;
      } else if (b.account.type == AccountType.investment) {
        // Book value lives on Investment records so we do not double-count.
      } else {
        assets += b.balance;
      }
    }
    for (final inv in investments) {
      assets += inv.marketValue;
    }
    for (final loan in loans) {
      liabilities += loan.remaining;
    }
    return (assets - liabilities, assets, liabilities);
  }

  List<BudgetUsage> budgetUsage(
    List<Budget> budgets,
    List<FinanceTransaction> monthExpenses,
  ) {
    return budgets.map((budget) {
      final spent = monthExpenses
          .where((t) =>
              t.type == TransactionType.expense && t.categoryId == budget.categoryId)
          .fold(const Money(0), (p, t) => p + t.amount);
      final ratio = budget.amount.minor == 0 ? 0.0 : spent.minor / budget.amount.minor;
      var level = 0;
      if (ratio >= 1 && budget.warn100) {
        level = 100;
      } else if (ratio >= 0.9 && budget.warn90) {
        level = 90;
      } else if (ratio >= 0.75 && budget.warn75) {
        level = 75;
      }
      return BudgetUsage(budget: budget, spent: spent, warningLevel: level);
    }).toList();
  }

  List<LocalAlert> budgetAlerts(
    List<Budget> budgets,
    List<FinanceTransaction> monthTx,
  ) {
    return budgetUsage(budgets, monthTx)
        .where((u) => u.warningLevel > 0)
        .map(
          (u) => LocalAlert(
            id: 'budget_${u.budget.id}',
            title: 'Budget alert',
            body:
                'You have reached ${u.warningLevel}% of a category budget (${u.spent.format()} / ${u.budget.amount.format()}).',
            kind: 'budget',
          ),
        )
        .toList();
  }

  MonthlyReport monthlyReport({
    required MonthRange range,
    required List<FinanceTransaction> transactions,
    required List<Category> categories,
    required List<AllocationItem> allocations,
  }) {
    final monthTx = transactions.where((t) => range.contains(t.date)).toList();
    final income = _sum(monthTx, TransactionType.income);
    final expenses = _sum(monthTx, TransactionType.expense);
    final savings = _sum(monthTx, TransactionType.saving);
    final invest = _sum(monthTx, TransactionType.investment);
    final rows = allocations
        .map(
          (a) => PlannedVsActualRow(
            name: a.name,
            planned: a.plannedAmount,
            actual: a.actualAmount ?? const Money(0),
            reason: a.skipReason,
            note: a.skipNote,
          ),
        )
        .toList();
    final success = allocations.isEmpty
        ? 0.0
        : allocations.where((a) => a.status == AllocationStatus.completed).length /
            allocations.length;
    return MonthlyReport(
      range: range,
      income: income,
      expenses: expenses,
      savings: savings,
      investments: invest,
      remaining: income - expenses - savings - invest,
      plannedVsActual: rows,
      categorySpend: spendingByCategory(monthTx, categories),
      allocationSuccessRate: success,
    );
  }

  YearlyReport yearlyReport({
    required int year,
    required List<FinanceTransaction> transactions,
    required Money netWorth,
  }) {
    final yearTx = transactions.where((t) => t.date.year == year).toList();
    final income = _sum(yearTx, TransactionType.income);
    final expenses = _sum(yearTx, TransactionType.expense);
    final savings = _sum(yearTx, TransactionType.saving);
    final invest = _sum(yearTx, TransactionType.investment);
    return YearlyReport(
      year: year,
      income: income,
      expenses: expenses,
      savings: savings,
      investments: invest,
      netWorth: netWorth,
      savingsRate: income.minor == 0 ? 0 : savings.minor / income.minor,
    );
  }

  void assertFinancialInvariants(List<FinanceTransaction> transactions) {
    for (final tx in transactions) {
      if (tx.amount.minor <= 0) {
        throw const CalculationError('Transaction cannot have a non-positive amount.');
      }
      if (tx.type == TransactionType.transfer &&
          (tx.toAccountId == null || tx.toAccountId == tx.accountId)) {
        throw const CalculationError('Invalid transfer accounts.');
      }
    }
  }
}
