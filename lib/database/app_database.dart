import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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

  factory AppDatabase.memory() => AppDatabase(NativeDatabase.memory());

  factory AppDatabase.file(File file) => AppDatabase(NativeDatabase(file));

  static Future<AppDatabase> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'finzee.sqlite'));
    return AppDatabase.file(file);
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
      );
}
