import 'package:city_park_app/src/model/opening_hours/date.dart';

class OpeningHours {
  const OpeningHours({
    required this.season,
    required this.openingTimeTypes,
    this.specifier,
    this.note,
    required this.openingTime,
  });

  final Season season;
  final Set<OpeningTimeType> openingTimeTypes;
  final String? specifier;
  final String? note;
  final TimeRange? openingTime;
}

class Season {
  const Season({required this.start, required this.end});

  final Date start;
  final Date end;

  DateTime startDate({DateTime? reference}) => start.resolve(reference: reference);

  DateTime endDate({DateTime? reference}) {
    final referenceDate = reference ?? DateTime.now();
    final resolvedStart = startDate(reference: referenceDate);
    final resolvedEnd = end.resolve(reference: resolvedStart);

    // Keep the end date after the start date when the year is inferred.
    if (end.year == null && resolvedEnd.isBefore(resolvedStart)) {
      return DateTime(resolvedEnd.year + 1, resolvedEnd.month, resolvedEnd.day);
    }

    return resolvedEnd;
  }
}

class TimeRange {
  const TimeRange({
    required this.startHour,
    this.startMinute = 0,
    required this.endHour,
    this.endMinute = 0,
    this.weekdays = const [
      DateTime.monday,
      DateTime.tuesday,
      DateTime.wednesday,
      DateTime.thursday,
      DateTime.friday,
      DateTime.saturday,
      DateTime.sunday,
    ],
  });

  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;
  final List<int> weekdays;

  String formatTime(int hour, int minute) => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  String get formattedStart => formatTime(startHour, startMinute);
  String get formattedEnd => formatTime(endHour, endMinute);

  DateTime get start {
    assert(weekdays.isNotEmpty, 'Weekdays must not be empty');
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    DateTime result = DateTime(today.year, today.month, today.day, startHour, startMinute);
    if (result.isBefore(today)) {
      result = DateTime(today.year, today.month, today.day + 1, startHour, startMinute);
      while (!weekdays.contains(result.weekday)) {
        result = DateTime(today.year, today.month, today.day + 1, startHour, startMinute);
      }
    }
    return result;
  }

  DateTime get end {
    assert(weekdays.isNotEmpty, 'Weekdays must not be empty');
    final now = DateTime.now();
    DateTime result = DateTime(now.year, now.month, now.day, endHour, endMinute);
    if (result.isBefore(now)) {
      result = DateTime(now.year, now.month, now.day + 1, endHour, endMinute);
      while (!weekdays.contains(result.weekday)) {
        result = DateTime(now.year, now.month, now.day + 1, endHour, endMinute);
      }
    }
    return result;
  }
}

enum OpeningTimeType { dailyTicket, annualPass, ticketOffice, other }
