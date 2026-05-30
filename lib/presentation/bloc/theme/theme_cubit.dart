import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/local_db/local_storage.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  static const String _themeKey = 'app_theme_mode';

  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  // Load saved theme from Hive
  void _loadTheme() {
    try {
      final savedTheme = HiveLocalStorage.read(_themeKey);
      if (savedTheme != null) {
        if (savedTheme == 'dark') {
          emit(ThemeMode.dark);
        } else if (savedTheme == 'system') {
          emit(ThemeMode.system);
        } else {
          emit(ThemeMode.light);
        }
      }
    } catch (e) {
      // Fallback if not initialized yet or error
      emit(ThemeMode.light);
    }
  }

  // Toggle theme mode
  void toggleTheme() {
    final nextTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    updateTheme(nextTheme);
  }

  // Set specific theme mode
  void updateTheme(ThemeMode themeMode) {
    emit(themeMode);
    String themeValue = 'light';
    if (themeMode == ThemeMode.dark) {
      themeValue = 'dark';
    } else if (themeMode == ThemeMode.system) {
      themeValue = 'system';
    }
    HiveLocalStorage.write(_themeKey, themeValue);
  }
}
