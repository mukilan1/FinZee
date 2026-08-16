import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/features.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/transaction_row.dart';
import '../transactions/add_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    if (ctrl.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    final dash = ctrl.app.dashboard();
    final cats = {for (final c in ctrl.app.categories) c.id: c.name};
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          const Text('FinZee', style: TextStyle(color: FinzeeColors.textSecondary)),
          const SizedBox(height: 4),
          Text('How am I doing this month?', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: FinzeeColors.primaryDark,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Balance', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 6),
                Text(
                  dash.totalBalance.format(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    MetricChip(label: 'Income', value: dash.income.format()),
                    MetricChip(label: 'Expenses', value: dash.expenses.format()),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    MetricChip(label: 'Savings', value: dash.savings.format()),
                    MetricChip(label: 'Invested', value: dash.investments.format()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Quick(icon: Icons.remove, label: 'Expense', onTap: () => showAddSheet(context, TransactionType.expense)),
              _Quick(icon: Icons.add, label: 'Income', onTap: () => showAddSheet(context, TransactionType.income)),
              _Quick(icon: Icons.swap_horiz, label: 'Transfer', onTap: () => showAddSheet(context, TransactionType.transfer)),
              _Quick(icon: Icons.savings_outlined, label: 'Saving', onTap: () => showAddSheet(context, TransactionType.saving)),
            ],
          ),
          const SizedBox(height: 20),
          FinzeeCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cash flow', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 140,
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [
                          BarChartRodData(toY: dash.income.major, color: FinzeeColors.income, width: 18, borderRadius: BorderRadius.circular(8)),
                        ]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(toY: dash.expenses.major, color: FinzeeColors.expense, width: 18, borderRadius: BorderRadius.circular(8)),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (dash.categorySpend.isNotEmpty) ...[
            const SizedBox(height: 16),
            FinzeeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Spending breakdown', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  ...dash.categorySpend.take(5).map(
                        (c) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
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
            const SizedBox(height: 16),
            FinzeeCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Monthly plan', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text('${dash.allocationCompleted} / ${dash.allocationTotal} completed'),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: dash.allocationTotal == 0
                        ? 0
                        : dash.allocationCompleted / dash.allocationTotal,
                    color: FinzeeColors.primary,
                    backgroundColor: FinzeeColors.primarySoft,
                  ),
                  const SizedBox(height: 8),
                  Text('${dash.allocatedActual.format()} / ${dash.allocatedPlanned.format()} allocated',
                      style: const TextStyle(color: FinzeeColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
          ],
          if (dash.alerts.isNotEmpty) ...[
            const SizedBox(height: 16),
            ...dash.alerts.map(
              (a) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: FinzeeCard(
                  color: FinzeeColors.primarySoft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                      Text(a.body, style: const TextStyle(fontSize: 13, color: FinzeeColors.textSecondary)),
                    ],
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 8),
          const Text('Recent transactions', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          if (dash.recent.isEmpty)
            const EmptyState(title: 'No transactions yet', subtitle: 'Add income or an expense to start Mode A tracking.')
          else
            FinzeeCard(
              child: Column(
                children: dash.recent
                    .map((tx) => TransactionRow(tx: tx, categoryName: cats[tx.categoryId]))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _Quick extends StatelessWidget {
  const _Quick({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: FinzeeColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: FinzeeColors.primaryDark),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: FinzeeColors.textSecondary)),
      ],
    );
  }
}
