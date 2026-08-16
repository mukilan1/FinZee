import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/features.dart';
import '../../core/ids.dart';
import '../../core/money.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/list_controls.dart';
import '../../shared/widgets/transaction_row.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});
  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  String query = '';
  String sort = 'name';

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    bool match(String name) => query.isEmpty || name.toLowerCase().contains(query.toLowerCase());
    var savings = app.savingsGoals.where((g) => match(g.name)).toList();
    var financial = app.financialGoals.where((g) => match(g.name)).toList();
    savings.sort((a, b) => sort == 'amount'
        ? b.currentAmount.minor.compareTo(a.currentAmount.minor)
        : a.name.compareTo(b.name));
    financial.sort((a, b) => sort == 'amount'
        ? b.currentAmount.minor.compareTo(a.currentAmount.minor)
        : a.name.compareTo(b.name));
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          children: [
            Expanded(child: Text('Goals', style: Theme.of(context).textTheme.headlineMedium)),
            IconButton(
              tooltip: 'Add savings goal',
              onPressed: () => _editSavings(context),
              icon: const Icon(Icons.add_circle),
            ),
          ],
        ),
        ListControls(
          query: query,
          onQuery: (v) => setState(() => query = v),
          hint: 'Search goals',
          sorts: const [('name', 'Name'), ('amount', 'Progress')],
          sortId: sort,
          onSort: (v) => setState(() => sort = v),
        ),
        AddCta(label: 'Add savings goal', onPressed: () => _editSavings(context)),
        if (app.enabled(AppFeature.savingsGoals)) ...[
          const SizedBox(height: 8),
          const Text('Savings goals', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          if (savings.isEmpty)
            const Text('No savings goals yet.', style: TextStyle(color: FinzeeColors.textSecondary)),
          ...savings.map((g) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FinzeeCard(
                  child: InkWell(
                    onTap: () => _editSavings(context, g),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(g.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text('${g.currentAmount.format()} / ${g.targetAmount.format()}'),
                        if (g.targetDate != null)
                          Text('Target ${g.targetDate!.day}/${g.targetDate!.month}/${g.targetDate!.year}',
                              style: const TextStyle(color: FinzeeColors.textSecondary, fontSize: 12)),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: g.progress,
                          color: FinzeeColors.savings,
                          backgroundColor: FinzeeColors.primarySoft,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
        if (app.enabled(AppFeature.financialGoals)) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(child: Text('Financial goals', style: TextStyle(fontWeight: FontWeight.w600))),
              IconButton(onPressed: () => _editFinancial(context), icon: const Icon(Icons.add)),
            ],
          ),
          ...financial.map((g) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(g.name),
                subtitle: Text('${g.currentAmount.format()} / ${g.targetAmount.format()} · ${g.onTrack ? 'On track' : 'Behind'}'),
                onTap: () => _editFinancial(context, g),
              )),
        ],
      ],
    );
  }

  Future<void> _editSavings(BuildContext context, [SavingsGoal? existing]) async {
    final app = FinanceScope.of(context).app;
    final name = TextEditingController(text: existing?.name ?? '');
    final target = TextEditingController(text: existing == null ? '' : '${existing.targetAmount.major}');
    final current = TextEditingController(text: existing == null ? '0' : '${existing.currentAmount.major}');
    final monthly = TextEditingController(text: existing?.monthlyContribution == null ? '' : '${existing!.monthlyContribution!.major}');
    var targetDate = existing?.targetDate ?? DateTime.now().add(const Duration(days: 365));
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: Text(existing == null ? 'New savings goal' : 'Edit savings goal'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
                AmountField(controller: target, label: 'Target'),
                AmountField(controller: current, label: 'Current'),
                AmountField(controller: monthly, label: 'Monthly'),
                TimelineTile(
                  label: 'Target date',
                  date: targetDate,
                  onPick: () async {
                    final d = await pickTimeline(ctx, initial: targetDate);
                    if (d != null) setSt(() => targetDate = d);
                  },
                ),
              ],
            ),
          ),
          actions: [
            if (existing != null)
              TextButton(
                onPressed: () => confirmEraseFromEditor(
                  pageContext: context,
                  dialogContext: ctx,
                  title: 'Delete goal?',
                  erase: () => FinanceScope.of(context).run(() => app.deleteSavingsGoal(existing.id)),
                  failBody: () => FinanceScope.of(context).error,
                ),
                child: const Text('Delete'),
              ),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (ok == true && context.mounted) {
      await FinanceScope.of(context).run(
        () => app.upsertSavingsGoal(
          SavingsGoal(
            id: existing?.id ?? newId(),
            name: name.text.trim(),
            targetAmount: Money.parse(target.text),
            currentAmount: Money(
              ((double.tryParse(current.text.replaceAll(',', '')) ?? 0) * 100).round(),
            ),
            monthlyContribution: monthly.text.isEmpty ? null : Money.parse(monthly.text),
            targetDate: targetDate,
          ),
        ),
      );
    }
  }

  Future<void> _editFinancial(BuildContext context, [FinancialGoal? existing]) async {
    final app = FinanceScope.of(context).app;
    final name = TextEditingController(text: existing?.name ?? '');
    final target = TextEditingController(text: existing == null ? '' : '${existing.targetAmount.major}');
    final current = TextEditingController(text: existing == null ? '0' : '${existing.currentAmount.major}');
    var deadline = existing?.deadline ?? DateTime.now().add(const Duration(days: 365));
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: Text(existing == null ? 'New financial goal' : 'Edit financial goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
              AmountField(controller: target, label: 'Target'),
              AmountField(controller: current, label: 'Current'),
              TimelineTile(
                label: 'Deadline',
                date: deadline,
                onPick: () async {
                  final d = await pickTimeline(ctx, initial: deadline);
                  if (d != null) setSt(() => deadline = d);
                },
              ),
            ],
          ),
          actions: [
            if (existing != null)
              TextButton(
                onPressed: () => confirmEraseFromEditor(
                  pageContext: context,
                  dialogContext: ctx,
                  title: 'Delete financial goal?',
                  erase: () => FinanceScope.of(context).run(() => app.deleteFinancialGoal(existing.id)),
                  failBody: () => FinanceScope.of(context).error,
                ),
                child: const Text('Delete'),
              ),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (ok == true && context.mounted) {
      await FinanceScope.of(context).run(
        () => app.upsertFinancialGoal(
          FinancialGoal(
            id: existing?.id ?? newId(),
            name: name.text.trim(),
            targetAmount: Money.parse(target.text),
            currentAmount: Money(
              ((double.tryParse(current.text.replaceAll(',', '')) ?? 0) * 100).round(),
            ),
            deadline: deadline,
          ),
        ),
      );
    }
  }
}
