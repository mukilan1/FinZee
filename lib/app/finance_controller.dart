import 'package:flutter/foundation.dart';

import '../application/finance_app.dart';

class FinanceController extends ChangeNotifier {
  FinanceController(this.app);

  final FinanceApp app;
  bool loading = true;
  String? error;

  Future<void> start() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      await app.bootstrap();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> run(Future<void> Function() action) async {
    error = null;
    try {
      await action();
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
