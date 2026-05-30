import 'package:intl/intl.dart';

class DateFormatter {
  // Format to: 2023-12-25
  static String formatYYYYMMDD(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Format to: 25 Dec, 2023
  static String formatDDMMMYYYY(DateTime date) {
    return DateFormat('dd MMM, yyyy').format(date);
  }

  // Format to: December 25, 2023
  static String formatFullDate(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  // Format to: 12/25/2023
  static String formatMMDDYYYY(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }

  // Format to: Monday, December 25, 2023
  static String formatFullDayDate(DateTime date) {
    return DateFormat('EEEE, MMMM dd, yyyy').format(date);
  }

  // Format to: 2023-12-25 14:30:45
  static String formatDateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  // Format to: 02:30 PM
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  // Format to: Dec 25, 2023 2:30 PM
  static String formatDateTimeCompact(DateTime date) {
    return DateFormat('MMM dd, yyyy hh:mm a').format(date);
  }

  // Format with custom pattern
  static String formatCustom(DateTime date, String pattern) {
    return DateFormat(pattern).format(date);
  }

  // Parse string to DateTime
  static DateTime? parse(String dateString, String pattern) {
    try {
      return DateFormat(pattern).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  // Format relative time (e.g., "2 hours ago", "Yesterday")
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes < 1) return 'Just now';
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      }
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    }
    return formatDDMMMYYYY(date);
  }
}
