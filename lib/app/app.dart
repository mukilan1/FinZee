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
            builder: (context, child) {
              final locked = controller.app.lockEnabled && !controller.app.unlocked;
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
  final pin = TextEditingController();

  @override
  void dispose() {
    pin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    return Material(
      color: FinzeeColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 48, color: FinzeeColors.primaryDark),
              const SizedBox(height: 16),
              Text('FinZee is locked', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              const Text('Enter your local PIN. Nothing is sent anywhere.'),
              const SizedBox(height: 24),
              TextField(
                controller: pin,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'PIN'),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ctrl.run(() => ctrl.app.unlockWithPin(pin.text)),
                child: const Text('Unlock'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
