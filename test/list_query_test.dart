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
}
