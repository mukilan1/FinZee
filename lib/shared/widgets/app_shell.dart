import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../domain/entities.dart';
import '../../features/notifications/notifications_page.dart';
import '../../features/transactions/add_sheet.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final ctrl = FinanceScope.of(context);
    final unread = ctrl.app.unreadAlertCount();
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinZee'),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const NotificationsPage(),
                ),
              );
            },
            icon: Badge(
              isLabelVisible: unread > 0,
              label: Text(unread > 99 ? '99+' : '$unread'),
              child: Icon(
                unread > 0
                    ? Icons.notifications
                    : Icons.notifications_outlined,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (ctrl.error != null)
            Material(
              color: FinzeeColors.expense,
              child: SafeArea(
                bottom: false,
                child: ListTile(
                  dense: true,
                  title: Text(ctrl.error!, style: const TextStyle(color: Colors.white)),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: ctrl.clearError,
                  ),
                ),
              ),
            ),
          Expanded(child: navigationShell),
        ],
      ),
      floatingActionButton: navigationShell.currentIndex <= 1
          ? FloatingActionButton(
              backgroundColor: FinzeeColors.primaryDark,
              onPressed: () => showAddSheet(context, TransactionType.expense),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        height: 68,
        backgroundColor: FinzeeColors.surface,
        indicatorColor: FinzeeColors.primarySoft,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_horiz_outlined),
            selectedIcon: Icon(Icons.swap_horiz),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note),
            label: 'Plan',
          ),
          NavigationDestination(
            icon: Icon(Icons.flag_outlined),
            selectedIcon: Icon(Icons.flag),
            label: 'Goals',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            selectedIcon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
