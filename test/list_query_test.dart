import 'package:drift/native.dart';
import 'package:finzee/application/finance_app.dart';
import 'package:finzee/database/app_database.dart';
import 'package:finzee/database/finance_repository.dart';
import 'package:finzee/shared/list_query.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late FinanceApp app;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    app = FinanceApp(FinanceRepository(db));
    await app.bootstrap();
  });

  tearDown(() async => db.close());

  test('saved list query restores after reload', () async {
    const saved = ListQueryState(
      query: 'coffee',
      filters: {'type': 'expense', 'account': 'acc_bank'},
      sortId: 'amount',
    );
    await app.saveListQuery(ListQueryKeys.transactions, saved);
    await app.reload();

    final restored = await app.loadListQuery(
      ListQueryKeys.transactions,
      defaultSort: 'date',
    );
    expect(restored.query, 'coffee');
    expect(restored.filters['type'], 'expense');
    expect(restored.filters['account'], 'acc_bank');
    expect(restored.sortId, 'amount');
  });

  test('list query round-trips through json', () {
    const original = ListQueryState(
      query: 'test',
      filters: {'filter': 'pending'},
      sortId: 'name',
    );
    final decoded = ListQueryState.fromJson(original.toJson());
    expect(decoded.query, original.query);
    expect(decoded.filters, original.filters);
    expect(decoded.sortId, original.sortId);
  });

  test('list query settings survive backup restore', () async {
    const saved = ListQueryState(
      query: 'rent',
      filters: {'type': 'expense'},
      sortId: 'date',
    );
    await app.saveListQuery(ListQueryKeys.transactions, saved);

    final json = await app.backup.exportJson();
    await app.reload();

    final beforeRestore = await app.loadListQuery(
      ListQueryKeys.transactions,
      defaultSort: 'date',
    );
    expect(beforeRestore.query, 'rent');

    final safety = await app.backup.exportJson();
    await app.backup.restore(json, safetyBackup: safety);
    await app.reload();

    final restored = await app.loadListQuery(
      ListQueryKeys.transactions,
      defaultSort: 'date',
    );
    expect(restored.query, 'rent');
    expect(restored.filters['type'], 'expense');
    expect(restored.sortId, 'date');
  });
}
