// String extension methods
import 'package:flutter/material.dart';

extension StringExtensions on String {
  // Email validation
  bool get isValidEmail {
    if (isEmpty) return false;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  // Null or empty check
  bool get isNullOrEmpty {
    return trim().isEmpty;
  }

  bool get isNotNullOrEmpty {
    return !isNullOrEmpty;
  }

  // Phone number validation
  bool get isValidPhoneNumber {
    if (isEmpty) return false;

    final phoneRegex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
    return phoneRegex.hasMatch(this);
  }

  // URL validation
  bool get isValidUrl {
    if (isEmpty) return false;

    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );
    return urlRegex.hasMatch(this);
  }

  // Text transformation - Capitalize first letter of each word
  String get capitalizeWords {
    if (isEmpty) return '';

    return split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  // Capitalize first letter only
  String get capitalizeFirst {
    if (isEmpty) return '';

    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  // Get last 3 characters with dots
  String get lastThreeWithDots {
    if (isEmpty) return '';

    if (length <= 3) {
      return this;
    }

    return '...${substring(length - 3)}';
  }

  // Get first 3 characters with dots
  String get firstThreeWithDots {
    if (isEmpty) return '';

    if (length <= 3) {
      return this;
    }

    return '${substring(0, 3)}...';
  }

  // Get first and last characters with dots in middle
  String get firstLastWithDots {
    if (isEmpty) return '';

    const keepChars = 3;
    if (length <= keepChars * 2) {
      return this;
    }

    return '${substring(0, keepChars)}...${substring(length - keepChars)}';
  }

  // Remove all whitespace
  String get removeWhitespace {
    if (isEmpty) return '';

    return replaceAll(RegExp(r'\s+'), '');
  }

  // Keep only numbers
  String get keepOnlyNumbers {
    if (isEmpty) return '';

    return replaceAll(RegExp(r'[^0-9]'), '');
  }

  // Keep only letters
  String get keepOnlyLetters {
    if (isEmpty) return '';

    return replaceAll(RegExp(r'[^a-zA-Z]'), '');
  }

  // Check if string contains only numbers
  bool get isNumeric {
    if (isEmpty) return false;

    return double.tryParse(this) != null;
  }

  // Check if string contains only letters
  bool get isAlphabetic {
    if (isEmpty) return false;

    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }

  // Check if string is alphanumeric
  bool get isAlphanumeric {
    if (isEmpty) return false;

    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);
  }

  // Truncate text with ellipsis
  String truncateWithEllipsis(int maxLength) {
    if (isEmpty) return '';

    if (length <= maxLength) {
      return this;
    }

    return '${substring(0, maxLength)}...';
  }

  // Count words in text
  int get wordCount {
    if (isEmpty) return 0;

    return trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  // Reverse string
  String get reverse {
    if (isEmpty) return '';

    return split('').reversed.join();
  }

  // Check if text is palindrome
  bool get isPalindrome {
    if (isEmpty) return false;

    final cleanText = toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return cleanText == cleanText.reverse;
  }

  // Extract numbers from string
  String get extractNumbers {
    if (isEmpty) return '';

    final matches = RegExp(r'\d+').allMatches(this);
    return matches.map((match) => match.group(0)).join('');
  }

  // Mask email address
  String get maskEmail {
    if (!isValidEmail) return this;

    final parts = split('@');
    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) {
      return '${username[0]}***@$domain';
    }

    final maskedUsername = '${username.substring(0, 2)}***';
    return '$maskedUsername@$domain';
  }

  // Mask phone number
  String get maskPhoneNumber {
    if (isEmpty) return '';

    if (length <= 4) {
      return this;
    }

    final visibleDigits = 4;
    final maskedPart = '*' * (length - visibleDigits);
    final visiblePart = substring(length - visibleDigits);

    return '$maskedPart$visiblePart';
  }

  // Validate credit card number (Luhn algorithm)
  bool get isValidCreditCard {
    if (isEmpty) return false;

    final cleanNumber = keepOnlyNumbers;

    if (cleanNumber.length < 13 || cleanNumber.length > 19) {
      return false;
    }

    int sum = 0;
    bool isEven = false;

    for (int i = cleanNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cleanNumber[i]);

      if (isEven) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }

      sum += digit;
      isEven = !isEven;
    }

    return sum % 10 == 0;
  }

  // Check if string is a valid date
  bool get isValidDate {
    if (isEmpty) return false;

    try {
      DateTime.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Calculate age from birthdate
  int get calculateAge {
    if (!isValidDate) return 0;

    final birth = DateTime.parse(this);
    final now = DateTime.now();

    int age = now.year - birth.year;

    if (now.month < birth.month ||
        (now.month == birth.month && now.day < birth.day)) {
      age--;
    }

    return age;
  }

  // Generate initials from name
  String get initials {
    if (isEmpty) return '';

    final words = trim().split(RegExp(r'\s+'));

    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }

    return '${words[0][0]}${words[words.length - 1][0]}'.toUpperCase();
  }

  // Check if text contains only uppercase
  bool get isUpperCase {
    if (isEmpty) return false;

    return this == toUpperCase();
  }

  // Check if text contains only lowercase
  bool get isLowerCase {
    if (isEmpty) return false;

    return this == toLowerCase();
  }

  // Remove special characters
  String get removeSpecialCharacters {
    if (isEmpty) return '';

    return replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
  }

  // Add commas to large numbers
  String get formatNumberWithCommas {
    if (isEmpty || !isNumeric) return this;

    final number = int.tryParse(this);
    if (number == null) return this;

    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  // Validate username (alphanumeric with underscores, 3-20 characters)
  bool get isValidUsername {
    if (isEmpty) return false;

    if (length < 3 || length > 20) {
      return false;
    }

    return RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(this);
  }

  // Password validation with detailed error message
  String? get passwordValidation {
    if (isEmpty) {
      return 'Password cannot be empty';
    }

    if (length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  // Simple password validation (just returns bool)
  bool get isValidPassword {
    return passwordValidation == null;
  }

  // Check if string is a valid integer
  bool get isInteger {
    if (isEmpty) return false;

    return int.tryParse(this) != null;
  }

  // Check if string is a valid double
  bool get isDouble {
    if (isEmpty) return false;

    return double.tryParse(this) != null;
  }

  // Convert to title case (First Letter Of Each Word Capital)
  String get toTitleCase {
    if (isEmpty) return '';

    return split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  // Get file extension from string
  String get fileExtension {
    if (isEmpty) return '';

    final parts = split('.');
    return parts.length > 1 ? parts.last : '';
  }

  // Check if string is a valid file name
  bool get isValidFileName {
    if (isEmpty) return false;

    final invalidChars = RegExp(r'[<>:"/\\|?*]');
    return !invalidChars.hasMatch(this);
  }

  // Check if string contains only whitespace
  bool get isWhitespace {
    return trim().isEmpty;
  }

  // Check if string is a valid hexadecimal color code
  bool get isValidHexColor {
    if (isEmpty) return false;

    final hexColor = startsWith('#') ? substring(1) : this;
    return RegExp(r'^[0-9A-Fa-f]{6}$').hasMatch(hexColor) ||
        RegExp(r'^[0-9A-Fa-f]{8}$').hasMatch(hexColor);
  }
}

// Nullable String extension methods
extension NullableStringExtensions on String? {
  // Enhanced null or empty check
  bool get isNullOrEmpty {
    return this == null || this!.trim().isEmpty;
  }

  bool get isNotNullOrEmpty {
    return !isNullOrEmpty;
  }

  // Safe version of various validations that handle null
  bool get isValidEmail {
    if (isNullOrEmpty) return false;
    return this!.isValidEmail;
  }

  bool get isValidPhoneNumber {
    if (isNullOrEmpty) return false;
    return this!.isValidPhoneNumber;
  }

  String get orEmpty {
    return this ?? '';
  }

  String get capitalizeFirst {
    if (isNullOrEmpty) return '';
    return this!.capitalizeFirst;
  }

  String get capitalizeWords {
    if (isNullOrEmpty) return '';
    return this!.capitalizeWords;
  }

  // Safe validation with default value
  bool isValidEmailOr(bool defaultValue) {
    if (isNullOrEmpty) return defaultValue;
    return this!.isValidEmail;
  }
}

// Boolean extension methods
extension BooleanExtensions on bool {
  // Convert bool to string
  String get toStringYesNo {
    return this ? 'Yes' : 'No';
  }

  String get toStringTrueFalse {
    return this ? 'True' : 'False';
  }

  String get toStringEnabledDisabled {
    return this ? 'Enabled' : 'Disabled';
  }

  String get toStringActiveInactive {
    return this ? 'Active' : 'Inactive';
  }

  // Toggle boolean value
  bool get toggle {
    return !this;
  }

  // Convert to integer (1 for true, 0 for false)
  int get toInt {
    return this ? 1 : 0;
  }

  // Execute function based on boolean value
  void ifTrue(Function() action) {
    if (this) {
      action();
    }
  }

  void ifFalse(Function() action) {
    if (!this) {
      action();
    }
  }

  // Return value based on boolean
  T map<T>({required T trueValue, required T falseValue}) {
    return this ? trueValue : falseValue;
  }
}

// Nullable Boolean extension methods
extension NullableBooleanExtensions on bool? {
  // Safe boolean operations with default values
  bool get orFalse {
    return this ?? false;
  }

  bool get orTrue {
    return this ?? true;
  }

  String get toStringYesNo {
    return (this ?? false) ? 'Yes' : 'No';
  }

  bool get isTrue {
    return this == true;
  }

  bool get isFalse {
    return this == false;
  }

  bool get isNull {
    return this == null;
  }
}

extension ColorExtensions on Color {
  // Darken color
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  // Lighten color
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );

    return hslLight.toColor();
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
