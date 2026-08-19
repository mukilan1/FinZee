import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../application/financial_calculation_service.dart';
import '../../core/features.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/finzee_ui.dart';
import '../../shared/widgets/transaction_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    if (ctrl.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    final palette = context.finzee;
    final now = DateTime.now();
    final range = MonthRange(now.year, now.month);
    final dash = ctrl.app.dashboard(now);
    final cats = {for (final c in ctrl.app.categories) c.id: c.name};
    final monthTx = ctrl.app.transactions.where((t) => range.contains(t.date)).toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      children: [
        Text('How am I doing this month?', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: FinzeeSpacing.md),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: palette.primaryDark,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total balance', style: TextStyle(color: palette.background.withValues(alpha: 0.7))),
              const SizedBox(height: 6),
              Text(
                dash.totalBalance.format(),
                style: TextStyle(
                  color: palette.background,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: FinzeeSpacing.md),
              Row(
                children: [
                  MetricChip(label: 'Income', value: dash.income.format()),
                  MetricChip(label: 'Expenses', value: dash.expenses.format()),
                ],
              ),
              const SizedBox(height: FinzeeSpacing.sm),
              Row(
                children: [
                  MetricChip(label: 'Savings', value: dash.savings.format()),
                  MetricChip(label: 'Invested', value: dash.investments.format()),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: FinzeeSpacing.lg),
        FinzeeCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Monthly cash flow', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(
                '${range.year}-${range.month.toString().padLeft(2, '0')} · income vs spending by week',
                style: TextStyle(color: palette.textSecondary, fontSize: 12),
              ),
              const SizedBox(height: FinzeeSpacing.md),
              SizedBox(
                height: 200,
                child: _WeeklyCashFlowChart(transactions: monthTx, palette: palette),
              ),
              const SizedBox(height: FinzeeSpacing.sm),
              Row(
                children: [
                  _LegendDot(color: palette.income, label: 'Income'),
                  const SizedBox(width: FinzeeSpacing.md),
                  _LegendDot(color: palette.expense, label: 'Spending'),
                ],
              ),
            ],
          ),
        ),
        if (dash.categorySpend.isNotEmpty) ...[
          const SizedBox(height: FinzeeSpacing.md),
          FinzeeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Top spending', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: FinzeeSpacing.sm),
                ...dash.categorySpend.take(5).map(
                      (c) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(child: Text(c.category.name)),
                            Text(c.amount.format(), style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ],
        if (ctrl.app.enabled(AppFeature.salaryPlanning) && dash.allocationTotal > 0) ...[
          const SizedBox(height: FinzeeSpacing.md),
          FinzeeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Monthly plan', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: FinzeeSpacing.sm),
                Text('${dash.allocationCompleted} / ${dash.allocationTotal} completed'),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: dash.allocationTotal == 0
                      ? 0
                      : dash.allocationCompleted / dash.allocationTotal,
                  color: palette.primary,
                  backgroundColor: palette.primarySoft,
                ),
                const SizedBox(height: FinzeeSpacing.sm),
                Text(
                  '${dash.allocatedActual.format()} / ${dash.allocatedPlanned.format()} allocated',
                  style: TextStyle(color: palette.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
        if (dash.alerts.any((a) => !a.read)) ...[
          const SizedBox(height: FinzeeSpacing.md),
          ...dash.alerts.where((a) => !a.read).take(3).map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: FinzeeSpacing.sm),
              child: FinzeeCard(
                color: palette.primarySoft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(a.body, style: TextStyle(fontSize: 13, color: palette.textSecondary)),
                  ],
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: FinzeeSpacing.md),
        Text('Recent transactions', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: FinzeeSpacing.sm),
        if (dash.recent.isEmpty)
          const EmptyState(title: 'No transactions yet', subtitle: 'Tap + to add your first income or expense.')
        else
          FinzeeCard(
            child: Column(
              children: dash.recent
                  .map((tx) => TransactionRow(tx: tx, categoryName: cats[tx.categoryId]))
                  .toList(),
            ),
          ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 12, color: context.finzee.textSecondary)),
      ],
    );
  }
}

class _WeeklyCashFlowChart extends StatelessWidget {
  const _WeeklyCashFlowChart({required this.transactions, required this.palette});
  final List<FinanceTransaction> transactions;
  final FinzeePalette palette;

  @override
  Widget build(BuildContext context) {
    final weeks = List.generate(5, (_) => (income: 0.0, expense: 0.0));
    final data = weeks.toList();
    for (final tx in transactions) {
      final week = ((tx.date.day - 1) / 7).floor().clamp(0, 4);
      if (tx.type == TransactionType.income) {
        data[week] = (income: data[week].income + tx.amount.major, expense: data[week].expense);
      } else if (tx.type == TransactionType.expense) {
        data[week] = (income: data[week].income, expense: data[week].expense + tx.amount.major);
      }
    }
    final maxY = data.fold<double>(0, (m, w) {
      final top = w.income > w.expense ? w.income : w.expense;
      return top > m ? top : m;
    });
    return BarChart(
      BarChartData(
        maxY: maxY <= 0 ? 1000 : maxY * 1.25,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY <= 0 ? 250 : maxY / 4,
          getDrawingHorizontalLine: (_) => FlLine(color: palette.border.withValues(alpha: 0.4), strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              getTitlesWidget: (v, _) => Text(
                v >= 1000 ? '${(v / 1000).toStringAsFixed(0)}k' : v.toStringAsFixed(0),
                style: TextStyle(fontSize: 10, color: palette.textSecondary),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (v, _) {
                final i = v.toInt();
                if (i < 0 || i >= 5) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text('W${i + 1}', style: TextStyle(fontSize: 11, color: palette.textSecondary)),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < 5; i++)
            BarChartGroupData(
              x: i,
              barsSpace: 4,
              barRods: [
                BarChartRodData(
                  toY: data[i].income,
                  color: palette.income,
                  width: 10,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
                BarChartRodData(
                  toY: data[i].expense,
                  color: palette.expense,
                  width: 10,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
