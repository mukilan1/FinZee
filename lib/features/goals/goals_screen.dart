import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/features.dart';
import '../../core/ids.dart';
import '../../core/money.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(child: Text('Goals', style: Theme.of(context).textTheme.headlineMedium)),
              IconButton(
                onPressed: () => _addSavings(context),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          if (app.enabled(AppFeature.savingsGoals)) ...[
            const SizedBox(height: 8),
            const Text('Savings goals', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            if (app.savingsGoals.isEmpty)
              const Text('No savings goals yet.', style: TextStyle(color: FinzeeColors.textSecondary)),
            ...app.savingsGoals.map((g) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: FinzeeCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(g.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text('${g.currentAmount.format()} / ${g.targetAmount.format()}'),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: g.progress,
                          color: FinzeeColors.savings,
                          backgroundColor: FinzeeColors.primarySoft,
                        ),
                        Text('${(g.progress * 100).round()}%', style: const TextStyle(fontSize: 12, color: FinzeeColors.textSecondary)),
                      ],
                    ),
                  ),
                )),
          ],
          if (app.enabled(AppFeature.financialGoals)) ...[
            const SizedBox(height: 16),
            const Text('Financial goals', style: TextStyle(fontWeight: FontWeight.w600)),
            ...app.financialGoals.map((g) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(g.name),
                  subtitle: Text('${g.currentAmount.format()} / ${g.targetAmount.format()} · ${g.onTrack ? 'On track' : 'Behind'}'),
                )),
          ],
          if (app.enabled(AppFeature.investments)) ...[
            const SizedBox(height: 16),
            const Text('Investments', style: TextStyle(fontWeight: FontWeight.w600)),
            ...app.investments.map((i) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(i.name),
                  subtitle: Text(i.type),
                  trailing: Text(i.marketValue.format()),
                )),
          ],
          if (app.enabled(AppFeature.loans)) ...[
            const SizedBox(height: 16),
            const Text('Debt', style: TextStyle(fontWeight: FontWeight.w600)),
            ...app.loans.map((l) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l.name),
                  subtitle: Text('EMI ${l.emi.format()}'),
                  trailing: Text(l.remaining.format()),
                )),
          ],
        ],
      ),
    );
  }

  Future<void> _addSavings(BuildContext context) async {
    final name = TextEditingController();
    final target = TextEditingController();
    final monthly = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New savings goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: target, decoration: const InputDecoration(labelText: 'Target', prefixText: '₹ ')),
            TextField(controller: monthly, decoration: const InputDecoration(labelText: 'Monthly', prefixText: '₹ ')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await FinanceScope.of(context).run(
        () => FinanceScope.of(context).app.upsertSavingsGoal(
              SavingsGoal(
                id: newId(),
                name: name.text,
                targetAmount: Money.parse(target.text),
                currentAmount: const Money(0),
                monthlyContribution: monthly.text.isEmpty ? null : Money.parse(monthly.text),
              ),
            ),
      );
    }
  }
}
