import 'package:flutter/material.dart';

import '../../app/finance_controller.dart';
import '../../app/theme.dart';

void showFinzeeSnackBar(
  BuildContext context,
  String message, {
  bool error = false,
}) {
  final messenger = ScaffoldMessenger.maybeOf(context);
  if (messenger == null) return;
  final palette = context.finzee;
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: error ? Colors.white : palette.background),
      ),
      backgroundColor: error ? palette.expense : palette.primaryDark,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
    ),
  );
}

Future<bool> runWithFeedback(
  BuildContext context,
  FinanceController ctrl,
  Future<void> Function() action, {
  required String successMessage,
  String? failureMessage,
}) async {
  final ok = await ctrl.run(action);
  if (!context.mounted) return ok;
  if (ok) {
    showFinzeeSnackBar(context, successMessage);
  } else {
    showFinzeeSnackBar(
      context,
      failureMessage ?? ctrl.error ?? 'Something went wrong.',
      error: true,
    );
  }
  return ok;
}
