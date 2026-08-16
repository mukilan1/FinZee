import 'package:flutter/material.dart';

import 'finance_controller.dart';

class FinanceScope extends InheritedNotifier<FinanceController> {
  const FinanceScope({
    super.key,
    required FinanceController controller,
    required super.child,
  }) : super(notifier: controller);

  static FinanceController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<FinanceScope>();
    assert(scope != null, 'FinanceScope not found');
    return scope!.notifier!;
  }
}
