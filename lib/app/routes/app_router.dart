import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/activities/presentation/pages/activities_page.dart';
import '../../features/activities/presentation/pages/add_activity_page.dart';
import '../../features/finance/presentation/pages/finance_overview_page.dart';
import '../../features/finance/presentation/pages/add_transaction_page.dart';
import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/habits/presentation/pages/habits_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.dashboard,
    routes: [
      // Dashboard Route
      GoRoute(
        path: Routes.dashboard,
        name: 'dashboard',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const DashboardPage(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      
      // Activities Routes
      GoRoute(
        path: Routes.activities,
        name: 'activities',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ActivitiesPage(),
          transitionsBuilder: _slideTransition,
        ),
        routes: [
          GoRoute(
            path: '/add',
            name: 'add-activity',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const AddActivityPage(),
              transitionsBuilder: _slideUpTransition,
            ),
          ),
        ],
      ),
      
      // Finance Routes
      GoRoute(
        path: Routes.finance,
        name: 'finance',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const FinanceOverviewPage(),
          transitionsBuilder: _slideTransition,
        ),
        routes: [
          GoRoute(
            path: '/add-transaction',
            name: 'add-transaction',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const AddTransactionPage(),
              transitionsBuilder: _slideUpTransition,
            ),
          ),
        ],
      ),
      
      // Calendar Route
      GoRoute(
        path: Routes.calendar,
        name: 'calendar',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CalendarPage(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      
      // Habits Route
      GoRoute(
        path: Routes.habits,
        name: 'habits',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HabitsPage(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      
      // Settings Route
      GoRoute(
        path: Routes.settings,
        name: 'settings',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SettingsPage(),
          transitionsBuilder: _slideTransition,
        ),
      ),
    ],
  );
});

// Custom Page Transitions
Widget _slideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCubic,
    )),
    child: child,
  );
}

Widget _slideUpTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutCubic,
    )),
    child: FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}