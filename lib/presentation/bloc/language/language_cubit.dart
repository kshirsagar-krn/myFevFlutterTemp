import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/local_db/local_storage.dart';

class LanguageCubit extends Cubit<Locale> {
  static const String _languageKey = 'app_language_code';

  LanguageCubit() : super(const Locale('en', '')) {
    _loadLanguage();
  }

  // Load language preference from Hive
  void _loadLanguage() {
    try {
      final savedLanguage = HiveLocalStorage.read(_languageKey);
      if (savedLanguage != null && savedLanguage is String) {
        emit(Locale(savedLanguage, ''));
      } else {
        emit(const Locale('en', ''));
      }
    } catch (e) {
      // Default to English if Hive isn't initialized or error occurs
      emit(const Locale('en', ''));
    }
  }

  // Change selected language and persist it
  void changeLanguage(String languageCode) {
    emit(Locale(languageCode, ''));
    HiveLocalStorage.write(_languageKey, languageCode);
  }
}
