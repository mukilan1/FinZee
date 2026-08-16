import '../core/money.dart';

enum AccountType {
  cash,
  bank,
  savings,
  creditCard,
  wallet,
  upi,
  investment,
  custom,
}

class Account {
  const Account({
    required this.id,
    required this.name,
    required this.type,
    required this.openingBalance,
    this.currency = 'INR',
    this.notes,
    this.archived = false,
    required this.createdAt,
  });

  final String id;
  final String name;
  final AccountType type;
  final Money openingBalance;
  final String currency;
  final String? notes;
  final bool archived;
  final DateTime createdAt;

  bool get isLiability => type == AccountType.creditCard;
}

enum CategoryKind { expense, income }

class Category {
  const Category({
    required this.id,
    required this.name,
    required this.kind,
    this.parentId,
    this.icon = 'category',
    this.sortOrder = 0,
    this.archived = false,
  });

  final String id;
  final String name;
  final CategoryKind kind;
  final String? parentId;
  final String icon;
  final int sortOrder;
  final bool archived;
}

enum TransactionType { income, expense, transfer, saving, investment }

class FinanceTransaction {
  const FinanceTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.accountId,
    this.toAccountId,
    this.categoryId,
    this.subcategoryId,
    this.paymentMethod,
    this.incomeSourceId,
    this.note,
    this.tags = const [],
    this.attachmentPath,
    this.allocationItemId,
    this.goalId,
    this.investmentId,
    required this.createdAt,
  });

  final String id;
  final TransactionType type;
  final Money amount;
  final DateTime date;
  final String accountId;
  final String? toAccountId;
  final String? categoryId;
  final String? subcategoryId;
  final String? paymentMethod;
  final String? incomeSourceId;
  final String? note;
  final List<String> tags;
  final String? attachmentPath;
  final String? allocationItemId;
  final String? goalId;
  final String? investmentId;
  final DateTime createdAt;
}

class IncomeSource {
  const IncomeSource({
    required this.id,
    required this.name,
    this.archived = false,
  });

  final String id;
  final String name;
  final bool archived;
}

class SalaryProfile {
  const SalaryProfile({
    required this.id,
    required this.baseAmount,
    required this.payDay,
    this.frequency = 'monthly',
    this.currency = 'INR',
    this.source = 'Employer',
    required this.effectiveFrom,
    this.active = true,
  });

  final String id;
  final Money baseAmount;
  final int payDay;
  final String frequency;
  final String currency;
  final String source;
  final DateTime effectiveFrom;
  final bool active;
}

class SalaryHistoryEntry {
  const SalaryHistoryEntry({
    required this.id,
    required this.previousAmount,
    required this.newAmount,
    required this.effectiveDate,
    this.reason,
    this.notes,
  });

  final String id;
  final Money previousAmount;
  final Money newAmount;
  final DateTime effectiveDate;
  final String? reason;
  final String? notes;

  double get percentChange => previousAmount.minor == 0
      ? 100
      : ((newAmount.minor - previousAmount.minor) / previousAmount.minor) * 100;
}

enum AllocationKind { savings, investment, expense, bill, loanEmi }

enum AllocationStatus { pending, completed, skipped, partial }

enum SkipReason {
  emergency,
  family,
  travel,
  medical,
  unexpectedExpense,
  other,
}

class MonthlyPlan {
  const MonthlyPlan({
    required this.id,
    required this.year,
    required this.month,
    required this.expectedIncome,
    this.confirmed = false,
    required this.createdAt,
  });

  final String id;
  final int year;
  final int month;
  final Money expectedIncome;
  final bool confirmed;
  final DateTime createdAt;

  String get periodKey =>
      '$year-${month.toString().padLeft(2, '0')}';
}

class AllocationItem {
  const AllocationItem({
    required this.id,
    required this.planId,
    required this.name,
    required this.kind,
    required this.plannedAmount,
    this.actualAmount,
    this.status = AllocationStatus.pending,
    this.categoryId,
    this.goalId,
    this.investmentId,
    this.billId,
    this.loanId,
    this.accountId,
    this.skipReason,
    this.skipNote,
    this.sortOrder = 0,
  });

  final String id;
  final String planId;
  final String name;
  final AllocationKind kind;
  final Money plannedAmount;
  final Money? actualAmount;
  final AllocationStatus status;
  final String? categoryId;
  final String? goalId;
  final String? investmentId;
  final String? billId;
  final String? loanId;
  final String? accountId;
  final SkipReason? skipReason;
  final String? skipNote;
  final int sortOrder;

  Money get remaining {
    final actual = actualAmount ?? const Money(0);
    return plannedAmount - actual;
  }
}

class AllocationTemplateItem {
  const AllocationTemplateItem({
    required this.id,
    required this.name,
    required this.kind,
    required this.plannedAmount,
    this.categoryId,
    this.goalId,
    this.investmentId,
    this.billId,
    this.loanId,
    this.accountId,
    this.sortOrder = 0,
  });

  final String id;
  final String name;
  final AllocationKind kind;
  final Money plannedAmount;
  final String? categoryId;
  final String? goalId;
  final String? investmentId;
  final String? billId;
  final String? loanId;
  final String? accountId;
  final int sortOrder;
}

class SavingsGoal {
  const SavingsGoal({
    required this.id,
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    this.targetDate,
    this.monthlyContribution,
    this.priority = 1,
    this.notes,
    this.archived = false,
  });

  final String id;
  final String name;
  final Money targetAmount;
  final Money currentAmount;
  final DateTime? targetDate;
  final Money? monthlyContribution;
  final int priority;
  final String? notes;
  final bool archived;

  double get progress => targetAmount.minor == 0
      ? 0
      : (currentAmount.minor / targetAmount.minor).clamp(0, 1);
}

class Investment {
  const Investment({
    required this.id,
    required this.name,
    required this.type,
    required this.amount,
    required this.date,
    this.accountId,
    this.currentValue,
    this.notes,
  });

  final String id;
  final String name;
  final String type;
  final Money amount;
  final DateTime date;
  final String? accountId;
  final Money? currentValue;
  final String? notes;

  Money get marketValue => currentValue ?? amount;
}

class Budget {
  const Budget({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.year,
    required this.month,
    this.warn75 = true,
    this.warn90 = true,
    this.warn100 = true,
  });

  final String id;
  final String categoryId;
  final Money amount;
  final int year;
  final int month;
  final bool warn75;
  final bool warn90;
  final bool warn100;
}

class RecurringBill {
  const RecurringBill({
    required this.id,
    required this.name,
    required this.amount,
    required this.dueDay,
    this.frequency = 'monthly',
    this.accountId,
    this.categoryId,
    this.reminder = true,
    this.autoPlan = true,
    this.archived = false,
  });

  final String id;
  final String name;
  final Money amount;
  final int dueDay;
  final String frequency;
  final String? accountId;
  final String? categoryId;
  final bool reminder;
  final bool autoPlan;
  final bool archived;
}

class Loan {
  const Loan({
    required this.id,
    required this.name,
    required this.principal,
    required this.interestRate,
    required this.emi,
    required this.startDate,
    required this.endDate,
    required this.remaining,
    this.accountId,
    this.archived = false,
  });

  final String id;
  final String name;
  final Money principal;
  final double interestRate;
  final Money emi;
  final DateTime startDate;
  final DateTime endDate;
  final Money remaining;
  final String? accountId;
  final bool archived;
}

class FinancialGoal {
  const FinancialGoal({
    required this.id,
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    this.deadline,
    this.requiredMonthly,
    this.kind = 'general',
    this.notes,
  });

  final String id;
  final String name;
  final Money targetAmount;
  final Money currentAmount;
  final DateTime? deadline;
  final Money? requiredMonthly;
  final String kind;
  final String? notes;

  double get progress => targetAmount.minor == 0
      ? 0
      : (currentAmount.minor / targetAmount.minor).clamp(0, 1);

  bool get onTrack {
    if (deadline == null || requiredMonthly == null) return progress >= 0.5;
    return currentAmount.minor >= requiredMonthly!.minor;
  }
}

class FinanceNote {
  const FinanceNote({
    required this.id,
    required this.body,
    required this.createdAt,
    this.transactionId,
    this.allocationId,
    this.goalId,
    this.monthKey,
    this.accountId,
  });

  final String id;
  final String body;
  final DateTime createdAt;
  final String? transactionId;
  final String? allocationId;
  final String? goalId;
  final String? monthKey;
  final String? accountId;
}

class AuditEvent {
  const AuditEvent({
    required this.id,
    required this.action,
    required this.at,
    this.payload,
  });

  final String id;
  final String action;
  final DateTime at;
  final String? payload;
}

class AppLockSettings {
  const AppLockSettings({
    this.enabled = false,
    this.useBiometric = false,
    this.autoLockSeconds = 60,
  });

  final bool enabled;
  final bool useBiometric;
  final int autoLockSeconds;
}

class LocalAlert {
  const LocalAlert({
    required this.id,
    required this.title,
    required this.body,
    required this.kind,
  });

  final String id;
  final String title;
  final String body;
  final String kind;
}
