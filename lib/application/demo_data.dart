import '../core/features.dart';
import '../core/ids.dart';
import '../core/money.dart';
import '../domain/entities.dart';
import 'finance_app.dart';

/// Realistic sample household used to exercise every module.
class DemoDataLoader {
  DemoDataLoader(this.app);
  final FinanceApp app;

  Future<void> load({bool reset = false}) async {
    if (reset) {
      await app.repo.clearAll();
      await app.repo.seedDefaults();
      await app.reload();
    }
    if (!reset && app.transactions.isNotEmpty) return;

    for (final feature in AppFeature.values) {
      await app.setFeature(feature, true);
    }

    final now = DateTime.now();
    DateTime monthsAgo(int n, [int day = 1]) =>
        DateTime(now.year, now.month - n, day);

    final bank = app.accounts.firstWhere((a) => a.id == 'acc_bank');
    final cash = app.accounts.firstWhere((a) => a.id == 'acc_cash');
    final savings = app.accounts.firstWhere((a) => a.id == 'acc_savings');
    await app.upsertAccount(
      Account(
        id: bank.id,
        name: 'HDFC Salary Account',
        type: AccountType.bank,
        openingBalance: Money.fromMajor(18500),
        notes: 'Primary salary account',
        createdAt: bank.createdAt,
      ),
    );
    await app.upsertAccount(
      Account(
        id: cash.id,
        name: 'Wallet cash',
        type: AccountType.cash,
        openingBalance: Money.fromMajor(2400),
        createdAt: cash.createdAt,
      ),
    );
    await app.upsertAccount(
      Account(
        id: savings.id,
        name: 'HDFC Sweep Savings',
        type: AccountType.savings,
        openingBalance: Money.fromMajor(5000),
        notes: 'Goal destination account',
        createdAt: savings.createdAt,
      ),
    );
    await app.upsertAccount(
      Account(
        id: 'acc_card',
        name: 'Axis Credit Card',
        type: AccountType.creditCard,
        openingBalance: Money.fromMajor(4200),
        notes: 'Liability — pay before due date',
        createdAt: now,
      ),
    );
    await app.upsertAccount(
      Account(
        id: 'acc_upi',
        name: 'PhonePe UPI',
        type: AccountType.upi,
        openingBalance: Money.fromMajor(850),
        createdAt: now,
      ),
    );
    await app.upsertAccount(
      Account(
        id: 'acc_wallet',
        name: 'Amazon Pay',
        type: AccountType.wallet,
        openingBalance: Money.fromMajor(320),
        createdAt: now,
      ),
    );

    await app.upsertCategory(
      const Category(
        id: 'exp_subscriptions',
        name: 'Subscriptions',
        kind: CategoryKind.expense,
        icon: 'subscriptions',
        sortOrder: 20,
      ),
    );

    await app.saveSalary(
      SalaryProfile(
        id: 'salary_main',
        baseAmount: Money.fromMajor(52000),
        payDay: 1,
        source: 'Acme Pvt Ltd',
        effectiveFrom: DateTime(now.year, 1, 1),
      ),
    );
    await app.saveSalary(
      SalaryProfile(
        id: 'salary_main',
        baseAmount: Money.fromMajor(60000),
        payDay: 1,
        source: 'Acme Pvt Ltd',
        effectiveFrom: DateTime(now.year, 6, 1),
      ),
    );

    const emergencyId = 'goal_emergency';
    const vacationId = 'goal_vacation';
    const laptopId = 'goal_laptop';
    await app.upsertSavingsGoal(
      SavingsGoal(
        id: emergencyId,
        name: 'Emergency Fund',
        targetAmount: Money.fromMajor(100000),
        currentAmount: Money.fromMajor(40000),
        monthlyContribution: Money.fromMajor(10000),
        priority: 1,
        notes: '6 months of expenses',
        targetDate: DateTime(now.year + 1, 3, 1),
      ),
    );
    await app.upsertSavingsGoal(
      SavingsGoal(
        id: vacationId,
        name: 'Goa trip',
        targetAmount: Money.fromMajor(80000),
        currentAmount: Money.fromMajor(12000),
        monthlyContribution: Money.fromMajor(5000),
        priority: 2,
        targetDate: DateTime(now.year, 12, 15),
      ),
    );
    await app.upsertSavingsGoal(
      SavingsGoal(
        id: laptopId,
        name: 'New laptop',
        targetAmount: Money.fromMajor(90000),
        currentAmount: Money.fromMajor(18000),
        monthlyContribution: Money.fromMajor(4000),
        priority: 3,
        targetDate: DateTime(now.year + 1, 1, 10),
      ),
    );
    await app.upsertFinancialGoal(
      FinancialGoal(
        id: 'fin_goal_invest',
        name: 'Build ₹5 lakh portfolio',
        targetAmount: Money.fromMajor(500000),
        currentAmount: Money.fromMajor(45000),
        requiredMonthly: Money.fromMajor(8000),
        kind: 'investment',
        deadline: DateTime(now.year + 3, 12, 31),
        notes: 'Index + gold + PPF mix',
      ),
    );
    await app.upsertFinancialGoal(
      FinancialGoal(
        id: 'fin_goal_debt',
        name: 'Become debt-free',
        targetAmount: Money.fromMajor(180000),
        currentAmount: Money.fromMajor(20000),
        requiredMonthly: Money.fromMajor(8000),
        kind: 'debt',
      ),
    );
    await app.upsertFinancialGoal(
      FinancialGoal(
        id: 'fin_goal_house',
        name: 'Home down payment',
        targetAmount: Money.fromMajor(1500000),
        currentAmount: Money.fromMajor(120000),
        requiredMonthly: Money.fromMajor(15000),
        kind: 'savings',
        deadline: DateTime(now.year + 5, 6, 1),
      ),
    );

    await app.upsertInvestment(
      Investment(
        id: 'inv_index',
        name: 'Nifty 50 Index Fund',
        type: 'mutual_funds',
        amount: Money.fromMajor(25000),
        currentValue: Money.fromMajor(27800),
        date: monthsAgo(4, 12),
        accountId: 'acc_bank',
        notes: 'Monthly SIP when plan is completed',
      ),
    );
    await app.upsertInvestment(
      Investment(
        id: 'inv_gold',
        name: 'Sovereign Gold',
        type: 'gold',
        amount: Money.fromMajor(15000),
        currentValue: Money.fromMajor(16200),
        date: monthsAgo(2, 8),
        accountId: 'acc_bank',
      ),
    );
    await app.upsertInvestment(
      Investment(
        id: 'inv_ppf',
        name: 'PPF',
        type: 'ppf',
        amount: Money.fromMajor(50000),
        currentValue: Money.fromMajor(51200),
        date: DateTime(now.year - 1, 4, 5),
        accountId: 'acc_bank',
        notes: 'Long-term tax saving',
      ),
    );
    await app.upsertInvestment(
      Investment(
        id: 'inv_stock',
        name: 'HDFC Bank shares',
        type: 'stocks',
        amount: Money.fromMajor(12000),
        currentValue: Money.fromMajor(11450),
        date: monthsAgo(1, 18),
        accountId: 'acc_bank',
        notes: 'Slightly underwater — keep holding',
      ),
    );

    await app.upsertBill(
      RecurringBill(
        id: 'bill_net',
        name: 'Internet',
        amount: Money.fromMajor(999),
        dueDay: 7,
        categoryId: 'exp_bills',
        accountId: 'acc_bank',
      ),
    );
    await app.upsertBill(
      RecurringBill(
        id: 'bill_power',
        name: 'Electricity',
        amount: Money.fromMajor(1800),
        dueDay: 12,
        categoryId: 'exp_bills',
        accountId: 'acc_bank',
      ),
    );
    await app.upsertBill(
      RecurringBill(
        id: 'bill_mobile',
        name: 'Mobile recharge',
        amount: Money.fromMajor(399),
        dueDay: 18,
        categoryId: 'exp_bills',
        accountId: 'acc_upi',
      ),
    );
    await app.upsertBill(
      RecurringBill(
        id: 'bill_ott',
        name: 'OTT bundle',
        amount: Money.fromMajor(649),
        dueDay: 20,
        categoryId: 'exp_subscriptions',
        accountId: 'acc_card',
      ),
    );
    await app.upsertBill(
      RecurringBill(
        id: 'bill_gym',
        name: 'Gym',
        amount: Money.fromMajor(1500),
        dueDay: 25,
        categoryId: 'exp_personal',
        accountId: 'acc_bank',
      ),
    );
    await app.upsertLoan(
      Loan(
        id: 'loan_car',
        name: 'Car EMI',
        principal: Money.fromMajor(240000),
        interestRate: 9.2,
        emi: Money.fromMajor(8000),
        startDate: DateTime(now.year - 1, 2, 5),
        endDate: DateTime(now.year + 1, 2, 5),
        remaining: Money.fromMajor(180000),
        accountId: 'acc_bank',
      ),
    );
    await app.upsertLoan(
      Loan(
        id: 'loan_personal',
        name: 'Personal loan EMI',
        principal: Money.fromMajor(80000),
        interestRate: 13.5,
        emi: Money.fromMajor(3500),
        startDate: monthsAgo(8, 3),
        endDate: DateTime(now.year + 1, now.month, 3),
        remaining: Money.fromMajor(42000),
        accountId: 'acc_bank',
      ),
    );

    Future<void> budget(String id, String categoryId, int major) =>
        app.upsertBudget(
          Budget(
            id: id,
            categoryId: categoryId,
            amount: Money.fromMajor(major),
            year: now.year,
            month: now.month,
          ),
        );
    await budget('bud_food', 'exp_food', 8000);
    await budget('bud_travel', 'exp_travel', 5000);
    await budget('bud_shopping', 'exp_shopping', 4000);
    await budget('bud_ent', 'exp_entertainment', 2500);
    await budget('bud_transport', 'exp_transport', 3000);
    await budget('bud_health', 'exp_health', 2000);

    await app.saveTemplate([
      AllocationTemplateItem(
        id: newId(),
        name: 'Emergency Savings',
        kind: AllocationKind.savings,
        plannedAmount: Money.fromMajor(10000),
        goalId: emergencyId,
        sortOrder: 0,
      ),
      AllocationTemplateItem(
        id: newId(),
        name: 'SIP Investment',
        kind: AllocationKind.investment,
        plannedAmount: Money.fromMajor(5000),
        investmentId: 'inv_index',
        sortOrder: 1,
      ),
      AllocationTemplateItem(
        id: newId(),
        name: 'Laptop fund',
        kind: AllocationKind.savings,
        plannedAmount: Money.fromMajor(4000),
        goalId: laptopId,
        sortOrder: 2,
      ),
      AllocationTemplateItem(
        id: newId(),
        name: 'Rent',
        kind: AllocationKind.expense,
        plannedAmount: Money.fromMajor(15000),
        categoryId: 'exp_housing',
        sortOrder: 3,
      ),
      AllocationTemplateItem(
        id: newId(),
        name: 'Food',
        kind: AllocationKind.expense,
        plannedAmount: Money.fromMajor(8000),
        categoryId: 'exp_food',
        sortOrder: 4,
      ),
      AllocationTemplateItem(
        id: newId(),
        name: 'Travel',
        kind: AllocationKind.expense,
        plannedAmount: Money.fromMajor(5000),
        categoryId: 'exp_travel',
        sortOrder: 5,
      ),
      AllocationTemplateItem(
        id: newId(),
        name: 'Education',
        kind: AllocationKind.expense,
        plannedAmount: Money.fromMajor(2000),
        categoryId: 'exp_education',
        sortOrder: 6,
      ),
    ]);

    for (var i = 1; i <= 6; i++) {
      await _historyMonth(monthsAgo(i), emergencyId, vacationId, i);
    }

    await app.recordSalaryIncome(date: DateTime(now.year, now.month, 1));
    await app.addTransaction(
      type: TransactionType.income,
      amount: Money.fromMajor(8500),
      date: DateTime(now.year, now.month, 6),
      accountId: 'acc_bank',
      categoryId: 'inc_freelance',
      note: 'Weekend freelance',
    );
    await app.addTransaction(
      type: TransactionType.income,
      amount: Money.fromMajor(1500),
      date: DateTime(now.year, now.month, 8),
      accountId: 'acc_bank',
      categoryId: 'inc_refund',
      note: 'Amazon return refund',
    );
    await app.addTransaction(
      type: TransactionType.income,
      amount: Money.fromMajor(2000),
      date: DateTime(now.year, now.month, 12),
      accountId: 'acc_cash',
      categoryId: 'inc_gift',
      note: 'Birthday gift from family',
    );
    await app.addTransaction(
      type: TransactionType.transfer,
      amount: Money.fromMajor(1500),
      date: DateTime(now.year, now.month, 3),
      accountId: 'acc_bank',
      toAccountId: 'acc_cash',
      note: 'ATM withdrawal',
    );
    await app.addTransaction(
      type: TransactionType.transfer,
      amount: Money.fromMajor(600),
      date: DateTime(now.year, now.month, 5),
      accountId: 'acc_bank',
      toAccountId: 'acc_upi',
      note: 'Top-up UPI wallet',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(420),
      date: DateTime(now.year, now.month, 4),
      accountId: 'acc_cash',
      categoryId: 'exp_food',
      note: 'Breakfast',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(1899),
      date: DateTime(now.year, now.month, 8),
      accountId: 'acc_card',
      categoryId: 'exp_shopping',
      note: 'Headphones',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(650),
      date: DateTime(now.year, now.month, 9),
      accountId: 'acc_bank',
      categoryId: 'exp_transport',
      note: 'Metro + cab',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(2200),
      date: DateTime(now.year, now.month, 11),
      accountId: 'acc_bank',
      categoryId: 'exp_entertainment',
      note: 'Movie and dinner',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(890),
      date: DateTime(now.year, now.month, 7),
      accountId: 'acc_upi',
      categoryId: 'exp_food',
      note: 'Swiggy weekend',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(1450),
      date: DateTime(now.year, now.month, 13),
      accountId: 'acc_bank',
      categoryId: 'exp_health',
      note: 'Pharmacy + clinic',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(750),
      date: DateTime(now.year, now.month, 14),
      accountId: 'acc_wallet',
      categoryId: 'exp_shopping',
      note: 'Household items',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(3200),
      date: DateTime(now.year, now.month, 10),
      accountId: 'acc_bank',
      categoryId: 'exp_family',
      note: 'Parents support',
    );
    await app.addTransaction(
      type: TransactionType.saving,
      amount: Money.fromMajor(2000),
      date: DateTime(now.year, now.month, 10),
      accountId: 'acc_bank',
      goalId: vacationId,
      note: 'Goa trip extra',
    );

    await app.generateThisMonth();
    await app.confirmThisMonth();

    AllocationItem byName(String name) =>
        app.allocations.firstWhere((a) => a.name == name);

    await app.completeAllocation(
      byName('Emergency Savings').id,
      Money.fromMajor(10000),
      'acc_bank',
    );
    await app.completeAllocation(
      byName('Laptop fund').id,
      Money.fromMajor(4000),
      'acc_bank',
    );
    await app.completeAllocation(
      byName('Rent').id,
      Money.fromMajor(15000),
      'acc_bank',
    );
    await app.completeAllocation(
      byName('Food').id,
      Money.fromMajor(6000),
      'acc_bank',
    );
    await app.skipAllocation(
      byName('SIP Investment').id,
      SkipReason.unexpectedExpense,
      'Used amount for emergency vehicle repair.',
    );

    final travel = app.allocations.where((a) => a.name == 'Travel');
    if (travel.isNotEmpty) {
      await app.completeAllocation(
        travel.first.id,
        Money.fromMajor(5000),
        'acc_bank',
      );
    }
    final net = app.allocations.where((a) => a.name == 'Internet');
    if (net.isNotEmpty) {
      await app.completeAllocation(net.first.id, Money.fromMajor(999), 'acc_bank');
    }
    final power = app.allocations.where((a) => a.name == 'Electricity');
    if (power.isNotEmpty) {
      await app.completeAllocation(
        power.first.id,
        Money.fromMajor(1800),
        'acc_bank',
      );
    }
    final mobile = app.allocations.where((a) => a.name == 'Mobile recharge');
    if (mobile.isNotEmpty) {
      await app.completeAllocation(
        mobile.first.id,
        Money.fromMajor(399),
        'acc_upi',
      );
    }
    final ott = app.allocations.where((a) => a.name == 'OTT bundle');
    if (ott.isNotEmpty) {
      await app.completeAllocation(ott.first.id, Money.fromMajor(649), 'acc_card');
    }
    for (final item in app.allocations.where((a) => a.kind == AllocationKind.loanEmi)) {
      await app.completeAllocation(item.id, item.plannedAmount, 'acc_bank');
    }

    await app.addNote(
      'Could not complete planned SIP because of an unexpected vehicle repair.',
      monthKey: '${now.year}-${now.month.toString().padLeft(2, '0')}',
    );
    await app.addNote(
      'Freelance payment landed on the 6th — keep a buffer next month.',
    );
    await app.addNote(
      'Credit card headphones purchase is a liability, not cash spent from bank.',
    );
    await app.addNote(
      'Gym and Education allocations left pending on purpose.',
      monthKey: '${now.year}-${now.month.toString().padLeft(2, '0')}',
    );
    await app.addNote(
      'Emergency fund is the top priority until it hits ₹1 lakh.',
      goalId: emergencyId,
    );
    await app.repo.setSetting('demo_loaded', '1');
    await app.reload();
  }

  Future<void> _historyMonth(
    DateTime month,
    String emergencyId,
    String vacationId,
    int age,
  ) async {
    final salary = month.month >= 6 ? 60000 : 52000;
    await app.addTransaction(
      type: TransactionType.income,
      amount: Money.fromMajor(salary),
      date: DateTime(month.year, month.month, 1),
      accountId: 'acc_bank',
      categoryId: 'inc_salary',
      note: 'Salary',
    );
    if (age == 2) {
      await app.addTransaction(
        type: TransactionType.income,
        amount: Money.fromMajor(12000),
        date: DateTime(month.year, month.month, 20),
        accountId: 'acc_bank',
        categoryId: 'inc_bonus',
        note: 'Quarterly bonus',
      );
    }
    if (age == 4) {
      await app.addTransaction(
        type: TransactionType.income,
        amount: Money.fromMajor(4500),
        date: DateTime(month.year, month.month, 16),
        accountId: 'acc_bank',
        categoryId: 'inc_side_income',
        note: 'Weekend tutoring',
      );
    }
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(15000),
      date: DateTime(month.year, month.month, 2),
      accountId: 'acc_bank',
      categoryId: 'exp_housing',
      note: 'Rent',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(6800 + age * 120),
      date: DateTime(month.year, month.month, 14),
      accountId: 'acc_bank',
      categoryId: 'exp_food',
      note: 'Groceries',
    );
    await app.addTransaction(
      type: TransactionType.saving,
      amount: Money.fromMajor(10000),
      date: DateTime(month.year, month.month, 3),
      accountId: 'acc_bank',
      goalId: emergencyId,
      note: 'Emergency Fund',
    );
    if (age.isOdd) {
      await app.addTransaction(
        type: TransactionType.saving,
        amount: Money.fromMajor(2000),
        date: DateTime(month.year, month.month, 21),
        accountId: 'acc_bank',
        goalId: vacationId,
        note: 'Goa trip',
      );
    }
    if (age != 1) {
      await app.addTransaction(
        type: TransactionType.investment,
        amount: Money.fromMajor(5000),
        date: DateTime(month.year, month.month, 4),
        accountId: 'acc_bank',
        note: 'SIP',
      );
    }
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(999),
      date: DateTime(month.year, month.month, 7),
      accountId: 'acc_bank',
      categoryId: 'exp_bills',
      note: 'Internet',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(1650 + age * 40),
      date: DateTime(month.year, month.month, 12),
      accountId: 'acc_bank',
      categoryId: 'exp_bills',
      note: 'Electricity',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(8000),
      date: DateTime(month.year, month.month, 5),
      accountId: 'acc_bank',
      categoryId: 'exp_other',
      note: 'Car EMI',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(3500),
      date: DateTime(month.year, month.month, 5),
      accountId: 'acc_bank',
      categoryId: 'exp_other',
      note: 'Personal loan EMI',
    );
    await app.addTransaction(
      type: TransactionType.expense,
      amount: Money.fromMajor(480 + age * 35),
      date: DateTime(month.year, month.month, 9),
      accountId: 'acc_upi',
      categoryId: 'exp_transport',
      note: 'Local travel',
    );
    if (age == 3) {
      await app.addTransaction(
        type: TransactionType.expense,
        amount: Money.fromMajor(6200),
        date: DateTime(month.year, month.month, 18),
        accountId: 'acc_card',
        categoryId: 'exp_travel',
        note: 'Weekend getaway',
      );
    }
    if (age == 5) {
      await app.addTransaction(
        type: TransactionType.expense,
        amount: Money.fromMajor(2800),
        date: DateTime(month.year, month.month, 11),
        accountId: 'acc_bank',
        categoryId: 'exp_health',
        note: 'Dental checkup',
      );
    }
  }
}
