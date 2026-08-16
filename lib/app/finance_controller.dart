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
      error = _friendly(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> run(Future<void> Function() action) async {
    error = null;
    try {
      await action();
      notifyListeners();
      return true;
    } catch (e) {
      error = _friendly(e);
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    error = null;
    notifyListeners();
  }

  void lockApp() {
    app.lockApp();
    notifyListeners();
  }

  String _friendly(Object e) {
    final text = e.toString();
    final idx = text.indexOf(': ');
    return idx == -1 ? text : text.substring(idx + 2);
  }
}
