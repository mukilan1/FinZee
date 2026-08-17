import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Accounts,
    Categories,
    Transactions,
    IncomeSources,
    SalaryProfiles,
    SalaryHistory,
    MonthlyPlans,
    AllocationItems,
    AllocationTemplates,
    SavingsGoals,
    Investments,
    Budgets,
    Bills,
    Loans,
    FinancialGoals,
    Notes,
    AuditLogs,
    FeatureSettings,
    AppSettings,
    NetWorthSnapshots,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  factory AppDatabase.open() {
    return AppDatabase(
      driftDatabase(
        name: 'finzee_v2',
        web: DriftWebOptions(
          sqlite3Wasm: Uri.parse('sqlite3.wasm'),
          driftWorker: Uri.parse('drift_worker.js'),
        ),
      ),
    );
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(monthlyPlans, monthlyPlans.confirmedAt);
            await m.addColumn(allocationItems, allocationItems.createdAt);
            await m.addColumn(allocationItems, allocationItems.statusChangedAt);
            await m.addColumn(transactions, transactions.updatedAt);
            await m.addColumn(savingsGoals, savingsGoals.createdAt);
            await m.addColumn(savingsGoals, savingsGoals.updatedAt);
            await m.addColumn(savingsGoals, savingsGoals.completedAt);
            await m.addColumn(financialGoals, financialGoals.createdAt);
            await m.addColumn(financialGoals, financialGoals.updatedAt);
            await m.addColumn(financialGoals, financialGoals.completedAt);
          }
        },
      );
}
