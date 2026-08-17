import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../../app/theme.dart';
import '../../core/features.dart';
import '../../features/manage/crud_pages.dart';
import '../../features/more/more_screen.dart';
import '../../features/reports/reports_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final app = FinanceScope.of(context).app;
    final palette = context.finzee;
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Text('Finance', style: Theme.of(context).textTheme.titleLarge),
            ),
            _item(context, Icons.account_balance_wallet_outlined, 'Accounts', const AccountsPage()),
            _item(context, Icons.category_outlined, 'Categories', const CategoriesPage()),
            if (app.enabled(AppFeature.salaryPlanning))
              _item(context, Icons.payments_outlined, 'Salary & income', const SalaryPage()),
            _item(context, Icons.pie_chart_outline, 'Budgets', const BudgetsPage()),
            if (app.enabled(AppFeature.investments))
              _item(context, Icons.show_chart, 'Investments', const InvestmentsPage()),
            if (app.enabled(AppFeature.bills))
              _item(context, Icons.receipt_long_outlined, 'Bills', const BillsPage()),
            if (app.enabled(AppFeature.loans))
              _item(context, Icons.account_balance_outlined, 'Loans', const LoansPage()),
            _item(context, Icons.insights_outlined, 'Reports', const ReportsScreen()),
            _item(context, Icons.notes_outlined, 'Notes', const NotesPage()),
            const Divider(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Offline · private · local only',
                style: TextStyle(color: palette.textSecondary, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, IconData icon, String title, Widget page) {
    final palette = context.finzee;
    return ListTile(
      leading: Icon(icon, color: palette.primaryDark),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute<void>(builder: (_) => page),
        );
      },
    );
  }
}
