import 'package:finzee/shared/list_query.dart';
import 'package:finzee/shared/widgets/list_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mergeFilterDraft', () {
    const groups = [
      FilterGroup(
        id: 'type',
        label: 'Type',
        options: [(null, 'All'), ('income', 'income'), ('expense', 'expense')],
      ),
      FilterGroup(
        id: 'account',
        label: 'Account',
        options: [(null, 'All'), ('acc_bank', 'Bank')],
      ),
    ];

    test('keeps untouched groups when only one group changes', () {
      final merged = mergeFilterDraft(
        {'type': null, 'account': 'acc_bank'},
        {'type': 'expense'},
        groups,
      );
      expect(merged['type'], 'expense');
      expect(merged['account'], 'acc_bank');
    });

    test('clears a group when draft sets null', () {
      final merged = mergeFilterDraft(
        {'type': 'income', 'account': 'acc_bank'},
        {'type': null},
        groups,
      );
      expect(merged['type'], isNull);
      expect(merged['account'], 'acc_bank');
    });
  });

  testWidgets('applying a filter updates list and shows active pill', (tester) async {
    var listQuery = const ListQueryState(filters: {'filter': 'expense'});
    final items = <String>['income-tx', 'expense-tx'];

    List<String> filtered() {
      final typeFilter = listQuery.filters['filter'];
      return items.where((i) => typeFilter == null || i.startsWith(typeFilter)).toList();
    }

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (context, setState) {
            final visible = filtered();
            return Column(
              children: [
                ListControls(
                  state: listQuery,
                  onApplied: (next) => setState(() => listQuery = next),
                  defaultSortId: 'name',
                  filters: const ['income', 'expense'],
                ),
                Expanded(
                  child: ListView(
                    children: visible.map((t) => Text(t)).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );

  expect(find.text('expense-tx'), findsOneWidget);
  expect(find.text('income-tx'), findsNothing);
  expect(find.textContaining('Filter: expense'), findsOneWidget);

  await tester.tap(find.byTooltip('Filters'));
  await tester.pumpAndSettle();

  await tester.tap(find.text('income'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Apply'));
  await tester.pumpAndSettle();

  expect(find.text('income-tx'), findsOneWidget);
  expect(find.text('expense-tx'), findsNothing);
  expect(find.textContaining('Filter: income'), findsOneWidget);

  await tester.tap(find.byTooltip('Filters'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Reset').first);
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(FilledButton, 'Reset'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Apply'));
  await tester.pumpAndSettle();

  expect(find.text('income-tx'), findsOneWidget);
  expect(find.text('expense-tx'), findsOneWidget);
  expect(find.textContaining('Filter:'), findsNothing);
  });
}
