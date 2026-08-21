import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/features.dart';
import '../../core/money.dart';
import '../../domain/entities.dart';
import '../../shared/list_query.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/feedback.dart';
import '../../shared/widgets/finzee_ui.dart';
import '../../shared/widgets/list_controls.dart';
import '../../shared/widgets/list_query_host.dart';
import '../../shared/widgets/transaction_row.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});
  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> with PersistentListQuery {
  @override
  String get listQueryKey => ListQueryKeys.plan;

  @override
  String get listQueryDefaultSort => 'name';

  @override
  Widget build(BuildContext context) {
    if (!listQueryReady) {
      return const Center(child: CircularProgressIndicator());
    }
    final ctrl = FinanceScope.of(context);
    final app = ctrl.app;
    if (!app.enabled(AppFeature.salaryPlanning)) {
      return const EmptyState(
        title: 'Salary planning is off',
        subtitle: 'Enable Salary Planning in Settings → Features. Your data stays safe.',
      );
    }
    final statusFilter = listFilter('filter');
    final planned = app.allocations.fold(const Money(0), (p, a) => p + a.plannedAmount);
    final unallocated = (app.plan?.expectedIncome ?? const Money(0)) - planned;
    var items = app.allocations.where((a) {
      if (statusFilter != null && a.status.name != statusFilter) return false;
      if (listQuery.query.isNotEmpty && !a.name.toLowerCase().contains(listQuery.query.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();
    items.sort((a, b) => switch (listSortId) {
          'amount' => b.plannedAmount.minor.compareTo(a.plannedAmount.minor),
          'date' => a.sortOrder.compareTo(b.sortOrder),
          _ => a.name.compareTo(b.name),
        });
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text('Monthly plan', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(app.plan?.periodKey ?? 'No plan generated yet',
            style: TextStyle(color: context.finzee.textSecondary)),
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
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    app.plan?.confirmedAt != null
                        ? 'Confirmed ${formatRecordTimestamp(app.plan!.confirmedAt)}'
                        : 'Confirmed',
                    style: TextStyle(color: context.finzee.income),
                  ),
                ),
              TextButton(
                onPressed: app.plan == null ? null : () => _editExpected(context),
                child: const Text('Edit expected income'),
              ),
              const SizedBox(height: FinzeeSpacing.md),
              Wrap(
                spacing: FinzeeSpacing.sm,
                runSpacing: FinzeeSpacing.sm,
                children: [
                  FilledButton(
                    onPressed: () => runWithFeedback(
                      context,
                      ctrl,
                      app.generateThisMonth,
                      successMessage: 'Monthly plan generated.',
                    ),
                    child: const Text('Generate'),
                  ),
                  OutlinedButton(
                    onPressed: app.plan == null
                        ? null
                        : () => runWithFeedback(
                              context,
                              ctrl,
                              app.confirmThisMonth,
                              successMessage: 'Monthly plan confirmed.',
                            ),
                    child: const Text('Confirm'),
                  ),
                  PopupMenuButton<String>(
                    enabled: app.plan != null || app.salary != null,
                    onSelected: (value) {
                      switch (value) {
                        case 'salary':
                          runWithFeedback(
                            context,
                            ctrl,
                            app.recordSalaryIncome,
                            successMessage: 'Salary recorded as income.',
                          );
                        case 'allocation':
                          _addAllocation(context);
                      }
                    },
                    itemBuilder: (ctx) => [
                      if (app.salary != null)
                        const PopupMenuItem(value: 'salary', child: Text('Record salary as income')),
                      if (app.plan != null)
                        const PopupMenuItem(value: 'allocation', child: Text('Add allocation')),
                    ],
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('More'),
                          SizedBox(width: 4),
                          Icon(Icons.expand_more, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ListControls(
          persistKey: listQueryKey,
          state: listQuery,
          onApplied: applyListQuery,
          defaultSortId: listQueryDefaultSort,
          hint: 'Search allocations',
          filters: AllocationStatus.values.map((s) => s.name).toList(),
          sorts: const [('name', 'Name'), ('amount', 'Amount'), ('date', 'Order')],
        ),
        const SizedBox(height: 12),
        if (items.isEmpty)
          const EmptyState(title: 'No allocations', subtitle: 'Generate a plan or add an allocation.')
        else
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AllocationTile(item: item),
              )),
      ],
    );
  }

  Future<void> _editExpected(BuildContext context) async {
    final app = FinanceScope.of(context).app;
    final amount = TextEditingController(text: '${app.plan!.expectedIncome.major}');
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Expected income'),
        content: AmountField(controller: amount),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await runWithFeedback(
        context,
        FinanceScope.of(context),
        () => app.updatePlan(expectedIncome: Money.parse(amount.text)),
        successMessage: 'Expected income updated.',
      );
    }
  }

  Future<void> _addAllocation(BuildContext context) async {
    final app = FinanceScope.of(context).app;
    final name = TextEditingController();
    final amount = TextEditingController();
    var kind = AllocationKind.expense;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: const Text('Add allocation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
              AmountField(controller: amount, label: 'Planned'),
              DropdownButtonFormField<AllocationKind>(
                initialValue: kind,
                items: AllocationKind.values
                    .map((k) => DropdownMenuItem(value: k, child: Text(k.name)))
                    .toList(),
                onChanged: (v) => setSt(() => kind = v ?? kind),
              ),
            ],
          ),
          actions: [
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Add')),
          ],
        ),
      ),
    );
    if (ok == true && context.mounted) {
      await runWithFeedback(
        context,
        FinanceScope.of(context),
        () => app.addAllocation(
          name: name.text.trim(),
          kind: kind,
          plannedAmount: Money.parse(amount.text),
        ),
        successMessage: 'Allocation added.',
      );
    }
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
          Text('${item.plannedAmount.format()} planned · ${item.kind.name}'),
          if (item.actualAmount != null) Text('${item.actualAmount!.format()} actual'),
          if (item.statusChangedAt != null)
            Text(
              '${item.status.name} ${formatRecordTimestamp(item.statusChangedAt)}',
              style: TextStyle(color: context.finzee.textSecondary, fontSize: 12),
            ),
          if (item.skipNote != null) Text(item.skipNote!, style: TextStyle(color: context.finzee.textSecondary)),
          Wrap(
            spacing: 8,
            children: [
              if (item.status == AllocationStatus.pending || item.status == AllocationStatus.partial)
                TextButton(onPressed: () => _edit(context), child: const Text('Edit')),
              if (item.status == AllocationStatus.pending)
                TextButton(
                  onPressed: () => confirmAndErase(
                    context,
                    title: 'Delete allocation?',
                    erase: () => ctrl.run(() => app.deleteAllocation(item.id)),
                    failBody: () => ctrl.error,
                  ),
                  child: const Text('Delete'),
                ),
            ],
          ),
          if (item.status == AllocationStatus.pending || item.status == AllocationStatus.partial) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () async {
                      if (app.accounts.isEmpty) return;
                      final amount = TextEditingController(text: '${item.plannedAmount.major}');
                      var accountId = app.accounts.any((a) => a.id == 'acc_bank')
                          ? 'acc_bank'
                          : app.accounts.first.id;
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Complete allocation'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AmountField(controller: amount, label: 'Actual amount'),
                              DropdownButtonFormField<String>(
                                initialValue: accountId,
                                decoration: const InputDecoration(labelText: 'From account'),
                                items: app.accounts
                                    .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
                                    .toList(),
                                onChanged: (v) => accountId = v ?? accountId,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
                          ],
                        ),
                      );
                      if (confirmed == true && context.mounted) {
                        await runWithFeedback(
                          context,
                          ctrl,
                          () => app.completeAllocation(item.id, Money.parse(amount.text), accountId),
                          successMessage: 'Allocation completed.',
                        );
                      }
                    },
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
                      if (ok == true && context.mounted) {
                        await runWithFeedback(
                          context,
                          ctrl,
                          () => app.skipAllocation(item.id, reason, note.text),
                          successMessage: 'Allocation skipped.',
                        );
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

  Future<void> _edit(BuildContext context) async {
    final app = FinanceScope.of(context).app;
    final name = TextEditingController(text: item.name);
    final amount = TextEditingController(text: '${item.plannedAmount.major}');
    var kind = item.kind;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: const Text('Edit allocation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
              AmountField(controller: amount, label: 'Planned'),
              DropdownButtonFormField<AllocationKind>(
                initialValue: kind,
                items: AllocationKind.values
                    .map((k) => DropdownMenuItem(value: k, child: Text(k.name)))
                    .toList(),
                onChanged: (v) => setSt(() => kind = v ?? kind),
              ),
            ],
          ),
          actions: [
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (ok == true && context.mounted) {
      await runWithFeedback(
        context,
        FinanceScope.of(context),
        () => app.updateAllocation(
          AllocationItem(
            id: item.id,
            planId: item.planId,
            name: name.text.trim(),
            kind: kind,
            plannedAmount: Money.parse(amount.text),
            actualAmount: item.actualAmount,
            status: item.status,
            categoryId: item.categoryId,
            goalId: item.goalId,
            investmentId: item.investmentId,
            billId: item.billId,
            loanId: item.loanId,
            accountId: item.accountId,
            skipReason: item.skipReason,
            skipNote: item.skipNote,
            sortOrder: item.sortOrder,
          ),
        ),
        successMessage: 'Allocation updated.',
      );
    }
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});
  final AllocationStatus status;

  @override
  Widget build(BuildContext context) {
    final palette = context.finzee;
    final color = switch (status) {
      AllocationStatus.completed => palette.income,
      AllocationStatus.skipped => palette.expense,
      AllocationStatus.partial => palette.warning,
      AllocationStatus.pending => palette.info,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
      child: Text(status.name, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}
