class Routes {
  // Main Navigation Routes
  static const String dashboard = '/';
  static const String activities = '/activities';
  static const String finance = '/finance';
  static const String calendar = '/calendar';
  static const String habits = '/habits';
  static const String settings = '/settings';
  
  // Sub Routes
  static const String addActivity = '/activities/add';
  static const String activityDetail = '/activities/detail';
  static const String addTransaction = '/finance/add-transaction';
  static const String budget = '/finance/budget';
  static const String financialGoals = '/finance/goals';
  static const String addEvent = '/calendar/add-event';
  static const String addHabit = '/habits/add';
  static const String notificationSettings = '/settings/notifications';
  
  // Auth Routes (for future implementation)
  static const String login = '/login';
  static const String register = '/register';
  static const String onboarding = '/onboarding';
}