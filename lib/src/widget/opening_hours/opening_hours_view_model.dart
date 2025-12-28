import 'package:city_park_app/src/model/opening_hours/opening_hours.dart';
import 'package:city_park_app/src/model/opening_hours/opening_hours_provider.dart';
import 'package:city_park_app/src/model/park/last_used_park_provider.dart';
import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum OpeningStatus { openNow, opensToday, opensFuture, closed }

class DaySchedule {
  DaySchedule({required this.day, this.open, this.close});

  final DateTime day;
  final DateTime? open;
  final DateTime? close;

  bool get isClosed => open == null || close == null;
}

class OpeningHoursViewModel {
  OpeningHoursViewModel({
    required this.park,
    required this.status,
    required this.minutesUntilChange,
    required this.targetTime,
    required this.targetDay,
    required this.schedule,
  });

  final ParkEnum park;
  final OpeningStatus status;
  final int? minutesUntilChange;
  final DateTime? targetTime;
  final DateTime? targetDay;
  final List<DaySchedule> schedule;
}

OpeningHoursViewModel _buildViewModel({
  required ParkEnum park,
  required List<OpeningHours> openings,
  required DateTime now,
}) {
  final today = DateTime(now.year, now.month, now.day);
  final todayWindow = _openingWindowForDay(openings, today);

  OpeningStatus status = OpeningStatus.closed;
  int? minutes;
  DateTime? targetTime;
  DateTime? targetDay;

  if (todayWindow != null) {
    if (now.isAfter(todayWindow.start) && now.isBefore(todayWindow.end)) {
      status = OpeningStatus.openNow;
      minutes = todayWindow.end.difference(now).inMinutes;
      targetTime = todayWindow.end;
    } else if (now.isBefore(todayWindow.start)) {
      status = OpeningStatus.opensToday;
      minutes = todayWindow.start.difference(now).inMinutes;
      targetTime = todayWindow.start;
      targetDay = today;
    }
  }

  if (status == OpeningStatus.closed || status == OpeningStatus.opensToday && targetTime == null) {
    for (var i = 1; i <= 14; i++) {
      final day = today.add(Duration(days: i));
      final window = _openingWindowForDay(openings, day);
      if (window != null) {
        status = OpeningStatus.opensFuture;
        minutes = window.start.difference(now).inMinutes;
        targetTime = window.start;
        targetDay = day;
        break;
      }
    }
  }

  final schedule = List<DaySchedule>.generate(7, (index) {
    final day = today.add(Duration(days: index));
    final window = _openingWindowForDay(openings, day);
    return DaySchedule(day: day, open: window?.start, close: window?.end);
  });

  return OpeningHoursViewModel(
    park: park,
    status: status,
    minutesUntilChange: minutes,
    targetTime: targetTime,
    targetDay: targetDay,
    schedule: schedule,
  );
}

class _OpeningWindow {
  _OpeningWindow({required this.start, required this.end});
  final DateTime start;
  final DateTime end;
}

_OpeningWindow? _openingWindowForDay(List<OpeningHours> openings, DateTime day) {
  DateTime? startTime;
  DateTime? endTime;

  for (final openingHours in openings) {
    if (openingHours.openingTimeType != OpeningTimeType.annualPass) continue;
    final range = openingHours.openingTime;
    if (range == null) continue;

    if (!range.weekdays.contains(day.weekday)) continue;

    // Use TimeRange.start/end but normalise to the requested day.
    final baseStart = range.start;
    final baseEnd = range.end;
    final start = DateTime(day.year, day.month, day.day, baseStart.hour, baseStart.minute);
    final end = DateTime(day.year, day.month, day.day, baseEnd.hour, baseEnd.minute);

    startTime = startTime == null || start.isBefore(startTime) ? start : startTime;
    endTime = endTime == null || end.isAfter(endTime) ? end : endTime;
  }

  if (startTime == null || endTime == null) return null;
  return _OpeningWindow(start: startTime, end: endTime);
}

/// Provides an opening hours view model that updates every minute.
final openingHoursViewModelProvider = StreamProvider<OpeningHoursViewModel>((ref) {
  final openings = ref.watch(openingHoursProvider);
  final park = ref.watch(lastUsedParkProvider) ?? ParkEnum.essenGrugapark;

  Stream<OpeningHoursViewModel> stream() async* {
    yield _buildViewModel(park: park, openings: openings, now: DateTime.now());
    yield* Stream<OpeningHoursViewModel>.periodic(
      const Duration(minutes: 1),
      (_) => _buildViewModel(park: park, openings: openings, now: DateTime.now()),
    );
  }

  return stream();
});
