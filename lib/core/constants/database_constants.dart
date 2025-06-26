// core/constants/database_constants.dart
class DatabaseConstants {
  // Collections
  static const String usersCollection = 'users';
  static const String timeTrackingCollection = 'time_tracking';
  static const String incomeTrackingCollection = 'income_tracking';
  static const String goalsCollection = 'goals';
  static const String achievementsCollection = 'achievements';
  static const String habitsCollection = 'habits';
  static const String settingsCollection = 'settings';
  
  // User Fields
  static const String userIdField = 'user_id';
  static const String userNameField = 'name';
  static const String userEmailField = 'email';
  static const String userCreatedAtField = 'created_at';
  static const String userUpdatedAtField = 'updated_at';
  static const String userAvatarField = 'avatar_url';
  static const String userTimezoneField = 'timezone';
  static const String userCurrencyField = 'currency';
  
  // Time Tracking Fields
  static const String timeIdField = 'time_id';
  static const String taskNameField = 'task_name';
  static const String taskDescriptionField = 'task_description';
  static const String categoryField = 'category';
  static const String startTimeField = 'start_time';
  static const String endTimeField = 'end_time';
  static const String durationField = 'duration';
  static const String isCompletedField = 'is_completed';
  static const String productivityScoreField = 'productivity_score';
  static const String tagsField = 'tags';
  
  // Income Tracking Fields
  static const String incomeIdField = 'income_id';
  static const String incomeSourceField = 'source';
  static const String incomeAmountField = 'amount';
  static const String incomeDateField = 'date';
  static const String incomeTypeField = 'type'; // active, passive, investment
  static const String incomeNotesField = 'notes';
  static const String incomeRecurringField = 'is_recurring';
  
  // Goals Fields
  static const String goalIdField = 'goal_id';
  static const String goalTitleField = 'title';
  static const String goalDescriptionField = 'description';
  static const String goalTypeField = 'type'; // time, income, habit
  static const String goalTargetField = 'target';
  static const String goalCurrentField = 'current';
  static const String goalDeadlineField = 'deadline';
  static const String goalPriorityField = 'priority';
  static const String goalStatusField = 'status';
  
  // Achievements Fields
  static const String achievementIdField = 'achievement_id';
  static const String achievementTitleField = 'title';
  static const String achievementDescriptionField = 'description';
  static const String achievementIconField = 'icon';
  static const String achievementUnlockedAtField = 'unlocked_at';
  static const String achievementTypeField = 'type';
  static const String achievementRequirementField = 'requirement';
  
  // Habits Fields
  static const String habitIdField = 'habit_id';
  static const String habitNameField = 'name';
  static const String habitDescriptionField = 'description';
  static const String habitFrequencyField = 'frequency';
  static const String habitStreakField = 'streak';
  static const String habitCompletedDatesField = 'completed_dates';
  static const String habitReminderTimeField = 'reminder_time';
  
  // Settings Fields
  static const String settingKeyField = 'key';
  static const String settingValueField = 'value';
  static const String settingTypeField = 'type';
  
  // Common Fields
  static const String createdAtField = 'created_at';
  static const String updatedAtField = 'updated_at';
  static const String isActiveField = 'is_active';
  static const String sortOrderField = 'sort_order';
  
  // Indexes for Firestore
  static const List<Map<String, dynamic>> firestoreIndexes = [
    {
      'collection': timeTrackingCollection,
      'fields': [userIdField, startTimeField],
      'order': 'desc'
    },
    {
      'collection': incomeTrackingCollection,
      'fields': [userIdField, incomeDateField],
      'order': 'desc'
    },
    {
      'collection': goalsCollection,
      'fields': [userIdField, goalStatusField, goalDeadlineField]
    },
    {
      'collection': habitsCollection,
      'fields': [userIdField, isActiveField]
    }
  ];
  
  // Query Limits
  static const int defaultQueryLimit = 50;
  static const int maxQueryLimit = 100;
  static const int recentItemsLimit = 10;
  
  // Cache Keys
  static const String userDataCacheKey = 'user_data';
  static const String recentTimeTrackingCacheKey = 'recent_time_tracking';
  static const String recentIncomeCacheKey = 'recent_income';
  static const String goalsCacheKey = 'goals';
  static const String achievementsCacheKey = 'achievements';
  
  // Error Messages
  static const String networkErrorMessage = 'Network connection failed';
  static const String authErrorMessage = 'Authentication failed';
  static const String permissionErrorMessage = 'Permission denied';
  static const String dataNotFoundMessage = 'Data not found';
  static const String savingErrorMessage = 'Failed to save data';
  static const String loadingErrorMessage = 'Failed to load data';
}