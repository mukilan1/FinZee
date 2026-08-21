import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/features.dart';
import '../../core/ids.dart';
import '../../core/money.dart';
import '../../domain/entities.dart';
import '../../shared/list_query.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/feedback.dart';
import '../../shared/widgets/finzee_ui.dart';
import '../../shared/widgets/list_controls.dart';
import '../../shared/widgets/list_query_host.dart';
import '../../shared/widgets/transaction_row.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});
  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> with PersistentListQuery {
  @override
  String get listQueryKey => ListQueryKeys.goals;

  @override
  String get listQueryDefaultSort => 'name';

  @override
  Widget build(BuildContext context) {
    if (!listQueryReady) {
      return const Center(child: CircularProgressIndicator());
    }
    final app = FinanceScope.of(context).app;
    bool match(String name) =>
        listQuery.query.isEmpty || name.toLowerCase().contains(listQuery.query.toLowerCase());
    var savings = app.savingsGoals.where((g) => match(g.name)).toList();
    var financial = app.financialGoals.where((g) => match(g.name)).toList();
    savings.sort((a, b) => listSortId == 'amount'
        ? b.currentAmount.minor.compareTo(a.currentAmount.minor)
        : a.name.compareTo(b.name));
    financial.sort((a, b) => listSortId == 'amount'
        ? b.currentAmount.minor.compareTo(a.currentAmount.minor)
        : a.name.compareTo(b.name));
    return ListView(
      padding: const EdgeInsets.all(FinzeeSpacing.lg),
      children: [
        Text('Goals', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: FinzeeSpacing.md),
        ListControls(
          persistKey: listQueryKey,
          state: listQuery,
          onApplied: applyListQuery,
          defaultSortId: listQueryDefaultSort,
          hint: 'Search goals',
          sorts: const [('name', 'Name'), ('amount', 'Progress')],
        ),
        if (app.enabled(AppFeature.savingsGoals)) ...[
          const SizedBox(height: FinzeeSpacing.md),
          Row(
            children: [
              const Expanded(
                child: Text('Savings goals', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              TextButton.icon(
                onPressed: () => _editSavings(context),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: FinzeeSpacing.sm),
          if (savings.isEmpty)
            Text('No savings goals yet.', style: TextStyle(color: context.finzee.textSecondary))
          else
            ...savings.map((g) => Padding(
                  padding: const EdgeInsets.only(bottom: FinzeeSpacing.sm),
                  child: FinzeeCard(
                    child: InkWell(
                      onTap: () => _editSavings(context, g),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(g.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text('${g.currentAmount.format()} / ${g.targetAmount.format()}'),
                          if (g.targetDate != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                'Target ${g.targetDate!.day}/${g.targetDate!.month}/${g.targetDate!.year}',
                                style: TextStyle(color: context.finzee.textSecondary, fontSize: 12),
                              ),
                            ),
                          if (g.updatedAt != null)
                            Text(
                              'Updated ${formatRecordTimestamp(g.updatedAt)}',
                              style: TextStyle(color: context.finzee.textSecondary, fontSize: 12),
                            ),
                          if (g.completedAt != null)
                            Text(
                              'Completed ${formatRecordTimestamp(g.completedAt)}',
                              style: TextStyle(color: context.finzee.income, fontSize: 12),
                            ),
                          const SizedBox(height: FinzeeSpacing.sm),
                          LinearProgressIndicator(
                            value: g.progress,
                            color: context.finzee.savings,
                            backgroundColor: context.finzee.primarySoft,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
        ],
        if (app.enabled(AppFeature.financialGoals)) ...[
          const SizedBox(height: FinzeeSpacing.lg),
          Row(
            children: [
              const Expanded(
                child: Text('Financial goals', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              TextButton.icon(
                onPressed: () => _editFinancial(context),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: FinzeeSpacing.sm),
          if (financial.isEmpty)
            Text('No financial goals yet.', style: TextStyle(color: context.finzee.textSecondary))
          else
            ...financial.map((g) => Padding(
                  padding: const EdgeInsets.only(bottom: FinzeeSpacing.sm),
                  child: FinzeeCard(
                    padding: EdgeInsets.zero,
                    child: ListTile(
                      title: Text(g.name),
                      subtitle: Text(
                        '${g.currentAmount.format()} / ${g.targetAmount.format()} · ${g.onTrack ? 'On track' : 'Behind'}'
                        '${g.completedAt != null ? ' · Done ${formatRecordTimestamp(g.completedAt)}' : ''}',
                      ),
                      onTap: () => _editFinancial(context, g),
                    ),
                  ),
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
    final monthly = TextEditingController(
      text: existing?.monthlyContribution == null ? '' : '${existing!.monthlyContribution!.major}',
    );
    var targetDate = existing?.targetDate ?? DateTime.now().add(const Duration(days: 365));
    final ok = await showFinzeeDialog<bool>(
      context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (ctx, setSt) => FinzeeFormDialog(
          title: existing == null ? 'New savings goal' : 'Edit savings goal',
          fields: [
            FinzeeFormFields(
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
          ],
          actions: [
            if (existing != null)
              TextButton(
                onPressed: () => confirmEraseFromEditor(
                  pageContext: context,
                  dialogContext: dialogContext,
                  title: 'Delete goal?',
                  erase: () => FinanceScope.of(context).run(() => app.deleteSavingsGoal(existing.id)),
                  failBody: () => FinanceScope.of(context).error,
                ),
                child: const Text('Delete'),
              ),
            TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (ok == true && context.mounted) {
      final ctrl = FinanceScope.of(context);
      await runWithFeedback(
        context,
        ctrl,
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
        successMessage: existing == null ? 'Savings goal added.' : 'Savings goal updated.',
      );
    }
  }

  Future<void> _editFinancial(BuildContext context, [FinancialGoal? existing]) async {
    final app = FinanceScope.of(context).app;
    final name = TextEditingController(text: existing?.name ?? '');
    final target = TextEditingController(text: existing == null ? '' : '${existing.targetAmount.major}');
    final current = TextEditingController(text: existing == null ? '0' : '${existing.currentAmount.major}');
    var deadline = existing?.deadline ?? DateTime.now().add(const Duration(days: 365));
    final ok = await showFinzeeDialog<bool>(
      context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (ctx, setSt) => FinzeeFormDialog(
          title: existing == null ? 'New financial goal' : 'Edit financial goal',
          fields: [
            FinzeeFormFields(
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
          ],
          actions: [
            if (existing != null)
              TextButton(
                onPressed: () => confirmEraseFromEditor(
                  pageContext: context,
                  dialogContext: dialogContext,
                  title: 'Delete financial goal?',
                  erase: () => FinanceScope.of(context).run(() => app.deleteFinancialGoal(existing.id)),
                  failBody: () => FinanceScope.of(context).error,
                ),
                child: const Text('Delete'),
              ),
            TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (ok == true && context.mounted) {
      final ctrl = FinanceScope.of(context);
      await runWithFeedback(
        context,
        ctrl,
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
        successMessage: existing == null ? 'Financial goal added.' : 'Financial goal updated.',
      );
    }
  }
}
