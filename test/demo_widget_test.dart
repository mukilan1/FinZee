import 'package:drift/native.dart';
import 'package:finzee/app/app.dart';
import 'package:finzee/app/finance_controller.dart';
import 'package:finzee/application/finance_app.dart';
import 'package:finzee/database/app_database.dart';
import 'package:finzee/database/finance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late FinanceController controller;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    controller = FinanceController(
      FinanceApp(FinanceRepository(db), loadDemoIfEmpty: true),
    );
    await controller.start();
  });

  tearDown(() async => db.close());

  testWidgets('sample household is visible across tabs', (tester) async {
    await tester.binding.setSurfaceSize(const Size(420, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(FinzeeApp(controller: controller));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(controller.app.transactions.length, greaterThan(80));
    expect(find.text('FinZee'), findsWidgets);

    await tester.tap(
      find.descendant(of: find.byType(NavigationBar), matching: find.text('Plan')),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Salary planning is off'), findsNothing);
    expect(find.text('Monthly plan'), findsWidgets);

    await tester.tap(
      find.descendant(of: find.byType(NavigationBar), matching: find.text('Goals')),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Emergency Fund'), findsWidgets);

    await tester.tap(
      find.descendant(of: find.byType(NavigationBar), matching: find.text('More')),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Sample data'), findsOneWidget);
    expect(find.byTooltip('Notifications'), findsOneWidget);

    await tester.tap(find.byTooltip('Notifications'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Notifications'), findsWidgets);
  });
}
