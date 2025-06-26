import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import '../../calendar/presentation/pages/calendar_page.dart';
// import '../../calendar/presentation/pages/add_event_page.dart';

// import '../../habits/presentation/pages/habits_page.dart';
// import '../../habits/presentation/pages/add_habit_page.dart';

// import '../../finance/presentation/pages/finance_overview_page.dart';
// import '../../finance/presentation/pages/add_transaction_page.dart';
// import '../../finance/presentation/pages/budget_page.dart';
// import '../../finance/presentation/pages/financial_goals_page.dart';

// import '../../activities/presentation/pages/activities_page.dart';
// import '../../activities/presentation/pages/add_activity_page.dart';
// import '../../activities/presentation/pages/activity_detail_page.dart';

// import '../../settings/presentation/pages/settings_page.dart';
// import '../../settings/presentation/pages/notification_settings_page.dart';

import '../../../../features/dashboard/presentation/pages/dashboard_page.dart';

import 'routes.dart';

final appRouter = GoRouter(
  initialLocation: Routes.dashboard,
  routes: [
    GoRoute(
      path: Routes.dashboard,
      builder: (context, state) => const DashboardPage(),
    ),
//     // Finance
//     GoRoute(
//       path: Routes.financeOverview,
//       builder: (context, state) => const FinanceOverviewPage(),
//     ),
//     GoRoute(
//       path: Routes.addTransaction,
//       builder: (context, state) => const AddTransactionPage(),
//     ),
//     GoRoute(
//       path: Routes.budget,
//       builder: (context, state) => const BudgetPage(),
//     ),
//     GoRoute(
//       path: Routes.goals,
//       builder: (context, state) => const FinancialGoalsPage(),
//     ),

//     // Habits
//     GoRoute(
//       path: Routes.habits,
//       builder: (context, state) => const HabitsPage(),
//     ),
//     GoRoute(
//       path: Routes.addHabit,
//       builder: (context, state) => const AddHabitPage(),
//     ),

//     // Calendar
//     GoRoute(
//       path: Routes.calendar,
//       builder: (context, state) => const CalendarPage(),
//     ),
//     GoRoute(
//       path: Routes.addEvent,
//       builder: (context, state) => const AddEventPage(),
//     ),

//     // Activities
//     GoRoute(
//       path: Routes.activities,
//       builder: (context, state) => const ActivitiesPage(),
//     ),
//     GoRoute(
//       path: Routes.addActivity,
//       builder: (context, state) => const AddActivityPage(),
//     ),
//     GoRoute(
//       path: Routes.activityDetail,
//       builder: (context, state) => const ActivityDetailPage(),
//     ),

//     // Settings
//     GoRoute(
//       path: Routes.settings,
//       builder: (context, state) => const SettingsPage(),
//     ),
//     GoRoute(
//       path: Routes.notificationSettings,
//       builder: (context, state) => const NotificationSettingsPage(),
//     ),
  ],
);
