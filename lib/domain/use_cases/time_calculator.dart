class TimeCalculator {
  DateTime futureDateTime;

  TimeCalculator(this.futureDateTime);

  String get isRemainTime {
    final now = DateTime.now();
    final difference = futureDateTime.difference(now);

    if (difference.isNegative) {
      return "Time has passed";
    }

    final totalMinutes = difference.inMinutes;
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return "$hours hour${hours > 1 ? 's' : ''} $minutes minute${minutes > 1 ? 's' : ''} remain";
    } else if (hours > 0) {
      return "$hours hour${hours > 1 ? 's' : ''} remain";
    } else if (minutes > 0) {
      return "$minutes minute${minutes > 1 ? 's' : ''} remain";
    } else {
      return "Less than a minute remain";
    }
  }
}

// Or as a standalone function:
String getRemainTime(DateTime futureDateTime) {
  final now = DateTime.now();
  final difference = futureDateTime.difference(now);

  if (difference.isNegative) {
    return "Time has passed";
  }

  final totalMinutes = difference.inMinutes;
  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;

  if (hours > 0 && minutes > 0) {
    return "$hours hour${hours > 1 ? 's' : ''} $minutes minute${minutes > 1 ? 's' : ''} remain";
  } else if (hours > 0) {
    return "$hours hour${hours > 1 ? 's' : ''} remain";
  } else if (minutes > 0) {
    return "$minutes minute${minutes > 1 ? 's' : ''} remain";
  } else {
    return "Less than a minute remain";
  }
}
