import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/feedback.dart';
import '../../shared/widgets/finzee_ui.dart';
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
    final palette = context.finzee;
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
          child: Text('Transactions', style: Theme.of(context).textTheme.headlineMedium),
        ),
        Padding(
          padding: const EdgeInsets.all(FinzeeSpacing.md),
          child: ListControls(
            query: query,
            onQuery: (v) => setState(() => query = v),
            hint: 'Search notes, categories, types',
            filterGroups: [
              FilterGroup(
                id: 'type',
                label: 'Type',
                options: [
                  (null, 'All types'),
                  ...TransactionType.values.map((t) => (t.name, t.name)),
                ],
              ),
              FilterGroup(
                id: 'account',
                label: 'Account',
                options: [
                  (null, 'All accounts'),
                  ...app.accounts.map((a) => (a.id, a.name)),
                ],
              ),
            ],
            activeFilters: {
              'type': typeFilter?.name,
              'account': accountFilter,
            },
            onFiltersChanged: (filters) => setState(() {
              final type = filters['type'];
              if (type == null) {
                typeFilter = null;
              } else {
                for (final t in TransactionType.values) {
                  if (t.name == type) {
                    typeFilter = t;
                    break;
                  }
                }
              }
              accountFilter = filters['account'];
            }),
            sorts: const [('date', 'Date'), ('amount', 'Amount'), ('name', 'Note')],
            sortId: sort,
            onSort: (v) => setState(() => sort = v),
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const EmptyState(title: 'Nothing here', subtitle: 'Try another filter or add a transaction.')
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: FinzeeSpacing.md),
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    final tx = items[i];
                    return Dismissible(
                      key: ValueKey(tx.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: palette.expense,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: FinzeeSpacing.md),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (_) async {
                        final linked = tx.allocationItemId != null;
                        final ok = await confirmDelete(
                          context,
                          title: 'Delete transaction?',
                          body: linked
                              ? 'Allocation-linked transactions cannot be deleted.'
                              : 'This cannot be undone. The record is removed from this device only.',
                        );
                        if (!ok || !context.mounted) return false;
                        final success = await FinanceScope.of(context).run(
                          () => app.deleteTransaction(tx.id),
                        );
                        if (context.mounted) {
                          if (success) {
                            showFinzeeSnackBar(
                              context,
                              'Transaction deleted from this device.',
                            );
                          } else {
                            showFinzeeSnackBar(
                              context,
                              FinanceScope.of(context).error ?? 'Transaction was not deleted.',
                              error: true,
                            );
                          }
                        }
                        return success;
                      },
                      onDismissed: (_) {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: FinzeeSpacing.sm),
                        child: InkWell(
                          onTap: () => showEditTransaction(context, tx),
                          child: FinzeeCard(
                            child: TransactionRow(tx: tx, categoryName: cats[tx.categoryId]),
                          ),
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
