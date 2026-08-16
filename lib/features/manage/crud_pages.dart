import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/features.dart';
import '../../core/ids.dart';
import '../../core/money.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/feedback.dart';
import '../../shared/widgets/list_controls.dart';
import '../../shared/widgets/transaction_row.dart';

int _cmp(String sort, String a, String b, num na, num nb, DateTime da, DateTime db) {
  return switch (sort) {
    'name' => a.toLowerCase().compareTo(b.toLowerCase()),
    'amount' => nb.compareTo(na),
    'date' => db.compareTo(da),
    _ => a.toLowerCase().compareTo(b.toLowerCase()),
  };
}

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});
  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  String query = '';
  String? typeFilter;
  String sort = 'name';

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final balances = app.calc.accountBalances(app.accounts, app.transactions);
    var rows = balances.where((b) {
      final q = query.toLowerCase();
      if (q.isNotEmpty && !b.account.name.toLowerCase().contains(q)) return false;
      if (typeFilter != null && b.account.type.name != typeFilter) return false;
      return true;
    }).toList();
    rows.sort((a, b) => _cmp(sort, a.account.name, b.account.name, a.balance.minor, b.balance.minor, a.account.createdAt, b.account.createdAt));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: addAppBarAction(() => _editAccount(context), 'Add account'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add account',
        onPressed: () => _editAccount(context),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AddCta(label: 'Add account', onPressed: () => _editAccount(context)),
          ListControls(
            query: query,
            onQuery: (v) => setState(() => query = v),
            hint: 'Search accounts',
            filters: AccountType.values.map((t) => t.name).toList(),
            selectedFilter: typeFilter,
            onFilter: (v) => setState(() => typeFilter = v),
            sorts: const [('name', 'Name'), ('amount', 'Balance'), ('date', 'Created')],
            sortId: sort,
            onSort: (v) => setState(() => sort = v),
          ),
          const SizedBox(height: 12),
          ...rows.map(
            (b) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FinzeeCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(b.account.name),
                  subtitle: Text('${b.account.type.name} · opened ${b.account.createdAt.day}/${b.account.createdAt.month}/${b.account.createdAt.year}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(b.balance.format(), style: const TextStyle(fontWeight: FontWeight.w700)),
                      const Icon(Icons.edit_outlined, size: 18),
                    ],
                  ),
                  onTap: () => _editAccount(context, b.account),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _editAccount(BuildContext context, [Account? existing]) async {
    final app = FinanceScope.of(context).app;
    final name = TextEditingController(text: existing?.name ?? '');
    final opening = TextEditingController(text: existing == null ? '0' : '${existing.openingBalance.major}');
    final notes = TextEditingController(text: existing?.notes ?? '');
    var type = existing?.type ?? AccountType.bank;
    var created = existing?.createdAt ?? DateTime.now();
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: Text(existing == null ? 'New account' : 'Edit account'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
                DropdownButtonFormField<AccountType>(
                  initialValue: type,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: AccountType.values
                      .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
                      .toList(),
                  onChanged: (v) => setSt(() => type = v ?? type),
                ),
                AmountField(controller: opening, label: 'Opening balance'),
                TextField(controller: notes, decoration: const InputDecoration(labelText: 'Notes')),
                TimelineTile(
                  label: 'Opened on',
                  date: created,
                  onPick: () async {
                    final d = await pickTimeline(ctx, initial: created);
                    if (d != null) setSt(() => created = d);
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
                  title: 'Delete account?',
                  erase: () => FinanceScope.of(context).run(() => app.deleteAccount(existing.id)),
                  failBody: () => FinanceScope.of(context).error,
                ),
                child: const Text('Delete'),
              ),
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (saved == true && context.mounted) {
      final ctrl = FinanceScope.of(context);
      await runWithFeedback(
        context,
        ctrl,
        () => app.upsertAccount(
          Account(
            id: existing?.id ?? newId(),
            name: name.text.trim(),
            type: type,
            openingBalance: Money(
              ((double.tryParse(opening.text.replaceAll(',', '')) ?? 0) * 100).round(),
            ),
            notes: notes.text,
            createdAt: created,
          ),
        ),
        successMessage: existing == null ? 'Account added.' : 'Account updated.',
      );
    }
  }
}

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  String query = '';
  String? kindFilter;
  String sort = 'name';

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    var rows = app.categories.where((c) {
      if (query.isNotEmpty && !c.name.toLowerCase().contains(query.toLowerCase())) return false;
      if (kindFilter != null && c.kind.name != kindFilter) return false;
      return true;
    }).toList();
    rows.sort((a, b) => _cmp(sort, a.name, b.name, a.sortOrder, b.sortOrder, DateTime(2000), DateTime(2000)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: addAppBarAction(() => _edit(context), 'Add category'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add category',
        onPressed: () => _edit(context),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AddCta(label: 'Add category', onPressed: () => _edit(context)),
          ListControls(
            query: query,
            onQuery: (v) => setState(() => query = v),
            hint: 'Search categories',
            filters: CategoryKind.values.map((k) => k.name).toList(),
            selectedFilter: kindFilter,
            onFilter: (v) => setState(() => kindFilter = v),
            sorts: const [('name', 'Name'), ('amount', 'Order')],
            sortId: sort,
            onSort: (v) => setState(() => sort = v),
          ),
          const SizedBox(height: 12),
          ...rows.map(
            (c) => ListTile(
              title: Text(c.name),
              subtitle: Text(c.kind.name),
              trailing: const Icon(Icons.edit_outlined, size: 18),
              onTap: () => _edit(context, c),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _edit(BuildContext context, [Category? existing]) async {
    final app = FinanceScope.of(context).app;
    final name = TextEditingController(text: existing?.name ?? '');
    var kind = existing?.kind ?? CategoryKind.expense;
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: Text(existing == null ? 'New category' : 'Edit category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
              DropdownButtonFormField<CategoryKind>(
                initialValue: kind,
                items: CategoryKind.values
                    .map((k) => DropdownMenuItem(value: k, child: Text(k.name)))
                    .toList(),
                onChanged: (v) => setSt(() => kind = v ?? kind),
              ),
            ],
          ),
          actions: [
            if (existing != null)
              TextButton(
                onPressed: () => confirmEraseFromEditor(
                  pageContext: context,
                  dialogContext: ctx,
                  title: 'Delete category?',
                  erase: () => FinanceScope.of(context).run(() => app.deleteCategory(existing.id)),
                  failBody: () => FinanceScope.of(context).error,
                ),
                child: const Text('Delete'),
              ),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (saved == true && name.text.trim().isNotEmpty && context.mounted) {
      final ctrl = FinanceScope.of(context);
      await runWithFeedback(
        context,
        ctrl,
        () => app.upsertCategory(
          Category(
            id: existing?.id ?? newId(),
            name: name.text.trim(),
            kind: kind,
            sortOrder: existing?.sortOrder ?? app.categories.length,
          ),
        ),
        successMessage: existing == null ? 'Category added.' : 'Category updated.',
      );
    }
  }
}

class InvestmentsPage extends StatefulWidget {
  const InvestmentsPage({super.key});
  @override
  State<InvestmentsPage> createState() => _InvestmentsPageState();
}

class _InvestmentsPageState extends State<InvestmentsPage> {
  String query = '';
  String? typeFilter;
  String sort = 'date';

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    if (!app.enabled(AppFeature.investments)) {
      return Scaffold(
        appBar: AppBar(title: const Text('Investments')),
        body: const Center(child: Text('Investments are disabled. Records are kept.')),
      );
    }
    final types = app.investments.map((i) => i.type).toSet().toList();
    var rows = app.investments.where((i) {
      if (query.isNotEmpty && !i.name.toLowerCase().contains(query.toLowerCase())) return false;
      if (typeFilter != null && i.type != typeFilter) return false;
      return true;
    }).toList();
    rows.sort((a, b) => _cmp(sort, a.name, b.name, a.marketValue.minor, b.marketValue.minor, a.date, b.date));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investments'),
        actions: addAppBarAction(() => _edit(context), 'Add investment'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add investment',
        onPressed: () => _edit(context),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AddCta(label: 'Add investment', onPressed: () => _edit(context)),
          ListControls(
            query: query,
            onQuery: (v) => setState(() => query = v),
            hint: 'Search investments',
            filters: types,
            selectedFilter: typeFilter,
            onFilter: (v) => setState(() => typeFilter = v),
            sorts: const [('name', 'Name'), ('amount', 'Value'), ('date', 'Date')],
            sortId: sort,
            onSort: (v) => setState(() => sort = v),
          ),
          const SizedBox(height: 12),
          ...rows.map(
            (i) => ListTile(
              title: Text(i.name),
              subtitle: Text('${i.type} · ${i.date.day}/${i.date.month}/${i.date.year}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(i.marketValue.format()),
                  const Icon(Icons.edit_outlined, size: 18),
                ],
              ),
              onTap: () => _edit(context, i),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _edit(BuildContext context, [Investment? existing]) async {
    final app = FinanceScope.of(context).app;
    final name = TextEditingController(text: existing?.name ?? '');
    final type = TextEditingController(text: existing?.type ?? 'mutual_funds');
    final amount = TextEditingController(text: existing == null ? '' : '${existing.amount.major}');
    final value = TextEditingController(text: existing == null ? '' : '${(existing.currentValue ?? existing.amount).major}');
    final notes = TextEditingController(text: existing?.notes ?? '');
    var date = existing?.date ?? DateTime.now();
    String? accountId = existing?.accountId ?? (app.accounts.isEmpty ? null : app.accounts.first.id);
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: Text(existing == null ? 'Add investment' : 'Edit investment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
                TextField(controller: type, decoration: const InputDecoration(labelText: 'Type')),
                AmountField(controller: amount, label: 'Invested'),
                AmountField(controller: value, label: 'Current value'),
                TextField(controller: notes, decoration: const InputDecoration(labelText: 'Notes')),
                TimelineTile(
                  label: 'Invested on',
                  date: date,
                  onPick: () async {
                    final d = await pickTimeline(ctx, initial: date);
                    if (d != null) setSt(() => date = d);
                  },
                ),
                if (app.accounts.isNotEmpty)
                  DropdownButtonFormField<String>(
                    initialValue: accountId,
                    decoration: const InputDecoration(labelText: 'Account'),
                    items: app.accounts
                        .map((a) => DropdownMenuItem(value: a.id, child: Text(a.name)))
                        .toList(),
                    onChanged: (v) => setSt(() => accountId = v),
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
                  title: 'Delete investment?',
                  erase: () => FinanceScope.of(context).run(() => app.deleteInvestment(existing.id)),
                  failBody: () => FinanceScope.of(context).error,
                ),
                child: const Text('Delete'),
              ),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (saved == true && context.mounted) {
      final ctrl = FinanceScope.of(context);
      await runWithFeedback(
        context,
        ctrl,
        () => app.upsertInvestment(
          Investment(
            id: existing?.id ?? newId(),
            name: name.text.trim(),
            type: type.text.trim().isEmpty ? 'custom' : type.text.trim(),
            amount: Money.parse(amount.text),
            date: date,
            accountId: accountId,
            currentValue: Money.parse(value.text),
            notes: notes.text,
          ),
        ),
        successMessage: existing == null ? 'Investment added.' : 'Investment updated.',
      );
    }
  }
}

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});
  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  String query = '';
  String sort = 'name';

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    if (!app.enabled(AppFeature.bills)) {
      return Scaffold(appBar: AppBar(title: const Text('Bills')), body: const Center(child: Text('Bills are disabled.')));
    }
    var rows = app.bills.where((b) => query.isEmpty || b.name.toLowerCase().contains(query.toLowerCase())).toList();
    rows.sort((a, b) => _cmp(sort, a.name, b.name, a.amount.minor, b.amount.minor, DateTime(2000, 1, a.dueDay), DateTime(2000, 1, b.dueDay)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bills'),
        actions: addAppBarAction(() => _edit(context), 'Add bill'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add bill',
        onPressed: () => _edit(context),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AddCta(label: 'Add bill', onPressed: () => _edit(context)),
          ListControls(
            query: query,
            onQuery: (v) => setState(() => query = v),
            sorts: const [('name', 'Name'), ('amount', 'Amount'), ('date', 'Due day')],
            sortId: sort,
            onSort: (v) => setState(() => sort = v),
          ),
          ...rows.map((b) => ListTile(
                title: Text(b.name),
                subtitle: Text('Due day ${b.dueDay}'),
                trailing: Text(b.amount.format()),
                onTap: () => _edit(context, b),
              )),
        ],
      ),
    );
  }

  Future<void> _edit(BuildContext context, [RecurringBill? existing]) async {
    final app = FinanceScope.of(context).app;
    final name = TextEditingController(text: existing?.name ?? '');
    final amount = TextEditingController(text: existing == null ? '' : '${existing.amount.major}');
    final due = TextEditingController(text: '${existing?.dueDay ?? 5}');
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existing == null ? 'Add bill' : 'Edit bill'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
            AmountField(controller: amount),
            TextField(controller: due, decoration: const InputDecoration(labelText: 'Due day (1-28)')),
          ],
        ),
        actions: [
          if (existing != null)
            TextButton(
              onPressed: () => confirmEraseFromEditor(
                pageContext: context,
                dialogContext: ctx,
                title: 'Delete bill?',
                erase: () => FinanceScope.of(context).run(() => app.deleteBill(existing.id)),
                failBody: () => FinanceScope.of(context).error,
              ),
              child: const Text('Delete'),
            ),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
        ],
      ),
    );
    if (saved == true && context.mounted) {
      final ctrl = FinanceScope.of(context);
      await runWithFeedback(
        context,
        ctrl,
        () => app.upsertBill(
          RecurringBill(
            id: existing?.id ?? newId(),
            name: name.text.trim(),
            amount: Money.parse(amount.text),
            dueDay: int.parse(due.text),
            categoryId: existing?.categoryId ?? 'exp_bills',
            accountId: existing?.accountId,
          ),
        ),
        successMessage: existing == null ? 'Bill added.' : 'Bill updated.',
      );
    }
  }
}

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});
  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  String query = '';
  String sort = 'name';

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    if (!app.enabled(AppFeature.loans)) {
      return Scaffold(appBar: AppBar(title: const Text('Loans')), body: const Center(child: Text('Loans are disabled.')));
    }
    var rows = app.loans.where((l) => query.isEmpty || l.name.toLowerCase().contains(query.toLowerCase())).toList();
    rows.sort((a, b) => _cmp(sort, a.name, b.name, a.remaining.minor, b.remaining.minor, a.startDate, b.startDate));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loans'),
        actions: addAppBarAction(() => _edit(context), 'Add loan'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add loan',
        onPressed: () => _edit(context),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AddCta(label: 'Add loan', onPressed: () => _edit(context)),
          ListControls(
            query: query,
            onQuery: (v) => setState(() => query = v),
            sorts: const [('name', 'Name'), ('amount', 'Remaining'), ('date', 'Start')],
            sortId: sort,
            onSort: (v) => setState(() => sort = v),
          ),
          ...rows.map((l) => ListTile(
                title: Text(l.name),
                subtitle: Text('EMI ${l.emi.format()} · ${l.startDate.day}/${l.startDate.month}/${l.startDate.year} – ${l.endDate.day}/${l.endDate.month}/${l.endDate.year}'),
                trailing: Text(l.remaining.format()),
                onTap: () => _edit(context, l),
              )),
        ],
      ),
    );
  }

  Future<void> _edit(BuildContext context, [Loan? existing]) async {
    final app = FinanceScope.of(context).app;
    final name = TextEditingController(text: existing?.name ?? '');
    final principal = TextEditingController(text: existing == null ? '' : '${existing.principal.major}');
    final emi = TextEditingController(text: existing == null ? '' : '${existing.emi.major}');
    final remaining = TextEditingController(text: existing == null ? '' : '${existing.remaining.major}');
    final rate = TextEditingController(text: '${existing?.interestRate ?? 8}');
    var start = existing?.startDate ?? DateTime.now();
    var end = existing?.endDate ?? DateTime.now().add(const Duration(days: 365 * 5));
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: Text(existing == null ? 'Add loan' : 'Edit loan'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
                AmountField(controller: principal, label: 'Principal'),
                AmountField(controller: emi, label: 'EMI'),
                AmountField(controller: remaining, label: 'Remaining'),
                TextField(controller: rate, decoration: const InputDecoration(labelText: 'Interest %')),
                TimelineTile(
                  label: 'Start',
                  date: start,
                  onPick: () async {
                    final d = await pickTimeline(ctx, initial: start);
                    if (d != null) setSt(() => start = d);
                  },
                ),
                TimelineTile(
                  label: 'End',
                  date: end,
                  onPick: () async {
                    final d = await pickTimeline(ctx, initial: end);
                    if (d != null) setSt(() => end = d);
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
                  title: 'Delete loan?',
                  erase: () => FinanceScope.of(context).run(() => app.deleteLoan(existing.id)),
                  failBody: () => FinanceScope.of(context).error,
                ),
                child: const Text('Delete'),
              ),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (saved == true && context.mounted) {
      final p = Money.parse(principal.text);
      final ctrl = FinanceScope.of(context);
      await runWithFeedback(
        context,
        ctrl,
        () => app.upsertLoan(
          Loan(
            id: existing?.id ?? newId(),
            name: name.text.trim(),
            principal: p,
            interestRate: double.tryParse(rate.text) ?? 0,
            emi: Money.parse(emi.text),
            startDate: start,
            endDate: end,
            remaining: remaining.text.isEmpty ? p : Money.parse(remaining.text),
          ),
        ),
        successMessage: existing == null ? 'Loan added.' : 'Loan updated.',
      );
    }
  }
}

class BudgetsPage extends StatefulWidget {
  const BudgetsPage({super.key});
  @override
  State<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> {
  late DateTime month = DateTime.now();
  String query = '';

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final usage = app.calc.budgetUsage(
      app.budgets,
      app.transactions.where((t) => t.date.year == month.year && t.date.month == month.month).toList(),
    );
    final rows = usage.where((u) {
      final name = app.categories.where((c) => c.id == u.budget.categoryId);
      final label = name.isEmpty ? '' : name.first.name;
      return query.isEmpty || label.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budgets'),
        actions: addAppBarAction(() => _edit(context), 'Add budget'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add budget',
        onPressed: () => _edit(context),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AddCta(label: 'Add budget', onPressed: () => _edit(context)),
          TimelineTile(
            label: 'Budget month',
            date: DateTime(month.year, month.month, 1),
            onPick: () async {
              final d = await pickTimeline(context, initial: month);
              if (d != null) setState(() => month = d);
            },
          ),
          ListControls(query: query, onQuery: (v) => setState(() => query = v), hint: 'Search budgets'),
          ...rows.map((u) {
            final name = app.categories.where((c) => c.id == u.budget.categoryId);
            final label = name.isEmpty ? 'Category' : name.first.name;
            return FinzeeCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(label),
                subtitle: Text('${u.spent.format()} / ${u.budget.amount.format()}'),
                onTap: () => _edit(context, u.budget),
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _edit(BuildContext context, [Budget? existing]) async {
    final app = FinanceScope.of(context).app;
    final cats = app.categories.where((c) => c.kind == CategoryKind.expense).toList();
    if (cats.isEmpty) return;
    String catId = existing?.categoryId ?? cats.first.id;
    final amount = TextEditingController(text: existing == null ? '8000' : '${existing.amount.major}');
    var period = existing == null ? month : DateTime(existing.year, existing.month, 1);
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: Text(existing == null ? 'New budget' : 'Edit budget'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: catId,
                items: cats.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                onChanged: (v) => setSt(() => catId = v ?? catId),
              ),
              AmountField(controller: amount),
              TimelineTile(
                label: 'Month',
                date: period,
                onPick: () async {
                  final d = await pickTimeline(ctx, initial: period);
                  if (d != null) setSt(() => period = d);
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
                  title: 'Delete budget?',
                  erase: () => FinanceScope.of(context).run(() => app.deleteBudget(existing.id)),
                  failBody: () => FinanceScope.of(context).error,
                ),
                child: const Text('Delete'),
              ),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (saved == true && context.mounted) {
      final ctrl = FinanceScope.of(context);
      await runWithFeedback(
        context,
        ctrl,
        () => app.upsertBudget(
          Budget(
            id: existing?.id ?? newId(),
            categoryId: catId,
            amount: Money.parse(amount.text),
            year: period.year,
            month: period.month,
          ),
        ),
        successMessage: existing == null ? 'Budget added.' : 'Budget updated.',
      );
    }
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  String query = '';
  String sort = 'date';

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    var rows = app.notes.where((n) => query.isEmpty || n.body.toLowerCase().contains(query.toLowerCase())).toList();
    rows.sort((a, b) => _cmp(sort, a.body, b.body, a.body.length, b.body.length, a.createdAt, b.createdAt));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: addAppBarAction(() => _edit(context), 'Add note'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add note',
        onPressed: () => _edit(context),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AddCta(label: 'Add note', onPressed: () => _edit(context)),
          ListControls(
            query: query,
            onQuery: (v) => setState(() => query = v),
            sorts: const [('date', 'Date'), ('name', 'Text')],
            sortId: sort,
            onSort: (v) => setState(() => sort = v),
          ),
          ...rows.map((n) => ListTile(
                title: Text(n.body),
                subtitle: Text('${n.createdAt.day}/${n.createdAt.month}/${n.createdAt.year}'),
                onTap: () => _edit(context, n),
              )),
        ],
      ),
    );
  }

  Future<void> _edit(BuildContext context, [FinanceNote? existing]) async {
    final app = FinanceScope.of(context).app;
    final body = TextEditingController(text: existing?.body ?? '');
    var created = existing?.createdAt ?? DateTime.now();
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSt) => AlertDialog(
          title: Text(existing == null ? 'Note' : 'Edit note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: body, maxLines: 4),
              TimelineTile(
                label: 'Date',
                date: created,
                onPick: () async {
                  final d = await pickTimeline(ctx, initial: created);
                  if (d != null) setSt(() => created = d);
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
                  title: 'Delete note?',
                  erase: () => FinanceScope.of(context).run(() => app.deleteNote(existing.id)),
                  failBody: () => FinanceScope.of(context).error,
                ),
                child: const Text('Delete'),
              ),
            FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Save')),
          ],
        ),
      ),
    );
    if (saved == true && context.mounted) {
      final ctrl = FinanceScope.of(context);
      if (existing == null) {
        await runWithFeedback(
          context,
          ctrl,
          () => app.addNote(body.text),
          successMessage: 'Note added.',
        );
      } else {
        await runWithFeedback(
          context,
          ctrl,
          () => app.updateNote(
            FinanceNote(
              id: existing.id,
              body: body.text,
              createdAt: created,
              monthKey: existing.monthKey,
              goalId: existing.goalId,
            ),
          ),
          successMessage: 'Note updated.',
        );
      }
    }
  }
}

class DangerZonePage extends StatelessWidget {
  const DangerZonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Delete all data')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Wipe every local record and start from empty default accounts. This needs two confirmations, typing DELETE, and your device screen lock if app lock is enabled.',
            ),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: FinzeeColors.expense),
              onPressed: () async {
                final draft = await collectWipeDraft(
                  context,
                  authRequired: ctrl.app.lockEnabled,
                  authenticate: ctrl.app.authenticateSensitiveAction,
                );
                if (draft == null || !context.mounted) return;
                final ok = await ctrl.run(
                  () => ctrl.app.wipeAllData(
                    typedPhrase: draft.phrase,
                    deviceAuthenticated: ctrl.app.lockEnabled,
                  ),
                );
                if (!context.mounted) return;
                if (ok) {
                  showFinzeeSnackBar(
                    context,
                    'All application data erased. Empty defaults were restored.',
                  );
                } else {
                  showFinzeeSnackBar(
                    context,
                    ctrl.error ?? 'Nothing was deleted.',
                    error: true,
                  );
                }
              },
              child: const Text('Delete entire application data'),
            ),
          ],
        ),
      ),
    );
  }
}
