import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/features.dart';
import '../../core/ids.dart';
import '../../core/money.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/transaction_row.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('More', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          _tile(context, Icons.account_balance_wallet_outlined, 'Accounts', const AccountsPage()),
          _tile(context, Icons.category_outlined, 'Categories', const CategoriesPage()),
          _tile(context, Icons.payments_outlined, 'Salary & income', const SalaryPage()),
          _tile(context, Icons.pie_chart_outline, 'Budgets', const BudgetsPage()),
          _tile(context, Icons.show_chart, 'Investments', const InvestmentsPage()),
          _tile(context, Icons.receipt_long_outlined, 'Bills', const BillsPage()),
          _tile(context, Icons.account_balance_outlined, 'Loans', const LoansPage()),
          _tile(context, Icons.insights_outlined, 'Reports', const ReportsPage()),
          _tile(context, Icons.notes_outlined, 'Notes', const NotesPage()),
          _tile(context, Icons.toggle_on_outlined, 'Features', const FeaturesPage()),
          _tile(context, Icons.backup_outlined, 'Backup & restore', const BackupPage()),
          _tile(context, Icons.lock_outline, 'Security', const SecurityPage()),
          _tile(context, Icons.info_outline, 'About', const AboutPage()),
        ],
      ),
    );
  }

  Widget _tile(BuildContext context, IconData icon, String title, Widget page) {
    return FinzeeCard(
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(icon, color: FinzeeColors.primaryDark),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }
}

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final balances = app.calc.accountBalances(app.accounts, app.transactions);
    return Scaffold(
      appBar: AppBar(title: const Text('Accounts')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final name = TextEditingController();
          await showDialog<void>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('New account'),
              content: TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                FilledButton(
                  onPressed: () async {
                    await FinanceScope.of(context).run(() => app.upsertAccount(
                          Account(
                            id: newId(),
                            name: name.text,
                            type: AccountType.bank,
                            openingBalance: const Money(0),
                            createdAt: DateTime.now(),
                          ),
                        ));
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: balances
            .map((b) => FinzeeCard(
                  child: ListTile(
                    title: Text(b.account.name),
                    subtitle: Text(b.account.type.name),
                    trailing: Text(b.balance.format(), style: const TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final name = TextEditingController();
          var kind = CategoryKind.expense;
          await showDialog<void>(
            context: context,
            builder: (ctx) => StatefulBuilder(
              builder: (ctx, setSt) => AlertDialog(
                title: const Text('New category'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
                    DropdownButton<CategoryKind>(
                      value: kind,
                      items: CategoryKind.values
                          .map((k) => DropdownMenuItem(value: k, child: Text(k.name)))
                          .toList(),
                      onChanged: (v) => setSt(() => kind = v!),
                    ),
                  ],
                ),
                actions: [
                  FilledButton(
                    onPressed: () async {
                      if (name.text.trim().isEmpty) return;
                      await FinanceScope.of(context).run(
                        () => app.upsertCategory(
                          Category(
                            id: newId(),
                            name: name.text.trim(),
                            kind: kind,
                            sortOrder: app.categories.length,
                          ),
                        ),
                      );
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: app.categories
            .map((c) => ListTile(title: Text(c.name), subtitle: Text(c.kind.name)))
            .toList(),
      ),
    );
  }
}

class SalaryPage extends StatelessWidget {
  const SalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final amount = TextEditingController(text: app.salary == null ? '' : '${app.salary!.baseAmount.major}');
    final day = TextEditingController(text: '${app.salary?.payDay ?? 1}');
    return Scaffold(
      appBar: AppBar(title: const Text('Salary & income')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (!app.enabled(AppFeature.salaryPlanning))
            const Text('Enable Salary Planning in Features to edit this module.'),
          AmountField(controller: amount, label: 'Base salary'),
          const SizedBox(height: 12),
          TextField(controller: day, decoration: const InputDecoration(labelText: 'Pay day (1-31)')),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: !app.enabled(AppFeature.salaryPlanning)
                ? null
                : () => FinanceScope.of(context).run(
                      () => app.saveSalary(
                        SalaryProfile(
                          id: app.salary?.id ?? newId(),
                          baseAmount: Money.parse(amount.text),
                          payDay: int.parse(day.text),
                          effectiveFrom: DateTime.now(),
                        ),
                      ),
                    ),
            child: const Text('Save salary'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: !app.enabled(AppFeature.salaryPlanning) || app.salary == null
                ? null
                : () => FinanceScope.of(context).run(app.recordSalaryIncome),
            child: const Text('Record this month\'s salary as income'),
          ),
          const SizedBox(height: 24),
          const Text('Salary history', style: TextStyle(fontWeight: FontWeight.w600)),
          ...app.salaryHistory.map(
            (h) => ListTile(
              title: Text('${h.previousAmount.format()} → ${h.newAmount.format()}'),
              subtitle: Text('${h.reason ?? ''} · ${h.percentChange.toStringAsFixed(1)}%'),
            ),
          ),
        ],
      ),
    );
  }
}

class BudgetsPage extends StatelessWidget {
  const BudgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final now = DateTime.now();
    final usage = app.calc.budgetUsage(app.budgets, app.transactions.where((t) => t.date.year == now.year && t.date.month == now.month).toList());
    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cats = app.categories.where((c) => c.kind == CategoryKind.expense).toList();
          if (cats.isEmpty) return;
          String catId = cats.first.id;
          final amount = TextEditingController(text: '8000');
          await showDialog<void>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Budget'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: catId,
                    isExpanded: true,
                    items: cats.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
                    onChanged: (v) => catId = v!,
                  ),
                  TextField(controller: amount, decoration: const InputDecoration(prefixText: '₹ ')),
                ],
              ),
              actions: [
                FilledButton(
                  onPressed: () async {
                    await FinanceScope.of(context).run(() => app.upsertBudget(
                          Budget(
                            id: newId(),
                            categoryId: catId,
                            amount: Money.parse(amount.text),
                            year: now.year,
                            month: now.month,
                          ),
                        ));
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: usage.isEmpty
          ? const Center(child: Text('No budgets this month.'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: usage
                  .map((u) {
                    final name = app.categories.where((c) => c.id == u.budget.categoryId).firstOrNull?.name ?? 'Category';
                    return FinzeeCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text('${u.spent.format()} / ${u.budget.amount.format()}'),
                          LinearProgressIndicator(value: u.ratio.clamp(0, 1), color: u.warningLevel >= 90 ? FinzeeColors.expense : FinzeeColors.primary),
                          Text('Remaining ${u.remaining.format()}', style: const TextStyle(color: FinzeeColors.textSecondary)),
                        ],
                      ),
                    );
                  })
                  .toList(),
            ),
    );
  }
}

class InvestmentsPage extends StatelessWidget {
  const InvestmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    return Scaffold(
      appBar: AppBar(title: const Text('Investments')),
      floatingActionButton: app.enabled(AppFeature.investments)
          ? FloatingActionButton(
              onPressed: () async {
                final name = TextEditingController();
                final amount = TextEditingController();
                await showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Add investment'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
                        TextField(controller: amount, decoration: const InputDecoration(labelText: 'Amount', prefixText: '₹ ')),
                      ],
                    ),
                    actions: [
                      FilledButton(
                        onPressed: () async {
                          await FinanceScope.of(context).run(() => app.upsertInvestment(
                                Investment(
                                  id: newId(),
                                  name: name.text,
                                  type: 'custom',
                                  amount: Money.parse(amount.text),
                                  date: DateTime.now(),
                                  currentValue: Money.parse(amount.text),
                                ),
                              ));
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: !app.enabled(AppFeature.investments)
          ? const Center(child: Text('Investments are disabled. Records are kept.'))
          : app.investments.isEmpty
              ? const Center(child: Text('No investments yet.'))
              : ListView(
                  children: app.investments
                      .map((i) => ListTile(title: Text(i.name), subtitle: Text(i.type), trailing: Text(i.marketValue.format())))
                      .toList(),
                ),
    );
  }
}

class BillsPage extends StatelessWidget {
  const BillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    return Scaffold(
      appBar: AppBar(title: const Text('Bills')),
      floatingActionButton: app.enabled(AppFeature.bills)
          ? FloatingActionButton(
              onPressed: () async {
                final name = TextEditingController();
                final amount = TextEditingController();
                final due = TextEditingController(text: '5');
                await showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Add bill'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
                        TextField(controller: amount, decoration: const InputDecoration(prefixText: '₹ ')),
                        TextField(controller: due, decoration: const InputDecoration(labelText: 'Due day')),
                      ],
                    ),
                    actions: [
                      FilledButton(
                        onPressed: () async {
                          await FinanceScope.of(context).run(() => app.upsertBill(
                                RecurringBill(
                                  id: newId(),
                                  name: name.text,
                                  amount: Money.parse(amount.text),
                                  dueDay: int.parse(due.text),
                                  categoryId: 'exp_bills',
                                ),
                              ));
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: !app.enabled(AppFeature.bills)
          ? const Center(child: Text('Bills are disabled.'))
          : ListView(children: app.bills.map((b) => ListTile(title: Text(b.name), trailing: Text(b.amount.format()))).toList()),
    );
  }
}

class LoansPage extends StatelessWidget {
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    return Scaffold(
      appBar: AppBar(title: const Text('Loans')),
      floatingActionButton: app.enabled(AppFeature.loans)
          ? FloatingActionButton(
              onPressed: () async {
                final name = TextEditingController(text: 'Home loan');
                final principal = TextEditingController(text: '500000');
                final emi = TextEditingController(text: '15000');
                await showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Add loan'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(controller: name, decoration: const InputDecoration(labelText: 'Name')),
                        TextField(controller: principal, decoration: const InputDecoration(labelText: 'Principal')),
                        TextField(controller: emi, decoration: const InputDecoration(labelText: 'EMI')),
                      ],
                    ),
                    actions: [
                      FilledButton(
                        onPressed: () async {
                          final p = Money.parse(principal.text);
                          await FinanceScope.of(context).run(() => app.upsertLoan(
                                Loan(
                                  id: newId(),
                                  name: name.text,
                                  principal: p,
                                  interestRate: 8,
                                  emi: Money.parse(emi.text),
                                  startDate: DateTime.now(),
                                  endDate: DateTime.now().add(const Duration(days: 365 * 5)),
                                  remaining: p,
                                ),
                              ));
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: !app.enabled(AppFeature.loans)
          ? const Center(child: Text('Loans are disabled.'))
          : ListView(children: app.loans.map((l) => ListTile(title: Text(l.name), trailing: Text(l.remaining.format()))).toList()),
    );
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final month = app.monthlyReport();
    final year = app.yearlyReport();
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FinzeeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Monthly ${month.range.year}-${month.range.month}'),
                Text('Income ${month.income.format()}'),
                Text('Expenses ${month.expenses.format()}'),
                Text('Savings ${month.savings.format()}'),
                Text('Investments ${month.investments.format()}'),
                Text('Remaining ${month.remaining.format()}'),
                Text('Allocation success ${(month.allocationSuccessRate * 100).round()}%'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text('Planned vs actual', style: TextStyle(fontWeight: FontWeight.w600)),
          ...month.plannedVsActual.map(
            (r) => ListTile(
              title: Text(r.name),
              subtitle: Text('${r.planned.format()} → ${r.actual.format()}'),
              trailing: Text(r.variance.format()),
            ),
          ),
          const SizedBox(height: 12),
          FinzeeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Year ${year.year}'),
                Text('Income ${year.income.format()}'),
                Text('Spending ${year.expenses.format()}'),
                Text('Savings rate ${(year.savingsRate * 100).toStringAsFixed(1)}%'),
                Text('Net worth ${year.netWorth.format()}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final body = TextEditingController();
          await showDialog<void>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Note'),
              content: TextField(controller: body, maxLines: 4),
              actions: [
                FilledButton(
                  onPressed: () async {
                    await FinanceScope.of(context).run(() => app.addNote(body.text));
                    if (ctx.mounted) Navigator.pop(ctx);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(children: app.notes.map((n) => ListTile(title: Text(n.body), subtitle: Text(n.createdAt.toString()))).toList()),
    );
  }
}

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    return Scaffold(
      appBar: AppBar(title: const Text('Features')),
      body: ListView(
        children: AppFeature.values
            .map(
              (f) => SwitchListTile(
                title: Text(f.label),
                subtitle: const Text('OFF hides UI only — data is never deleted.'),
                value: app.enabled(f),
                onChanged: (v) => FinanceScope.of(context).run(() => app.setFeature(f, v)),
              ),
            )
            .toList(),
      ),
    );
  }
}

class BackupPage extends StatelessWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    return Scaffold(
      appBar: AppBar(title: const Text('Backup & restore')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Exports a versioned JSON file of the complete local application state. Restore never happens blindly — a safety backup is created first.'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                final json = await app.backup.exportJson();
                await FilePicker.platform.saveFile(
                  dialogTitle: 'Save FinZee backup',
                  fileName: 'finance_backup_v1_${DateTime.now().toIso8601String().substring(0, 10)}.json',
                  bytes: utf8.encode(json),
                );
              },
              child: const Text('Export backup'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(withData: true);
                if (result == null || result.files.single.bytes == null) return;
                final incoming = utf8.decode(result.files.single.bytes!);
                final safety = await app.backup.exportJson();
                final summary = app.backup.summarize(incoming);
                if (!context.mounted) return;
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Restore backup?'),
                    content: Text('Schema v${summary.schemaVersion}\nAccounts ${summary.accountCount}\nTransactions ${summary.transactionCount}\nA safety backup of current data will be taken first.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Restore')),
                    ],
                  ),
                );
                if (ok == true && context.mounted) {
                  final ctrl = FinanceScope.of(context);
                  await ctrl.run(() async {
                    await app.backup.restore(incoming, safetyBackup: safety);
                    await app.reload();
                  });
                }
              },
              child: const Text('Restore backup'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    final pin = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Security')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(ctrl.app.lockEnabled ? 'App lock is ON' : 'App lock is OFF'),
            const SizedBox(height: 8),
            const Text(
              'PIN is hashed and stored only on this device. There is no account or cloud login.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: pin,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'PIN (min 4 digits)'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => ctrl.run(() => ctrl.app.enablePin(pin.text)),
              child: const Text('Enable PIN lock'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => ctrl.run(ctrl.app.disablePin),
              child: const Text('Disable lock'),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About FinZee')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'FinZee is a 100% offline personal finance manager.\n\nNo registration, no cloud, no ads, no analytics, no bank APIs.\n\nMode A: track income, expenses, accounts, and reports.\nMode B: enable salary planning for allocations, checklists, planned vs actual, and exceptions.',
        ),
      ),
    );
  }
}

extension _FirstOrNull<E> on Iterable<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
