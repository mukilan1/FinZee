import 'package:flutter/material.dart';

import 'finance_controller.dart';
import 'finance_scope.dart';
import 'router.dart';
import 'theme.dart';

class FinzeeApp extends StatelessWidget {
  const FinzeeApp({super.key, required this.controller});

  final FinanceController controller;

  @override
  Widget build(BuildContext context) {
    return FinanceScope(
      controller: controller,
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          return MaterialApp.router(
            title: 'FinZee',
            debugShowCheckedModeBanner: false,
            theme: buildFinzeeTheme(),
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
