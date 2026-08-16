import 'package:drift/drift.dart';

@DataClassName('AccountRow')
class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get openingBalanceMinor => integer()();
  TextColumn get currency => text().withDefault(const Constant('INR'))();
  TextColumn get notes => text().nullable()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CategoryRow')
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get kind => text()();
  TextColumn get parentId => text().nullable()();
  TextColumn get icon => text().withDefault(const Constant('category'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('TransactionRow')
class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()();
  IntColumn get amountMinor => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get accountId => text()();
  TextColumn get toAccountId => text().nullable()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get subcategoryId => text().nullable()();
  TextColumn get paymentMethod => text().nullable()();
  TextColumn get incomeSourceId => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get tagsJson => text().withDefault(const Constant('[]'))();
  TextColumn get attachmentPath => text().nullable()();
  TextColumn get allocationItemId => text().nullable()();
  TextColumn get goalId => text().nullable()();
  TextColumn get investmentId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('IncomeSourceRow')
class IncomeSources extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SalaryProfileRow')
class SalaryProfiles extends Table {
  TextColumn get id => text()();
  IntColumn get baseAmountMinor => integer()();
  IntColumn get payDay => integer()();
  TextColumn get frequency => text().withDefault(const Constant('monthly'))();
  TextColumn get currency => text().withDefault(const Constant('INR'))();
  TextColumn get source => text().withDefault(const Constant('Employer'))();
  DateTimeColumn get effectiveFrom => dateTime()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SalaryHistoryRow')
class SalaryHistory extends Table {
  TextColumn get id => text()();
  IntColumn get previousAmountMinor => integer()();
  IntColumn get newAmountMinor => integer()();
  DateTimeColumn get effectiveDate => dateTime()();
  TextColumn get reason => text().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MonthlyPlanRow')
class MonthlyPlans extends Table {
  TextColumn get id => text()();
  IntColumn get year => integer()();
  IntColumn get month => integer()();
  IntColumn get expectedIncomeMinor => integer()();
  BoolColumn get confirmed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('AllocationItemRow')
class AllocationItems extends Table {
  TextColumn get id => text()();
  TextColumn get planId => text()();
  TextColumn get name => text()();
  TextColumn get kind => text()();
  IntColumn get plannedAmountMinor => integer()();
  IntColumn get actualAmountMinor => integer().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get categoryId => text().nullable()();
  TextColumn get goalId => text().nullable()();
  TextColumn get investmentId => text().nullable()();
  TextColumn get billId => text().nullable()();
  TextColumn get loanId => text().nullable()();
  TextColumn get accountId => text().nullable()();
  TextColumn get skipReason => text().nullable()();
  TextColumn get skipNote => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('AllocationTemplateRow')
class AllocationTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get kind => text()();
  IntColumn get plannedAmountMinor => integer()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get goalId => text().nullable()();
  TextColumn get investmentId => text().nullable()();
  TextColumn get billId => text().nullable()();
  TextColumn get loanId => text().nullable()();
  TextColumn get accountId => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SavingsGoalRow')
class SavingsGoals extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get targetAmountMinor => integer()();
  IntColumn get currentAmountMinor => integer().withDefault(const Constant(0))();
  DateTimeColumn get targetDate => dateTime().nullable()();
  IntColumn get monthlyContributionMinor => integer().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(1))();
  TextColumn get notes => text().nullable()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('InvestmentRow')
class Investments extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get amountMinor => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get accountId => text().nullable()();
  IntColumn get currentValueMinor => integer().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('BudgetRow')
class Budgets extends Table {
  TextColumn get id => text()();
  TextColumn get categoryId => text()();
  IntColumn get amountMinor => integer()();
  IntColumn get year => integer()();
  IntColumn get month => integer()();
  BoolColumn get warn75 => boolean().withDefault(const Constant(true))();
  BoolColumn get warn90 => boolean().withDefault(const Constant(true))();
  BoolColumn get warn100 => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('BillRow')
class Bills extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get amountMinor => integer()();
  IntColumn get dueDay => integer()();
  TextColumn get frequency => text().withDefault(const Constant('monthly'))();
  TextColumn get accountId => text().nullable()();
  TextColumn get categoryId => text().nullable()();
  BoolColumn get reminder => boolean().withDefault(const Constant(true))();
  BoolColumn get autoPlan => boolean().withDefault(const Constant(true))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('LoanRow')
class Loans extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get principalMinor => integer()();
  RealColumn get interestRate => real()();
  IntColumn get emiMinor => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  IntColumn get remainingMinor => integer()();
  TextColumn get accountId => text().nullable()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('FinancialGoalRow')
class FinancialGoals extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get targetAmountMinor => integer()();
  IntColumn get currentAmountMinor => integer().withDefault(const Constant(0))();
  DateTimeColumn get deadline => dateTime().nullable()();
  IntColumn get requiredMonthlyMinor => integer().nullable()();
  TextColumn get kind => text().withDefault(const Constant('general'))();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('NoteRow')
class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get body => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get transactionId => text().nullable()();
  TextColumn get allocationId => text().nullable()();
  TextColumn get goalId => text().nullable()();
  TextColumn get monthKey => text().nullable()();
  TextColumn get accountId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('AuditLogRow')
class AuditLogs extends Table {
  TextColumn get id => text()();
  TextColumn get action => text()();
  DateTimeColumn get at => dateTime()();
  TextColumn get payload => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('FeatureSettingRow')
class FeatureSettings extends Table {
  TextColumn get featureKey => text()();
  BoolColumn get enabled => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {featureKey};
}

@DataClassName('AppSettingRow')
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DataClassName('NetWorthSnapshotRow')
class NetWorthSnapshots extends Table {
  TextColumn get id => text()();
  DateTimeColumn get at => dateTime()();
  IntColumn get assetsMinor => integer()();
  IntColumn get liabilitiesMinor => integer()();
  IntColumn get netMinor => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
