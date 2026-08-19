import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/features.dart';
import '../../domain/entities.dart';
import '../../shared/widgets/finzee_card.dart';
import '../../shared/widgets/list_controls.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String query = '';
  String? kindFilter;
  String sort = 'severity';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final ctrl = FinanceScope.of(context);
      ctrl.run(() => ctrl.app.markInboxRead());
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    var alerts = ctrl.app.allAlerts();
    final kinds = alerts.map((a) => a.kind).toSet().toList();
    alerts = alerts.where((a) {
      if (kindFilter != null && a.kind != kindFilter) return false;
      if (query.isNotEmpty) {
        final hay = '${a.title} ${a.body} ${a.kind}'.toLowerCase();
        if (!hay.contains(query.toLowerCase())) return false;
      }
      return true;
    }).toList();
    alerts.sort((a, b) => switch (sort) {
          'name' => a.title.compareTo(b.title),
          _ => b.severity.compareTo(a.severity),
        });
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          ListControls(
            query: query,
            onQuery: (v) => setState(() => query = v),
            hint: 'Search alerts',
            filters: kinds,
            selectedFilter: kindFilter,
            onFilter: (v) => setState(() => kindFilter = v),
            sorts: const [('severity', 'Priority'), ('name', 'Title')],
            sortId: sort,
            onSort: (v) => setState(() => sort = v),
          ),
          const SizedBox(height: 12),
          if (alerts.isEmpty)
            const EmptyState(
              title: 'You are all caught up',
              subtitle: 'Alerts from salary, bills, budgets, goals, and accounts show up here.',
            )
          else
            ...alerts.map(
              (alert) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _AlertTile(alert: alert),
              ),
            ),
        ],
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  const _AlertTile({required this.alert});
  final LocalAlert alert;

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    final palette = context.finzee;
    final color = alert.severity >= 2 ? palette.expense : palette.warning;
    AppFeature? feature;
    for (final value in AppFeature.values) {
      if (value.key == alert.featureKey) {
        feature = value;
        break;
      }
    }
    return FinzeeCard(
      color: alert.read ? palette.surface : palette.primarySoft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_iconFor(alert.kind), color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alert.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(
                  alert.body,
                  style: TextStyle(color: palette.textSecondary, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  feature?.label ?? 'Accounts',
                  style: TextStyle(fontSize: 11, color: palette.textSecondary),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Dismiss',
            onPressed: () => confirmAndErase(
              context,
              title: 'Dismiss this alert?',
              body: 'The alert is hidden from the inbox. Financial records are not deleted.',
              confirmLabel: 'Dismiss',
              erase: () => ctrl.run(() => ctrl.app.dismissAlert(alert.id)),
              doneTitle: 'Dismissed',
              doneBody: 'This alert was removed from the inbox.',
              failBody: () => ctrl.error,
            ),
            icon: const Icon(Icons.close, size: 18),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(String kind) => switch (kind) {
        'salary' => Icons.payments_outlined,
        'allocation' => Icons.event_note_outlined,
        'budget' => Icons.pie_chart_outline,
        'bill' => Icons.receipt_long_outlined,
        'loan' => Icons.account_balance_outlined,
        'goal' => Icons.flag_outlined,
        'investment' => Icons.show_chart,
        _ => Icons.notifications_outlined,
      };
}
