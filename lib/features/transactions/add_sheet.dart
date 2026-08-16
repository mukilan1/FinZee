import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/money.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/list_controls.dart';
import '../../shared/widgets/transaction_row.dart';

Future<void> showAddSheet(BuildContext context, TransactionType type) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: FinzeeColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: AddTransactionSheet(initialType: type),
    ),
  );
}

class AddTransactionSheet extends StatefulWidget {
  const AddTransactionSheet({super.key, required this.initialType});
  final TransactionType initialType;

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  late TransactionType type = widget.initialType;
  final amount = TextEditingController();
  final note = TextEditingController();
  String? accountId;
  String? toAccountId;
  String? categoryId;
  String? goalId;
  DateTime date = DateTime.now();
  bool _ready = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ready) return;
    final app = FinanceScope.of(context).app;
    if (app.accounts.isNotEmpty) {
      accountId = app.accounts.any((a) => a.id == 'acc_bank')
          ? 'acc_bank'
          : app.accounts.first.id;
    }
    _ready = true;
  }

  @override
  void dispose() {
    amount.dispose();
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    final app = ctrl.app;
    if (app.accounts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Text('Create an account first in More → Accounts.'),
      );
    }
    final expenseCats = app.categories.where((c) => c.kind == CategoryKind.expense).toList();
    final incomeCats = app.categories.where((c) => c.kind == CategoryKind.income).toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add ${type.name}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: TransactionType.values
                  .map(
                    (t) => ChoiceChip(
                      label: Text(t.name),
                      selected: type == t,
                      onSelected: (_) => setState(() => type = t),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            AmountField(controller: amount),
            const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: accountId,
              decoration: const InputDecoration(labelText: 'Account'),
              items: app.accounts
                  .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
                  .toList(),
              onChanged: (v) => setState(() => accountId = v),
            ),
            if (type == TransactionType.transfer) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: toAccountId,
                decoration: const InputDecoration(labelText: 'To account'),
                items: app.accounts
                    .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
                    .toList(),
                onChanged: (v) => setState(() => toAccountId = v),
              ),
            ],
            if (type == TransactionType.expense || type == TransactionType.income) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: categoryId,
                decoration: const InputDecoration(labelText: 'Category'),
                items: (type == TransactionType.expense ? expenseCats : incomeCats)
                    .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
                    .toList(),
                onChanged: (v) => setState(() => categoryId = v),
              ),
            ],
            if (type == TransactionType.saving && app.savingsGoals.isNotEmpty) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: goalId,
                decoration: const InputDecoration(labelText: 'Savings goal'),
                items: app.savingsGoals
                    .map((g) => DropdownMenuItem(value: g.id, child: Text(g.name)))
                    .toList(),
                onChanged: (v) => setState(() => goalId = v),
              ),
            ],
            const SizedBox(height: 12),
            TimelineTile(
              label: 'Date',
              date: date,
              onPick: () async {
                final picked = await pickTimeline(context, initial: date);
                if (picked != null) setState(() => date = picked);
              },
            ),
            const SizedBox(height: 12),
            TextField(controller: note, decoration: const InputDecoration(labelText: 'Note')),
            const SizedBox(height: 16),
            if (ctrl.error != null) ...[
              Text(ctrl.error!, style: const TextStyle(color: FinzeeColors.expense)),
              const SizedBox(height: 8),
            ],
            FilledButton(
              onPressed: () async {
                final ok = await ctrl.run(() async {
                  await app.addTransaction(
                    type: type,
                    amount: Money.parse(amount.text),
                    date: date,
                    accountId: accountId!,
                    toAccountId: toAccountId,
                    categoryId: categoryId,
                    note: note.text,
                    goalId: goalId,
                  );
                });
                if (ok && context.mounted) Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showEditTransaction(BuildContext context, FinanceTransaction tx) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: FinzeeColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: _EditTransactionSheet(tx: tx),
    ),
  );
}

class _EditTransactionSheet extends StatefulWidget {
  const _EditTransactionSheet({required this.tx});
  final FinanceTransaction tx;

  @override
  State<_EditTransactionSheet> createState() => _EditTransactionSheetState();
}

class _EditTransactionSheetState extends State<_EditTransactionSheet> {
  late final amount = TextEditingController(text: '${widget.tx.amount.major}');
  late final note = TextEditingController(text: widget.tx.note ?? '');
  late DateTime date = widget.tx.date;
  late String? categoryId = widget.tx.categoryId;

  @override
  void dispose() {
    amount.dispose();
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    final app = ctrl.app;
    final cats = widget.tx.type == TransactionType.income
        ? app.categories.where((c) => c.kind == CategoryKind.income)
        : app.categories.where((c) => c.kind == CategoryKind.expense);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Edit ${widget.tx.type.name}', style: Theme.of(context).textTheme.titleLarge),
            if (widget.tx.allocationItemId != null)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text('Linked to a plan — only date and note can change.'),
              ),
            const SizedBox(height: 12),
            AmountField(controller: amount),
            TimelineTile(
              label: 'Date',
              date: date,
              onPick: () async {
                final picked = await pickTimeline(context, initial: date);
                if (picked != null) setState(() => date = picked);
              },
            ),
            if (widget.tx.type == TransactionType.expense || widget.tx.type == TransactionType.income)
              DropdownButtonFormField<String>(
                initialValue: categoryId,
                decoration: const InputDecoration(labelText: 'Category'),
                items: cats
                    .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
                    .toList(),
                onChanged: (v) => setState(() => categoryId = v),
              ),
            TextField(controller: note, decoration: const InputDecoration(labelText: 'Note')),
            const SizedBox(height: 16),
            if (widget.tx.allocationItemId == null) ...[
              OutlinedButton(
                onPressed: () async {
                  final success = await confirmAndErase(
                    context,
                    title: 'Delete transaction?',
                    erase: () => ctrl.run(() => app.deleteTransaction(widget.tx.id)),
                    failBody: () => ctrl.error,
                    doneBody: 'This transaction has been erased from FinZee on this device.',
                  );
                  if (success && context.mounted) Navigator.pop(context);
                },
                child: const Text('Delete transaction'),
              ),
              const SizedBox(height: 8),
            ],
            FilledButton(
              onPressed: () async {
                final ok = await ctrl.run(() async {
                  await app.updateTransaction(
                    FinanceTransaction(
                      id: widget.tx.id,
                      type: widget.tx.type,
                      amount: Money.parse(amount.text),
                      date: date,
                      accountId: widget.tx.accountId,
                      toAccountId: widget.tx.toAccountId,
                      categoryId: categoryId,
                      note: note.text,
                      goalId: widget.tx.goalId,
                      investmentId: widget.tx.investmentId,
                      allocationItemId: widget.tx.allocationItemId,
                      createdAt: widget.tx.createdAt,
                    ),
                  );
                });
                if (ok && context.mounted) Navigator.pop(context);
              },
              child: const Text('Save changes'),
            ),
          ],
        ),
      ),
    );
  }
}
