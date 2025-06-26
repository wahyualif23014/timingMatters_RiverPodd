// core/constants/app_constants.dart
import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Timing Matters';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Manage your time and money to build wealth mindset';
  
  // Colors - Energizing and Motivating Theme
  static const Color primaryColor = Color(0xFF6366F1); // Indigo
  static const Color secondaryColor = Color(0xFF8B5CF6); // Purple
  static const Color accentColor = Color(0xFF06B6D4); // Cyan
  static const Color successColor = Color(0xFF10B981); // Emerald
  static const Color warningColor = Color(0xFFF59E0B); // Amber
  static const Color errorColor = Color(0xFFEF4444); // Red
  
  // Glassmorphism Colors
  static const Color glassBackground = Color(0x1AFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);
  static const Color darkGlassBackground = Color(0x1A000000);
  static const Color darkGlassBorder = Color(0x33000000);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient successGradient = LinearGradient(
    colors: [successColor, accentColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [
      Color(0xFF0F172A), // Dark slate
      Color(0xFF1E293B), // Slate
      Color(0xFF334155), // Light slate
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  // Text Styles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  
  static const TextStyle headingMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  
  static const TextStyle headingSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.white60,
  );
  
  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  
  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  
  // Animation Duration
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  // Wealth Mindset Quotes
  static const List<String> motivationalQuotes = [
    "Time is money, invest it wisely",
    "Every minute counts towards your financial freedom",
    "Consistency builds wealth, one day at a time",
    "Track your time, track your money, track your success",
    "Small actions, big results",
    "Your future self will thank you for today's discipline",
    "Time management is money management",
    "Success is the sum of small efforts repeated daily",
  ];
  
  // Achievement Levels
  static const Map<String, int> achievementLevels = {
    'beginner': 7,      // 1 week
    'intermediate': 30,  // 1 month
    'advanced': 90,     // 3 months
    'expert': 365,      // 1 year
    'master': 1000,     // 1000 days
  };
  
  // Default Settings
  static const int defaultPomodoroMinutes = 25;
  static const int defaultBreakMinutes = 5;
  static const int defaultLongBreakMinutes = 15;
  static const String defaultCurrency = 'IDR';
  static const String defaultTimezone = 'Asia/Jakarta';
}