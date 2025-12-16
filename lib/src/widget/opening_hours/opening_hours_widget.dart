import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:city_park_app/src/widget/opening_hours/opening_hours_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OpeningHoursWidget extends ConsumerWidget {
  const OpeningHoursWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final viewModelAsync = ref.watch(openingHoursViewModelProvider);

    return viewModelAsync.when(
      data: (vm) {
        final statusText = _buildStatusText(vm, l10n, locale);

        return Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (statusText != null) ...[
                Center(child: Text(statusText, style: Theme.of(context).textTheme.titleMedium)),
                const SizedBox(height: 16),
              ],
              Center(
                child: InkWell(
                  onTap: () {
                    showBottomSheet(
                      context: context,
                      builder: (context) {
                        return Material(child: openingTimesOfNext7Days(vm, locale, l10n));
                      },
                    );
                  },
                  child: Text(l10n.openingHoursNext7Days, style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget openingTimesOfNext7Days(OpeningHoursViewModel vm, String locale, AppLocalizations l10n) {
    return Card(
      child: Column(
        children: [
          for (final day in vm.schedule)
            ListTile(
              title: Text(DateFormat('EEEE, dd.MM.', locale).format(day.day)),
              subtitle: Text(
                day.isClosed
                    ? l10n.openingHoursClosed
                    : '${_formatTime(day.open!, locale)} - ${_formatTime(day.close!, locale)}',
              ),
            ),
        ],
      ),
    );
  }
}

String? _buildStatusText(OpeningHoursViewModel vm, AppLocalizations l10n, String locale) {
  switch (vm.status) {
    case OpeningStatus.openNow:
      if (vm.minutesUntilChange == null || vm.targetTime == null) return null;
      return l10n.parkStatusClosing(vm.park.name, vm.minutesUntilChange!, _formatTime(vm.targetTime!, locale));
    case OpeningStatus.opensToday:
      if (vm.minutesUntilChange == null || vm.targetTime == null) return null;
      return l10n.parkStatusOpensToday(vm.park.name, vm.minutesUntilChange!, _formatTime(vm.targetTime!, locale));
    case OpeningStatus.opensFuture:
      if (vm.minutesUntilChange == null || vm.targetTime == null) return null;
      final when = _whenLabel(vm, l10n, locale);
      return l10n.parkStatusOpensFuture(vm.park.name, when, _formatTime(vm.targetTime!, locale));
    case OpeningStatus.closed:
      return null;
  }
}

String _whenLabel(OpeningHoursViewModel vm, AppLocalizations l10n, String locale) {
  if (vm.targetDay == null) return '';
  final now = DateTime.now();
  final baseDay = DateTime(now.year, now.month, now.day);
  final diff = vm.targetDay!.difference(baseDay).inDays;
  if (diff == 1) return l10n.whenTomorrow;
  if (diff == 2) return l10n.whenDayAfterTomorrow;
  final weekday = DateFormat('EEEE', locale).format(vm.targetDay!);
  final date = DateFormat('dd.MM.', locale).format(vm.targetDay!);
  return '$weekday, den $date';
}

String _formatTime(DateTime date, String locale) => DateFormat('HH:mm', locale).format(date);
