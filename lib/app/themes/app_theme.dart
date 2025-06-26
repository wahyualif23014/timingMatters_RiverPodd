import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';
import 'text_styles.dart';




class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.lightColorScheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTextStyles.h2.copyWith(
          color: AppColors.lightOnBackground,
        ),
        iconTheme: IconThemeData(
          color: AppColors.lightOnBackground,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        color: AppColors.lightSurface.withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.lightSurface.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurface.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.lightSurface.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.lightSurface.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: AppTextStyles.body2.copyWith(
          color: AppColors.lightOnBackground.withOpacity(0.6),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface.withOpacity(0.9),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightOnBackground.withOpacity(0.6),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTextStyles.caption.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.caption,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1,
        displayMedium: AppTextStyles.h2,
        displaySmall: AppTextStyles.h3,
        headlineMedium: AppTextStyles.h4,
        bodyLarge: AppTextStyles.body1,
        bodyMedium: AppTextStyles.body2,
        titleMedium: AppTextStyles.subtitle1,
        titleSmall: AppTextStyles.subtitle2,
        labelLarge: AppTextStyles.button,
        labelSmall: AppTextStyles.caption,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.darkColorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTextStyles.h2.copyWith(
          color: AppColors.darkOnBackground,
        ),
        iconTheme: IconThemeData(
          color: AppColors.darkOnBackground,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        color: AppColors.darkSurface.withOpacity(0.7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.darkSurface.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkSurface.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.darkSurface.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.darkSurface.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primaryLight,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: AppTextStyles.body2.copyWith(
          color: AppColors.darkOnBackground.withOpacity(0.6),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface.withOpacity(0.9),
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.darkOnBackground.withOpacity(0.6),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: AppTextStyles.caption.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: AppTextStyles.caption,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1.copyWith(color: AppColors.darkOnBackground),
        displayMedium: AppTextStyles.h2.copyWith(color: AppColors.darkOnBackground),
        displaySmall: AppTextStyles.h3.copyWith(color: AppColors.darkOnBackground),
        headlineMedium: AppTextStyles.h4.copyWith(color: AppColors.darkOnBackground),
        bodyLarge: AppTextStyles.body1.copyWith(color: AppColors.darkOnBackground),
        bodyMedium: AppTextStyles.body2.copyWith(color: AppColors.darkOnBackground),
        titleMedium: AppTextStyles.subtitle1.copyWith(color: AppColors.darkOnBackground),
        titleSmall: AppTextStyles.subtitle2.copyWith(color: AppColors.darkOnBackground),
        labelLarge: AppTextStyles.button,
        labelSmall: AppTextStyles.caption.copyWith(color: AppColors.darkOnBackground),
      ),
    );
  }
}