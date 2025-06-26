// core/constants/notification_constants.dart
class NotificationConstants {
  // Channel IDs
  static const String pomodoroChannelId = 'pomodoro_channel';
  static const String habitChannelId = 'habit_reminder_channel';
  static const String goalChannelId = 'goal_reminder_channel';
  static const String achievementChannelId = 'achievement_channel';
  static const String incomeChannelId = 'income_reminder_channel';
  
  // Channel Names
  static const String pomodoroChannelName = 'Pomodoro Timer';
  static const String habitChannelName = 'Habit Reminders';
  static const String goalChannelName = 'Goal Reminders';
  static const String achievementChannelName = 'Achievements';
  static const String incomeChannelName = 'Income Tracking';
  
  // Channel Descriptions
  static const String pomodoroChannelDescription = 'Notifications for Pomodoro timer sessions';
  static const String habitChannelDescription = 'Daily reminders for your habits';
  static const String goalChannelDescription = 'Reminders about your goals and deadlines';
  static const String achievementChannelDescription = 'Congratulations on your achievements';
  static const String incomeChannelDescription = 'Reminders to track your income';
  
  // Notification IDs
  static const int pomodoroTimerId = 1000;
  static const int pomodoroBreakId = 1001;
  static const int dailyHabitId = 2000;
  static const int goalDeadlineId = 3000;
  static const int achievementUnlockedId = 4000;
  static const int incomeReminderBaseId = 5000;
  
  // Pomodoro Notifications
  static const String pomodoroCompleteTitle = '🍅 Pomodoro Complete!';
  static const String pomodoroCompleteBody = 'Great work! Time for a break.';
  static const String breakCompleteTitle = '⏰ Break Time Over!';
  static const String breakCompleteBody = 'Ready to focus? Start your next session.';
  static const String longBreakTitle = '🌟 Long Break Time!';
  static const String longBreakBody = 'You\'ve earned a longer break. Recharge yourself!';
  
  // Habit Notifications
  static const String habitReminderTitle = '💪 Time for Your Habit!';
  static const String habitStreakTitle = '🔥 Streak Milestone!';
  static const String habitMissedTitle = '⚠️ Don\'t Break Your Streak!';
  
  // Goal Notifications
  static const String goalDeadlineTitle = '📅 Goal Deadline Approaching';
  static const String goalCompletedTitle = '🎯 Goal Achieved!';
  static const String goalProgressTitle = '📈 Great Progress!';
  
  // Achievement Notifications
  static const String achievementUnlockedTitle = '🏆 Achievement Unlocked!';
  static const String milestoneReachedTitle = '🌟 Milestone Reached!';
  static const String levelUpTitle = '⬆️ Level Up!';
  
  // Income Notifications
  static const String incomeReminderTitle = '💰 Track Your Income';
  static const String incomeReminderBody = 'Don\'t forget to log today\'s earnings!';
  static const String incomeGoalTitle = '💎 Income Goal Progress';
  
  // Motivational Messages
  static const List<String> pomodoroMotivational = [
    'Every focused minute counts! 🎯',
    'You\'re building wealth one session at a time! 💰',
    'Consistency is the key to success! 🔑',
    'Your future self will thank you! 🙏',
    'Time invested wisely pays dividends! 📈',
  ];
  
  static const List<String> habitMotivational = [
    'Small habits, big results! 🌱',
    'You\'re on fire! Keep the streak alive! 🔥',
    'Success is built one habit at a time! 🏗️',
    'Every day you\'re getting stronger! 💪',
    'Consistency beats perfection! ⭐',
  ];
  
  static const List<String> goalMotivational = [
    'You\'re closer to your dreams! ✨',
    'Every step forward matters! 👣',
    'Your determination is inspiring! 🚀',
    'Success is within reach! 🎯',
    'Keep pushing, you\'ve got this! 💪',
  ];
  
  static const List<String> achievementMotivational = [
    'You\'re absolutely crushing it! 🏆',
    'This is just the beginning! 🌟',
    'Your hard work is paying off! 💎',
    'You\'re unstoppable! 🚀',
    'Excellence is your standard! ⭐',
  ];
  
  // Notification Actions
  static const String startPomodoroAction = 'START_POMODORO';
  static const String skipBreakAction = 'SKIP_BREAK';
  static const String markHabitDoneAction = 'MARK_HABIT_DONE';
  static const String viewGoalAction = 'VIEW_GOAL';
  static const String logIncomeAction = 'LOG_INCOME';
  static const String viewAchievementAction = 'VIEW_ACHIEVEMENT';
  
  // Notification Payloads
  static const String pomodoroPayload = 'pomodoro';
  static const String habitPayloadPrefix = 'habit_';
  static const String goalPayloadPrefix = 'goal_';
  static const String achievementPayloadPrefix = 'achievement_';
  static const String incomePayload = 'income';
  
  // Default Settings
  static const bool defaultPomodoroNotifications = true;
  static const bool defaultHabitNotifications = true;
  static const bool defaultGoalNotifications = true;
  static const bool defaultAchievementNotifications = true;
  static const bool defaultIncomeNotifications = true;
  
  // Reminder Times
  static const List<String> defaultHabitReminderTimes = [
    '08:00', '12:00', '18:00', '20:00'
  ];
  
  static const List<String> incomeReminderTimes = [
    '09:00', '17:00', '21:00'
  ];
  
  // Sound Files
  static const String pomodoroSound = 'sounds/pomodoro_complete.mp3';
  static const String achievementSound = 'sounds/achievement_unlock.mp3';
  static const String habitSound = 'sounds/habit_reminder.mp3';
  static const String goalSound = 'sounds/goal_reminder.mp3';
}