import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/features.dart';
import '../../core/money.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    final app = ctrl.app;
    if (!app.enabled(AppFeature.salaryPlanning)) {
      return const EmptyState(
        title: 'Salary planning is off',
        bodyText: 'Enable Salary Planning in More → Features. Your data stays safe.',
      );
    }
    final planned = app.allocations.fold(const Money(0), (p, a) => p + a.plannedAmount);
    final unallocated = (app.plan?.expectedIncome ?? const Money(0)) - planned;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Monthly plan', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(app.plan?.periodKey ?? 'No plan generated yet',
              style: const TextStyle(color: FinzeeColors.textSecondary)),
          const SizedBox(height: 16),
          FinzeeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Expected income  ${(app.plan?.expectedIncome ?? app.salary?.baseAmount ?? const Money(0)).format()}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                const SizedBox(height: 8),
                Text('Planned ${planned.format()}'),
                Text('Unallocated ${unallocated.format()}'),
                if (app.plan?.confirmed == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('Confirmed', style: TextStyle(color: FinzeeColors.income)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => ctrl.run(app.generateThisMonth),
            child: const Text('Generate this month'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: app.plan == null ? null : () => ctrl.run(app.confirmThisMonth),
            child: const Text('Confirm plan'),
          ),
          const SizedBox(height: 20),
          if (app.allocations.isEmpty)
            const EmptyState(title: 'No allocations', subtitle: 'Generate a plan or add a monthly template in More.')
          else
            ...app.allocations.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _AllocationTile(item: item),
                )),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.title, this.subtitle, this.bodyText});
  final String title;
  final String? subtitle;
  final String? bodyText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(subtitle ?? bodyText ?? '', textAlign: TextAlign.center, style: const TextStyle(color: FinzeeColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _AllocationTile extends StatelessWidget {
  const _AllocationTile({required this.item});
  final AllocationItem item;

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final ctrl = FinanceScope.of(context);
    return FinzeeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600))),
              _StatusPill(status: item.status),
            ],
          ),
          Text('${item.plannedAmount.format()} planned'),
          if (item.actualAmount != null) Text('${item.actualAmount!.format()} actual'),
          if (item.skipNote != null) Text(item.skipNote!, style: const TextStyle(color: FinzeeColors.textSecondary)),
          if (item.status == AllocationStatus.pending) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => ctrl.run(
                      () => app.completeAllocation(item.id, item.plannedAmount, app.accounts.first.id),
                    ),
                    child: const Text('Complete'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final note = TextEditingController();
                      SkipReason reason = SkipReason.unexpectedExpense;
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => StatefulBuilder(
                          builder: (ctx, setSt) => AlertDialog(
                            title: const Text('Skip allocation'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DropdownButton<SkipReason>(
                                  value: reason,
                                  isExpanded: true,
                                  items: SkipReason.values
                                      .map((r) => DropdownMenuItem(value: r, child: Text(r.name)))
                                      .toList(),
                                  onChanged: (v) => setSt(() => reason = v!),
                                ),
                                TextField(controller: note, decoration: const InputDecoration(labelText: 'Note')),
                              ],
                            ),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                              FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Skip')),
                            ],
                          ),
                        ),
                      );
                      if (ok == true) {
                        await ctrl.run(() => app.skipAllocation(item.id, reason, note.text));
                      }
                    },
                    child: const Text('Skip'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});
  final AllocationStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      AllocationStatus.completed => FinzeeColors.income,
      AllocationStatus.skipped => FinzeeColors.expense,
      AllocationStatus.partial => FinzeeColors.warning,
      AllocationStatus.pending => FinzeeColors.info,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
      child: Text(status.name, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
