// ignore_for_file: constant_identifier_names
import 'package:myFevTempV1/domain/use_cases/extrta_methods.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class AppColor {
  // --- Brand Colors (Tailwind-inspired Slate & Blue) ---
  static const Color brandPrimary = Color(0xFF1A73E8);
  static const Color primaryColor = Color(
    0xFF7C41ED,
  ); // Your original primaryColor

  // --- Attendance / Semantic Status Colors ---
  // These are kept as static constants for use in your UI logic
  static Color get presentColor => Colors.green.shade400;
  static Color get absentColor => Colors.red.shade400;
  static Color get leaveColor => Colors.brown.shade300;
  static Color get holidayColor => Colors.amber.shade400;
  static Color get vacationColor => Colors.indigo.shade300;
  static Color get todayColor => Colors.blue.shade300;

  static List<Color> myColorList = [
    presentColor,
    absentColor,
    leaveColor,
    holidayColor,
    vacationColor,
    todayColor,
  ];

  static List<Color> serviceColors = [
    Color(0xff3A82F6), // Bank & ATM's
    Color(0xffF97316), // Post Offices
    Color(0xff10B981), // Hospitals & Clinics
    Color(0xffF59E0C), // Gas Agencies
    Color(0xff05B6D4), // Mobile Operators
    Color(0xffF43F5E), // Mandirs & Temples
    Color(0xff6366F1), // Govt. Offices
    Color(0xffA855F7), // Shopping Centres
  ];

  // --- Tab Indicator Styling ---
  static MaterialIndicator tabIndicator = MaterialIndicator(
    tabPosition: TabPosition.bottom,
    height: 3,
    color: Colors.white,
  );

  // --- Light Theme Colors ---
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Colors.white;
  static const Color lightBorder = Color(0xFFE2E8F0); // slate-200
  static const Color textPrimaryLight = Color(0xFF1E293B); // slate-800
  static const Color textSecondaryLight = Color(0xFF64748B); // slate-500

  // --- Dark Theme Colors ---
  static const Color darkBackground = Color(0xFF0F172A); // slate-900
  static const Color darkSurface = Color(0xFF1E293B); // slate-800
  static const Color darkBorder = Color(0xFF334155); // slate-700
  static const Color textPrimaryDark = Color(0xFFF1F5F9); // slate-100
  static const Color textSecondaryDark = Color(0xFF94A3B8); // slate-400

  // --- Text Theme color ----
  static const Color subLabelLight = Color(0xFF94A3B8); // slate-400
  static const Color subLabelDark = Color(0xFF475569); // slate-600

  Map<int, Color> color = {
    50: const Color.fromRGBO(136, 14, 79, .1),
    100: const Color.fromRGBO(136, 14, 79, .2),
    200: const Color.fromRGBO(136, 14, 79, .3),
    300: const Color.fromRGBO(136, 14, 79, .4),
    400: const Color.fromRGBO(136, 14, 79, .5),
    500: const Color.fromRGBO(136, 14, 79, .6),
    600: const Color.fromRGBO(136, 14, 79, .7),
    700: const Color.fromRGBO(136, 14, 79, .8),
    800: const Color.fromRGBO(136, 14, 79, .9),
    900: const Color.fromRGBO(136, 14, 79, 1),
  };

  MaterialColor get primaryMaterialColor => MaterialColor(0xFF37CC7A, color);
}

extension AppThemeExtension on BuildContext {
  bool get _dark => Theme.of(this).brightness == Brightness.dark;

  // Text Color --
  Color get textPrimaryColor =>
      _dark ? AppColor.textPrimaryDark : AppColor.textPrimaryLight;
  Color get textSecondaryColor => _dark
      ? AppColor.textSecondaryDark
      : AppColor.textSecondaryLight.lighten(0.03);
  Color get textLabelolor =>
      _dark ? AppColor.subLabelDark : AppColor.subLabelLight;

  // widget color --
  Color get backgroundColor =>
      _dark ? AppColor.darkBackground : AppColor.lightBackground;
  Color get lightCardColor =>
      _dark ? AppColor.darkSurface : AppColor.lightBorder.lighten(0.03);
}
