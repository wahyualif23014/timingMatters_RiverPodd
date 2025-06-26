import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Energetic & Motivational
  static const Color primary = Color(0xFF6366F1); // Indigo - Focus & Determination
  static const Color primaryLight = Color(0xFF818CF8); // Light Indigo
  static const Color primaryDark = Color(0xFF4F46E5); // Dark Indigo
  
  // Secondary Colors - Success & Growth
  static const Color secondary = Color(0xFF10B981); // Emerald - Success & Money
  static const Color secondaryLight = Color(0xFF34D399); // Light Emerald
  static const Color secondaryDark = Color(0xFF059669); // Dark Emerald
  
  // Accent Colors - Energy & Motivation
  static const Color accent = Color(0xFFF59E0B); // Amber - Energy & Wealth
  static const Color accentLight = Color(0xFFFBBF24); // Light Amber
  static const Color accentDark = Color(0xFFD97706); // Dark Amber
  
  // Motivation Colors
  static const Color success = Color(0xFF22C55E); // Green - Achievement
  static const Color warning = Color(0xFFF97316); // Orange - Urgency
  static const Color error = Color(0xFFEF4444); // Red - Alert
  static const Color info = Color(0xFF3B82F6); // Blue - Information
  
  // Gradient Colors for Glassmorphism
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6366F1),
      Color(0xFF8B5CF6),
    ],
  );
  
  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF10B981),
      Color(0xFF059669),
    ],
  );
  
  static const LinearGradient wealthGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF59E0B),
      Color(0xFFEF4444),
    ],
  );
  
  static const LinearGradient motivationGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF8B5CF6),
      Color(0xFF06B6D4),
    ],
  );

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF8FAFC); // Very light gray
  static const Color lightSurface = Color(0xFFFFFFFF); // Pure white
  static const Color lightOnBackground = Color(0xFF1E293B); // Dark slate
  static const Color lightOnSurface = Color(0xFF334155); // Slate
  
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0F172A); // Very dark blue
  static const Color darkSurface = Color(0xFF1E293B); // Dark slate
  static const Color darkOnBackground = Color(0xFFF1F5F9); // Very light gray
  static const Color darkOnSurface = Color(0xFFCBD5E1); // Light gray
  
  // Glass Effects
  static Color glassLight = Colors.white.withOpacity(0.25);
  static Color glassDark = Colors.white.withOpacity(0.1);
  static Color glassBorder = Colors.white.withOpacity(0.2);
  
  // Color Schemes
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.white,
    error: error,
    onError: Colors.white,
    background: lightBackground,
    onBackground: lightOnBackground,
    surface: lightSurface,
    onSurface: lightOnSurface,
  );
  
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryLight,
    onPrimary: Colors.black,
    secondary: secondaryLight,
    onSecondary: Colors.black,
    error: error,
    onError: Colors.white,
    background: darkBackground,
    onBackground: darkOnBackground,
    surface: darkSurface,
    onSurface: darkOnSurface,
  );
  
  // Semantic Colors for Features
  static const Color timeTracking = Color(0xFF6366F1); // Indigo
  static const Color moneyTracking = Color(0xFF10B981); // Emerald
  static const Color habits = Color(0xFF8B5CF6); // Purple
  static const Color goals = Color(0xFFF59E0B); // Amber
  static const Color productivity = Color(0xFF06B6D4); // Cyan
}