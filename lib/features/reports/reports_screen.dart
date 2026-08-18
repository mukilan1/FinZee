import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../application/financial_calculation_service.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/list_controls.dart';
import '../../shared/widgets/transaction_row.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String query = '';
  String sort = 'newest';

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    var months = app.reportMonths();
    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      months = months
          .where((m) => '${m.year}-${m.month.toString().padLeft(2, '0')}'.contains(q))
          .toList();
    }
    months.sort((a, b) {
      final da = DateTime(a.year, a.month);
      final db = DateTime(b.year, b.month);
      return sort == 'oldest' ? da.compareTo(db) : db.compareTo(da);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListControls(
            query: query,
            onQuery: (v) => setState(() => query = v),
            hint: 'Search by year-month (e.g. 2026-03)',
            sorts: const [('newest', 'Newest'), ('oldest', 'Oldest')],
            sortId: sort,
            onSort: (v) => setState(() => sort = v),
          ),
          const SizedBox(height: 12),
          if (months.isEmpty)
            const EmptyState(
              title: 'No monthly reports yet',
              subtitle: 'Add transactions or generate a monthly plan to see reports here.',
            )
          else
            ...months.map(
              (range) => _MonthSummaryTile(
                range: range,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => MonthlyReportDetailPage(range: range),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MonthSummaryTile extends StatelessWidget {
  const _MonthSummaryTile({required this.range, required this.onTap});

  final MonthRange range;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final report = app.monthlyReport(DateTime(range.year, range.month, 1));
    final palette = context.finzee;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FinzeeCard(
        padding: EdgeInsets.zero,
        child: ListTile(
          onTap: onTap,
          title: Text('${range.year}-${range.month.toString().padLeft(2, '0')}'),
          subtitle: Text(
            'Income ${report.income.format()} · Expenses ${report.expenses.format()} · '
            'Savings ${report.savings.format()}',
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(report.allocationSuccessRate * 100).round()}%',
                style: TextStyle(
                  color: palette.primaryDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text('plan success', style: TextStyle(color: palette.textSecondary, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}

class MonthlyReportDetailPage extends StatefulWidget {
  const MonthlyReportDetailPage({super.key, required this.range});

  final MonthRange range;

  @override
  State<MonthlyReportDetailPage> createState() => _MonthlyReportDetailPageState();
}

class _MonthlyReportDetailPageState extends State<MonthlyReportDetailPage> {
  MonthlyReport? _report;
  List<FinanceTransaction> _transactions = [];
  List<AllocationItem> _allocations = [];
  MonthlyPlan? _plan;
  String query = '';
  String? typeFilter;
  String sort = 'date';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    final app = FinanceScope.of(context).app;
    final report = await app.monthlyReportFor(widget.range.year, widget.range.month);
    final matches = app.allPlans
        .where((p) => p.year == widget.range.year && p.month == widget.range.month);
    var loadedPlan = matches.isEmpty ? null : matches.first;
    List<AllocationItem> allocs = [];
    loadedPlan ??= await app.repo.planFor(widget.range.year, widget.range.month);
    if (loadedPlan != null) {
      allocs = await app.repo.allocationsFor(loadedPlan.id);
    }
    if (!mounted) return;
    setState(() {
      _report = report;
      _plan = loadedPlan;
      _allocations = allocs;
      _transactions = app.transactionsForMonth(widget.range.year, widget.range.month);
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.finzee;
    final report = _report;
    if (report == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.range.year}-${widget.range.month.toString().padLeft(2, '0')}'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    var txs = _transactions.where((t) {
      if (typeFilter != null && t.type.name != typeFilter) return false;
      if (query.isEmpty) return true;
      final q = query.toLowerCase();
      return (t.note ?? '').toLowerCase().contains(q) ||
          t.type.name.contains(q) ||
          t.amount.format().toLowerCase().contains(q);
    }).toList();
    txs.sort((a, b) => switch (sort) {
          'amount' => b.amount.minor.compareTo(a.amount.minor),
          'type' => a.type.name.compareTo(b.type.name),
          _ => b.date.compareTo(a.date),
        });

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.range.year}-${widget.range.month.toString().padLeft(2, '0')}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FinzeeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Monthly brief', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Income ${report.income.format()}'),
                Text('Expenses ${report.expenses.format()}'),
                Text('Savings ${report.savings.format()}'),
                Text('Investments ${report.investments.format()}'),
                Text('Remaining ${report.remaining.format()}'),
                Text('Allocation success ${(report.allocationSuccessRate * 100).round()}%'),
                if (_plan?.confirmedAt != null)
                  Text('Plan confirmed ${formatRecordTimestamp(_plan!.confirmedAt)}'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FinzeeCard(
            child: SizedBox(
              height: 180,
              child: _CashFlowChart(report: report),
            ),
          ),
          const SizedBox(height: 12),
          if (report.categorySpend.isNotEmpty) ...[
            Text('Spending by category', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            FinzeeCard(
              child: SizedBox(
                height: 180,
                child: _CategoryChart(items: report.categorySpend),
              ),
            ),
            const SizedBox(height: 12),
          ],
          Text('Planned vs actual', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (report.plannedVsActual.isEmpty)
            Text('No plan allocations for this month.', style: TextStyle(color: palette.textSecondary))
          else
            ...report.plannedVsActual.map(
              (row) => ListTile(
                title: Text(row.name),
                subtitle: Text('${row.planned.format()} → ${row.actual.format()}'),
                trailing: Text(row.variance.format()),
              ),
            ),
          const SizedBox(height: 12),
          Text('Allocations timeline', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (_allocations.isEmpty)
            Text('No allocation records.', style: TextStyle(color: palette.textSecondary))
          else
            ..._allocations.map(
              (a) => ListTile(
                dense: true,
                title: Text(a.name),
                subtitle: Text(
                  '${a.status.name}'
                  '${a.statusChangedAt != null ? ' · ${formatRecordTimestamp(a.statusChangedAt)}' : ''}',
                ),
                trailing: Text(a.plannedAmount.format()),
              ),
            ),
          const SizedBox(height: 12),
          Text('Transactions', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ListControls(
            query: query,
            onQuery: (v) => setState(() => query = v),
            hint: 'Search transactions',
            filters: TransactionType.values.map((t) => t.name).toList(),
            selectedFilter: typeFilter,
            onFilter: (v) => setState(() => typeFilter = v),
            sorts: const [
              ('date', 'Date'),
              ('amount', 'Amount'),
              ('type', 'Type'),
            ],
            sortId: sort,
            onSort: (v) => setState(() => sort = v),
          ),
          const SizedBox(height: 8),
          if (txs.isEmpty)
            Text('No matching transactions.', style: TextStyle(color: palette.textSecondary))
          else
            ...txs.map((tx) => TransactionRow(tx: tx)),
        ],
      ),
    );
  }
}

class _CashFlowChart extends StatelessWidget {
  const _CashFlowChart({required this.report});

  final MonthlyReport report;

  @override
  Widget build(BuildContext context) {
    final palette = context.finzee;
    final bars = [
      ('Income', report.income, palette.income),
      ('Expenses', report.expenses, palette.expense),
      ('Savings', report.savings, palette.savings),
      ('Invest', report.investments, palette.investment),
    ];
    final maxY = bars.fold<double>(0, (m, e) {
      final major = e.$2.major.toDouble();
      return major > m ? major : m;
    });
    return BarChart(
      BarChartData(
        maxY: maxY <= 0 ? 1 : maxY * 1.2,
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= bars.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(bars[i].$1, style: const TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          for (var i = 0; i < bars.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: bars[i].$2.major.toDouble(),
                  color: bars[i].$3,
                  width: 18,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _CategoryChart extends StatelessWidget {
  const _CategoryChart({required this.items});

  final List<CategorySpend> items;

  @override
  Widget build(BuildContext context) {
    final palette = context.finzee;
    final top = items.take(5).toList();
    final colors = [
      palette.primary,
      palette.income,
      palette.expense,
      palette.investment,
      palette.warning,
    ];
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 28,
        sections: [
          for (var i = 0; i < top.length; i++)
            PieChartSectionData(
              value: top[i].amount.major.toDouble(),
              color: colors[i % colors.length],
              title: top[i].category.name,
              radius: 52,
              titleStyle: const TextStyle(fontSize: 10, color: Colors.white),
            ),
        ],
      ),
    );
  }
}
