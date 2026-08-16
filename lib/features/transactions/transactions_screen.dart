import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/transaction_row.dart';
import 'add_sheet.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  TransactionType? filter;
  String query = '';

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final cats = {for (final c in app.categories) c.id: c.name};
    final items = app.transactions.where((t) {
      if (filter != null && t.type != filter) return false;
      if (query.isNotEmpty &&
          !(t.note ?? '').toLowerCase().contains(query.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Row(
              children: [
                Expanded(child: Text('Transactions', style: Theme.of(context).textTheme.headlineMedium)),
                IconButton(
                  onPressed: () => showAddSheet(context, TransactionType.expense),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search notes'),
              onChanged: (v) => setState(() => query = v),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ChoiceChip(label: const Text('All'), selected: filter == null, onSelected: (_) => setState(() => filter = null)),
                const SizedBox(width: 8),
                ...TransactionType.values.map(
                  (t) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(t.name),
                      selected: filter == t,
                      onSelected: (_) => setState(() => filter = t),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const EmptyState(title: 'Nothing here', subtitle: 'Try another filter or add a transaction.')
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final tx = items[i];
                      return Dismissible(
                        key: ValueKey(tx.id),
                        background: Container(color: FinzeeColors.expense, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 16), child: const Icon(Icons.delete, color: Colors.white)),
                        confirmDismiss: (_) async {
                          final ok = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Delete transaction?'),
                              content: const Text('This cannot be undone.'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                                FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
                              ],
                            ),
                          );
                          return ok ?? false;
                        },
                        onDismissed: (_) => FinanceScope.of(context).run(() => app.deleteTransaction(tx.id)),
                        child: FinzeeCard(
                          child: TransactionRow(tx: tx, categoryName: cats[tx.categoryId]),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
