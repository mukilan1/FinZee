import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/money.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/transaction_row.dart';

Future<void> showAddSheet(BuildContext context, TransactionType type) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: FinzeeColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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

  @override
  void dispose() {
    amount.dispose();
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    accountId ??= app.accounts.first.id;
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
            TextField(controller: note, decoration: const InputDecoration(labelText: 'Note')),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                final money = Money.fromMajor(double.parse(amount.text));
                await FinanceScope.of(context).run(
                  () => app.addTransaction(
                    type: type,
                    amount: money,
                    date: DateTime.now(),
                    accountId: accountId!,
                    toAccountId: toAccountId,
                    categoryId: categoryId,
                    note: note.text,
                    goalId: goalId,
                  ),
                );
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
