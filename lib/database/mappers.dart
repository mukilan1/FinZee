import '../core/money.dart';
import '../domain/entities.dart';
import 'app_database.dart';

Account mapAccount(AccountRow row) => Account(
      id: row.id,
      name: row.name,
      type: AccountType.values.byName(row.type),
      openingBalance: Money(row.openingBalanceMinor),
      currency: row.currency,
      notes: row.notes,
      archived: row.archived,
      createdAt: row.createdAt,
    );

Category mapCategory(CategoryRow row) => Category(
      id: row.id,
      name: row.name,
      kind: CategoryKind.values.byName(row.kind),
      parentId: row.parentId,
      icon: row.icon,
      sortOrder: row.sortOrder,
      archived: row.archived,
    );

FinanceTransaction mapTransaction(TransactionRow row) => FinanceTransaction(
      id: row.id,
      type: TransactionType.values.byName(row.type),
      amount: Money(row.amountMinor),
      date: row.date,
      accountId: row.accountId,
      toAccountId: row.toAccountId,
      categoryId: row.categoryId,
      subcategoryId: row.subcategoryId,
      paymentMethod: row.paymentMethod,
      incomeSourceId: row.incomeSourceId,
      note: row.note,
      tags: _decodeTags(row.tagsJson),
      attachmentPath: row.attachmentPath,
      allocationItemId: row.allocationItemId,
      goalId: row.goalId,
      investmentId: row.investmentId,
      createdAt: row.createdAt,
    );

List<String> _decodeTags(String json) {
  if (json.isEmpty || json == '[]') return const [];
  final inner = json.substring(1, json.length - 1);
  if (inner.isEmpty) return const [];
  return inner
      .split(',')
      .map((e) => e.trim().replaceAll('"', ''))
      .where((e) => e.isNotEmpty)
      .toList();
}

SalaryProfile mapSalary(SalaryProfileRow row) => SalaryProfile(
      id: row.id,
      baseAmount: Money(row.baseAmountMinor),
      payDay: row.payDay,
      frequency: row.frequency,
      currency: row.currency,
      source: row.source,
      effectiveFrom: row.effectiveFrom,
      active: row.active,
    );

SalaryHistoryEntry mapSalaryHistory(SalaryHistoryRow row) => SalaryHistoryEntry(
      id: row.id,
      previousAmount: Money(row.previousAmountMinor),
      newAmount: Money(row.newAmountMinor),
      effectiveDate: row.effectiveDate,
      reason: row.reason,
      notes: row.notes,
    );

MonthlyPlan mapPlan(MonthlyPlanRow row) => MonthlyPlan(
      id: row.id,
      year: row.year,
      month: row.month,
      expectedIncome: Money(row.expectedIncomeMinor),
      confirmed: row.confirmed,
      createdAt: row.createdAt,
    );

AllocationItem mapAllocation(AllocationItemRow row) => AllocationItem(
      id: row.id,
      planId: row.planId,
      name: row.name,
      kind: AllocationKind.values.byName(row.kind),
      plannedAmount: Money(row.plannedAmountMinor),
      actualAmount:
          row.actualAmountMinor == null ? null : Money(row.actualAmountMinor!),
      status: AllocationStatus.values.byName(row.status),
      categoryId: row.categoryId,
      goalId: row.goalId,
      investmentId: row.investmentId,
      billId: row.billId,
      loanId: row.loanId,
      accountId: row.accountId,
      skipReason: row.skipReason == null
          ? null
          : SkipReason.values.byName(row.skipReason!),
      skipNote: row.skipNote,
      sortOrder: row.sortOrder,
    );

AllocationTemplateItem mapTemplate(AllocationTemplateRow row) =>
    AllocationTemplateItem(
      id: row.id,
      name: row.name,
      kind: AllocationKind.values.byName(row.kind),
      plannedAmount: Money(row.plannedAmountMinor),
      categoryId: row.categoryId,
      goalId: row.goalId,
      investmentId: row.investmentId,
      billId: row.billId,
      loanId: row.loanId,
      accountId: row.accountId,
      sortOrder: row.sortOrder,
    );

SavingsGoal mapGoal(SavingsGoalRow row) => SavingsGoal(
      id: row.id,
      name: row.name,
      targetAmount: Money(row.targetAmountMinor),
      currentAmount: Money(row.currentAmountMinor),
      targetDate: row.targetDate,
      monthlyContribution: row.monthlyContributionMinor == null
          ? null
          : Money(row.monthlyContributionMinor!),
      priority: row.priority,
      notes: row.notes,
      archived: row.archived,
    );

Investment mapInvestment(InvestmentRow row) => Investment(
      id: row.id,
      name: row.name,
      type: row.type,
      amount: Money(row.amountMinor),
      date: row.date,
      accountId: row.accountId,
      currentValue:
          row.currentValueMinor == null ? null : Money(row.currentValueMinor!),
      notes: row.notes,
    );

Budget mapBudget(BudgetRow row) => Budget(
      id: row.id,
      categoryId: row.categoryId,
      amount: Money(row.amountMinor),
      year: row.year,
      month: row.month,
      warn75: row.warn75,
      warn90: row.warn90,
      warn100: row.warn100,
    );

RecurringBill mapBill(BillRow row) => RecurringBill(
      id: row.id,
      name: row.name,
      amount: Money(row.amountMinor),
      dueDay: row.dueDay,
      frequency: row.frequency,
      accountId: row.accountId,
      categoryId: row.categoryId,
      reminder: row.reminder,
      autoPlan: row.autoPlan,
      archived: row.archived,
    );

Loan mapLoan(LoanRow row) => Loan(
      id: row.id,
      name: row.name,
      principal: Money(row.principalMinor),
      interestRate: row.interestRate,
      emi: Money(row.emiMinor),
      startDate: row.startDate,
      endDate: row.endDate,
      remaining: Money(row.remainingMinor),
      accountId: row.accountId,
      archived: row.archived,
    );

FinancialGoal mapFinancialGoal(FinancialGoalRow row) => FinancialGoal(
      id: row.id,
      name: row.name,
      targetAmount: Money(row.targetAmountMinor),
      currentAmount: Money(row.currentAmountMinor),
      deadline: row.deadline,
      requiredMonthly: row.requiredMonthlyMinor == null
          ? null
          : Money(row.requiredMonthlyMinor!),
      kind: row.kind,
      notes: row.notes,
    );

FinanceNote mapNote(NoteRow row) => FinanceNote(
      id: row.id,
      body: row.body,
      createdAt: row.createdAt,
      transactionId: row.transactionId,
      allocationId: row.allocationId,
      goalId: row.goalId,
      monthKey: row.monthKey,
      accountId: row.accountId,
    );

AuditEvent mapAudit(AuditLogRow row) => AuditEvent(
      id: row.id,
      action: row.action,
      at: row.at,
      payload: row.payload,
    );
