// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import '../constant/app_color.dart';

class AppThemes {
  // --- Light Theme Definition ---
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.lightBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.brandPrimary,
      primary: AppColor.brandPrimary,
      onPrimary: Colors.white,
      surface: AppColor.lightSurface,
      brightness: Brightness.light,
    ),

    // Header styling
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.lightSurface,
      foregroundColor: AppColor.textPrimaryLight,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: AppColor.textPrimaryLight,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Card styling "rounded-2xl border border-slate-200"
    cardTheme: CardThemeData(
      color: AppColor.lightSurface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColor.lightBorder, width: 1),
      ),
    ),

    // Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.lightSurface,
      selectedItemColor: AppColor.brandPrimary,
      unselectedItemColor: Color(0xFF94A3B8), // Slate 400
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Typography
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.bold,
        color: AppColor.textPrimaryDark,
        letterSpacing: -0.3,
        height: 1.2,
      ),
      // Title
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColor.textPrimaryDark,
        letterSpacing: -0.2,
        height: 1.3,
      ),
      // Subtitle
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: AppColor.textSecondaryDark,
        letterSpacing: 0,
        height: 1.4,
      ),
      // Label
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColor.textPrimaryDark,
        letterSpacing: 0,
        height: 1.4,
      ),
      // SubLabel
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColor.subLabelDark,
        letterSpacing: 0.1,
        height: 1.5,
      ),
    ),
  );

  // --- Dark Theme Definition ---
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.darkBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.brandPrimary,
      brightness: Brightness.dark,
      surface: AppColor.darkSurface,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.darkSurface,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),

    cardTheme: CardThemeData(
      color: AppColor.darkSurface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColor.darkBorder, width: 1),
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColor.darkSurface,
      selectedItemColor: Color(0xFF60A5FA), // Soft blue for dark mode
      unselectedItemColor: Color(0xFF64748B),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 27,
        fontWeight: FontWeight.bold,
        color: AppColor.textPrimaryLight,
        letterSpacing: -0.3,
        height: 1.2,
      ),
      // Title
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColor.textPrimaryLight,
        letterSpacing: -0.2,
        height: 1.3,
      ),
      // Subtitle
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        color: AppColor.textSecondaryLight,
        letterSpacing: 0,
        height: 1.4,
      ),
      // Label
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColor.textPrimaryLight,
        letterSpacing: 0,
        height: 1.4,
      ),
      // SubLabel
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColor.subLabelLight,
        letterSpacing: 0.1,
        height: 1.5,
      ),
    ),
  );
}
