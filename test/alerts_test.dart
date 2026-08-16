import 'package:drift/native.dart';
import 'package:finzee/application/demo_data.dart';
import 'package:finzee/application/finance_app.dart';
import 'package:finzee/core/features.dart';
import 'package:finzee/database/app_database.dart';
import 'package:finzee/database/finance_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late FinanceApp app;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    app = FinanceApp(FinanceRepository(db));
    await app.bootstrap();
    await DemoDataLoader(app).load();
  });

  tearDown(() async => db.close());

  test('demo household produces alerts across enabled modules', () {
    final alerts = app.allAlerts();
    expect(alerts, isNotEmpty);
    expect(alerts.any((a) => a.kind == 'allocation'), isTrue);
    expect(alerts.any((a) => a.kind == 'account'), isTrue);
    expect(app.unreadAlertCount(), alerts.length);
  });

  test('turning a feature off hides its alerts without deleting data', () async {
    final beforeBills = app.bills.length;
    await app.setFeature(AppFeature.investments, false);
    expect(app.allAlerts().any((a) => a.kind == 'investment'), isFalse);
    expect(app.investments, isNotEmpty);
    await app.setFeature(AppFeature.salaryPlanning, false);
    expect(app.allAlerts().any((a) => a.kind == 'allocation'), isFalse);
    await app.setFeature(AppFeature.bills, false);
    expect(app.allAlerts().any((a) => a.kind == 'bill'), isFalse);
    expect(app.bills.length, beforeBills);
  });

  test('dismissed alerts stay gone after reload and backup restore', () async {
    final first = app.allAlerts().first;
    await app.dismissAlert(first.id);
    expect(app.allAlerts().any((a) => a.id == first.id), isFalse);
    await app.reload();
    expect(app.allAlerts().any((a) => a.id == first.id), isFalse);

    final json = await app.backup.exportJson();
    expect(json, contains('alert_dismissed_ids'));
    final safety = await app.backup.exportJson();
    await app.backup.restore(json, safetyBackup: safety);
    await app.reload();
    expect(app.allAlerts().any((a) => a.id == first.id), isFalse);
    expect(app.transactions, isNotEmpty);
  });

  test('marking the inbox read clears the unread badge count', () async {
    expect(app.unreadAlertCount(), greaterThan(0));
    await app.markInboxRead();
    expect(app.unreadAlertCount(), 0);
    expect(app.allAlerts(), isNotEmpty);
  });
}
