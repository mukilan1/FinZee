import 'package:finzee/app/app.dart';
import 'package:finzee/app/finance_controller.dart';
import 'package:finzee/application/finance_app.dart';
import 'package:finzee/database/app_database.dart';
import 'package:finzee/database/finance_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('home shows FinZee dashboard after bootstrap', (tester) async {
    final db = AppDatabase.memory();
    addTearDown(db.close);
    final controller = FinanceController(FinanceApp(FinanceRepository(db)));
    await controller.start();
    await tester.pumpWidget(FinzeeApp(controller: controller));
    await tester.pumpAndSettle();
    expect(find.text('FinZee'), findsOneWidget);
    expect(find.text('How am I doing this month?'), findsOneWidget);
    expect(find.text('Home'), findsWidgets);
  });
}
