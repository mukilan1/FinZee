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
import '../../shared/widgets/list_controls.dart';
import '../../shared/widgets/transaction_row.dart';
import '../manage/crud_pages.dart';

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
          _tile(context, Icons.science_outlined, 'Sample data', const SampleDataPage()),
          _tile(context, Icons.toggle_on_outlined, 'Features', const FeaturesPage()),
          _tile(context, Icons.backup_outlined, 'Backup & restore', const BackupPage()),
          _tile(context, Icons.lock_outline, 'Security', const SecurityPage()),
          _tile(context, Icons.delete_forever_outlined, 'Delete all data', const DangerZonePage()),
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
        onTap: () => Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }
}

class SalaryPage extends StatefulWidget {
  const SalaryPage({super.key});
  @override
  State<SalaryPage> createState() => _SalaryPageState();
}

class _SalaryPageState extends State<SalaryPage> {
  late final amount = TextEditingController();
  late final day = TextEditingController();
  late final source = TextEditingController();
  DateTime effective = DateTime.now();

  bool _seeded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_seeded) return;
    final salary = FinanceScope.of(context).app.salary;
    amount.text = salary == null ? '' : '${salary.baseAmount.major}';
    day.text = '${salary?.payDay ?? 1}';
    source.text = salary?.source ?? 'Employer';
    effective = salary?.effectiveFrom ?? DateTime.now();
    _seeded = true;
  }

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
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
          const SizedBox(height: 12),
          TextField(controller: source, decoration: const InputDecoration(labelText: 'Source')),
          TimelineTile(
            label: 'Effective from',
            date: effective,
            onPick: () async {
              final d = await pickTimeline(context, initial: effective);
              if (d != null) setState(() => effective = d);
            },
          ),
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
                          source: source.text,
                          effectiveFrom: effective,
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

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});
  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late DateTime month = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final report = app.monthlyReport(month);
    final year = app.yearlyReport(month);
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TimelineTile(
            label: 'Report month',
            date: DateTime(month.year, month.month, 1),
            onPick: () async {
              final d = await pickTimeline(context, initial: month);
              if (d != null) setState(() => month = d);
            },
          ),
          FinzeeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Monthly ${report.range.year}-${report.range.month}'),
                Text('Income ${report.income.format()}'),
                Text('Expenses ${report.expenses.format()}'),
                Text('Savings ${report.savings.format()}'),
                Text('Investments ${report.investments.format()}'),
                Text('Remaining ${report.remaining.format()}'),
                Text('Allocation success ${(report.allocationSuccessRate * 100).round()}%'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text('Planned vs actual', style: TextStyle(fontWeight: FontWeight.w600)),
          ...report.plannedVsActual.map(
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

class SampleDataPage extends StatelessWidget {
  const SampleDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sample data')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Loads a full household example: salary history, 3 months of transactions, '
              'monthly plan with completed / partial / skipped allocations, goals, '
              'investments, bills, loan EMI, budgets, and notes.',
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Replace current data?'),
                    content: const Text(
                      'This clears the local database and loads the sample household. Export a backup first if you have real data.',
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Load sample')),
                    ],
                  ),
                );
                if (ok == true && context.mounted) {
                  await ctrl.run(() => ctrl.app.loadSampleData(reset: true));
                }
              },
              child: const Text('Load sample household'),
            ),
          ],
        ),
      ),
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
