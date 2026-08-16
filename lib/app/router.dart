import 'package:go_router/go_router.dart';

import '../features/dashboard/home_screen.dart';
import '../features/goals/goals_screen.dart';
import '../features/more/more_screen.dart';
import '../features/planning/plan_screen.dart';
import '../features/transactions/transactions_screen.dart';
import '../shared/widgets/app_shell.dart';

GoRouter createAppRouter() => GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/transactions',
            builder: (_, _) => const TransactionsScreen(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/plan', builder: (_, _) => const PlanScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/goals', builder: (_, _) => const GoalsScreen()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: '/more', builder: (_, _) => const MoreScreen()),
        ]),
      ],
    ),
  ],
);
