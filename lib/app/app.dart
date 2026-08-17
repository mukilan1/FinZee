import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'finance_controller.dart';
import 'finance_scope.dart';
import 'router.dart';
import 'theme.dart';

class FinzeeApp extends StatefulWidget {
  const FinzeeApp({super.key, required this.controller});

  final FinanceController controller;

  @override
  State<FinzeeApp> createState() => _FinzeeAppState();
}

class _FinzeeAppState extends State<FinzeeApp> with WidgetsBindingObserver {
  late final GoRouter _router = createAppRouter();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) {
      if (widget.controller.app.lockEnabled) {
        widget.controller.lockApp();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FinanceScope(
      controller: widget.controller,
      child: ListenableBuilder(
        listenable: widget.controller,
        builder: (context, _) {
          final themeMode = widget.controller.app.themePreference.themeMode;
          return MaterialApp.router(
            title: 'FinZee',
            debugShowCheckedModeBanner: false,
            theme: buildFinzeeLightTheme(),
            darkTheme: buildFinzeeDarkTheme(),
            themeMode: themeMode,
            routerConfig: _router,
            builder: (context, child) {
              final locked =
                  widget.controller.app.lockEnabled && !widget.controller.app.unlocked;
              return Stack(
                children: [
                  child ?? const SizedBox.shrink(),
                  if (locked) const _LockGate(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _LockGate extends StatefulWidget {
  const _LockGate();

  @override
  State<_LockGate> createState() => _LockGateState();
}

class _LockGateState extends State<_LockGate> {
  bool _busy = false;
  String? _message;

  Future<void> _unlock() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    final ctrl = FinanceScope.of(context);
    final ok = await ctrl.unlockApp();
    if (!mounted) return;
    if (ok) {
      return;
    }
    setState(() {
      _busy = false;
      _message = ctrl.app.lastAuthMessage ??
          'Unlock cancelled. Use your phone\'s fingerprint, face, or screen lock.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.finzee;
    return Material(
      color: palette.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fingerprint, size: 48, color: palette.primaryDark),
              const SizedBox(height: 16),
              Text('FinZee is locked', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              const Text(
                'Use your device screen lock to open FinZee. Nothing is sent anywhere.',
                textAlign: TextAlign.center,
              ),
              if (_message != null) ...[
                const SizedBox(height: 12),
                Text(
                  _message!,
                  style: TextStyle(color: palette.expense),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _busy ? null : _unlock,
                icon: _busy
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: palette.background,
                        ),
                      )
                    : const Icon(Icons.lock_open),
                label: Text(_busy ? 'Waiting for device unlock…' : 'Unlock FinZee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
