import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'app/finance_controller.dart';
import 'application/finance_app.dart';
import 'database/app_database.dart';
import 'database/finance_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    SemanticsBinding.instance.ensureSemantics();
  }
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final db = AppDatabase.open();
  final controller = FinanceController(
    FinanceApp(FinanceRepository(db), loadDemoIfEmpty: true),
  );
  await controller.start();
  runApp(FinzeeApp(controller: controller));
}
