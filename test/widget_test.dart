import 'package:drift/native.dart';
import 'package:finzee/app/app.dart';
import 'package:finzee/app/finance_controller.dart';
import 'package:finzee/application/finance_app.dart';
import 'package:finzee/database/app_database.dart';
import 'package:finzee/database/finance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(FinanceController controller) => FinzeeApp(controller: controller);

void main() {
  late AppDatabase db;
  late FinanceController controller;

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(_app(controller));
    await tester.pumpAndSettle();
  }

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    controller = FinanceController(FinanceApp(FinanceRepository(db)));
    await controller.start();
  });

  tearDown(() async => db.close());

  testWidgets('home shows FinZee dashboard after bootstrap', (tester) async {
    await pumpApp(tester);
    expect(find.text('FinZee'), findsWidgets);
    expect(find.text('How am I doing this month?'), findsOneWidget);
  });

  testWidgets('bottom navigation reaches transactions, plan, goals, more', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('Transactions')));
    await tester.pumpAndSettle();
    expect(find.text('Transactions'), findsWidgets);
    await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('Plan')));
    await tester.pumpAndSettle();
    expect(find.text('Salary planning is off'), findsOneWidget);
    await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('Goals')));
    await tester.pumpAndSettle();
    expect(find.text('Goals'), findsWidgets);
    await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('More')));
    await tester.pumpAndSettle();
    expect(find.text('Backup & restore'), findsOneWidget);
    expect(find.text('Features'), findsOneWidget);
    expect(find.byTooltip('Notifications'), findsOneWidget);
  });

  testWidgets('accounts page shows add account actions', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('More')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Accounts'));
    await tester.pumpAndSettle();
    expect(find.text('Add account'), findsWidgets);
    expect(find.byTooltip('Add account'), findsWidgets);
  });

  testWidgets('adding an expense from the sheet updates home', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '250');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(controller.app.transactions, isNotEmpty);
    expect(controller.app.dashboard().expenses.minor, 25000);
  });

  testWidgets('invalid amount shows an error instead of crashing', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.textContaining('valid amount'), findsWidgets);
  });
}
