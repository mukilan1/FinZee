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
import '../../shared/widgets/feedback.dart';
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
                : () => runWithFeedback(
                      context,
                      FinanceScope.of(context),
                      () => app.saveSalary(
                        SalaryProfile(
                          id: app.salary?.id ?? newId(),
                          baseAmount: Money.parse(amount.text),
                          payDay: int.parse(day.text),
                          source: source.text,
                          effectiveFrom: effective,
                        ),
                      ),
                      successMessage: 'Salary profile saved.',
                    ),
            child: const Text('Save salary'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: !app.enabled(AppFeature.salaryPlanning) || app.salary == null
                ? null
                : () => runWithFeedback(
                      context,
                      FinanceScope.of(context),
                      app.recordSalaryIncome,
                      successMessage: 'This month\'s salary recorded as income.',
                    ),
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
                final ok = await confirmDelete(
                  context,
                  title: 'Replace current data?',
                  body:
                      'This clears the local database and loads the sample household. Export a backup first if you have real data.',
                  confirmLabel: 'Load sample',
                );
                if (ok != true || !context.mounted) return;
                final loaded = await ctrl.run(() => ctrl.app.loadSampleData(reset: true));
                if (!context.mounted) return;
                if (loaded) {
                  showFinzeeSnackBar(
                    context,
                    'Sample household loaded. Your previous data on this device was replaced.',
                  );
                } else {
                  showFinzeeSnackBar(
                    context,
                    ctrl.error ?? 'Could not load sample data.',
                    error: true,
                  );
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
                onChanged: (v) async {
                  final ctrl = FinanceScope.of(context);
                  final ok = await ctrl.run(() => app.setFeature(f, v));
                  if (!context.mounted) return;
                  if (ok) {
                    showFinzeeSnackBar(
                      context,
                      v ? '${f.label} enabled.' : '${f.label} hidden. Your data is still saved.',
                    );
                  } else {
                    showFinzeeSnackBar(
                      context,
                      ctrl.error ?? 'Could not update ${f.label}.',
                      error: true,
                    );
                  }
                },
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
                final ctrl = FinanceScope.of(context);
                final json = await app.backup.exportJson();
                final saved = await FilePicker.platform.saveFile(
                  dialogTitle: 'Save FinZee backup',
                  fileName: 'finance_backup_v1_${DateTime.now().toIso8601String().substring(0, 10)}.json',
                  bytes: utf8.encode(json),
                );
                if (!context.mounted) return;
                if (saved != null) {
                  showFinzeeSnackBar(context, 'Backup exported successfully.');
                } else {
                  showFinzeeSnackBar(context, 'Backup export cancelled.', error: true);
                }
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
                final ok = await confirmDelete(
                  context,
                  title: 'Restore backup?',
                  body:
                      'Schema v${summary.schemaVersion}\nAccounts ${summary.accountCount}\nTransactions ${summary.transactionCount}\nThis replaces current data. A safety backup of current data will be taken first.',
                  confirmLabel: 'Restore',
                );
                if (ok != true || !context.mounted) return;
                final ctrl = FinanceScope.of(context);
                final restored = await ctrl.run(() async {
                  await app.backup.restore(incoming, safetyBackup: safety);
                  await app.reload();
                });
                if (!context.mounted) return;
                if (restored) {
                  showFinzeeSnackBar(
                    context,
                    'Backup restored. A safety copy of your previous data was saved first.',
                  );
                } else {
                  showFinzeeSnackBar(
                    context,
                    ctrl.error ?? 'Restore failed.',
                    error: true,
                  );
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

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool? _deviceLockAvailable;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final available = await FinanceScope.of(context).app.deviceLockAvailable();
      if (mounted) setState(() => _deviceLockAvailable = available);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    final available = _deviceLockAvailable;
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
              'FinZee uses your phone\'s native screen lock — fingerprint, face, PIN, or pattern. '
              'No separate FinZee password is stored.',
            ),
            if (available == false) ...[
              const SizedBox(height: 12),
              const Text(
                'Device security is not available here. Use a phone or tablet with a screen lock enabled.',
                style: TextStyle(color: FinzeeColors.expense),
              ),
            ],
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: available == false
                  ? null
                  : () => runWithFeedback(
                        context,
                        ctrl,
                        ctrl.app.enableAppLock,
                        successMessage: 'App lock enabled using your device security.',
                      ),
              icon: const Icon(Icons.fingerprint),
              label: const Text('Enable device lock'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: !ctrl.app.lockEnabled
                  ? null
                  : () => runWithFeedback(
                        context,
                        ctrl,
                        ctrl.app.disableAppLock,
                        successMessage: 'App lock disabled.',
                      ),
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
