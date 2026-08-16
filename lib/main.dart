import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'app/finance_controller.dart';
import 'application/finance_app.dart';
import 'database/app_database.dart';
import 'database/finance_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final db = await AppDatabase.open();
  final controller = FinanceController(FinanceApp(FinanceRepository(db)));
  await controller.start();
  runApp(FinzeeApp(controller: controller));
}
