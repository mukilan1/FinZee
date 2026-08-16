import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/list_controls.dart';
import '../../shared/widgets/transaction_row.dart';
import 'add_sheet.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  TransactionType? typeFilter;
  String? accountFilter;
  String query = '';
  String sort = 'date';

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final cats = {for (final c in app.categories) c.id: c.name};
    var items = app.transactions.where((t) {
      if (typeFilter != null && t.type != typeFilter) return false;
      if (accountFilter != null && t.accountId != accountFilter && t.toAccountId != accountFilter) {
        return false;
      }
      if (query.isNotEmpty) {
        final hay = '${t.note ?? ''} ${cats[t.categoryId] ?? ''} ${t.type.name}'.toLowerCase();
        if (!hay.contains(query.toLowerCase())) return false;
      }
      return true;
    }).toList();
    items.sort((a, b) {
      return switch (sort) {
        'amount' => b.amount.minor.compareTo(a.amount.minor),
        'name' => (a.note ?? a.type.name).compareTo(b.note ?? b.type.name),
        _ => b.date.compareTo(a.date),
      };
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Row(
            children: [
              Expanded(child: Text('Transactions', style: Theme.of(context).textTheme.headlineMedium)),
              IconButton(
                onPressed: () => showAddSheet(context, TransactionType.expense),
                tooltip: 'Add transaction',
                icon: const Icon(Icons.add_circle),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ListControls(
            query: query,
            onQuery: (v) => setState(() => query = v),
            hint: 'Search notes, categories, types',
            filters: TransactionType.values.map((t) => t.name).toList(),
            selectedFilter: typeFilter?.name,
            onFilter: (v) => setState(() {
              typeFilter = v == null ? null : TransactionType.values.byName(v);
            }),
            sorts: const [('date', 'Date'), ('amount', 'Amount'), ('name', 'Note')],
            sortId: sort,
            onSort: (v) => setState(() => sort = v),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              ChoiceChip(
                label: const Text('All accounts'),
                selected: accountFilter == null,
                onSelected: (_) => setState(() => accountFilter = null),
              ),
              const SizedBox(width: 8),
              ...app.accounts.map(
                (a) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(a.name),
                    selected: accountFilter == a.id,
                    onSelected: (_) => setState(() => accountFilter = a.id),
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
                      background: Container(
                        color: FinzeeColors.expense,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (_) => confirmDelete(
                        context,
                        title: 'Delete transaction?',
                        body: tx.allocationItemId == null
                            ? 'This cannot be undone.'
                            : 'Allocation-linked transactions cannot be deleted.',
                      ),
                      onDismissed: (_) => FinanceScope.of(context).run(() => app.deleteTransaction(tx.id)),
                      child: InkWell(
                        onTap: () => showEditTransaction(context, tx),
                        child: FinzeeCard(
                          child: TransactionRow(tx: tx, categoryName: cats[tx.categoryId]),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
