import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<ParkEnum?> showParkSelectionOverlay({
  required BuildContext context,
  required bool showCloseButton,
  ParkEnum? selectedPark,
}) {
  return showDialog<ParkEnum>(
    context: context,
    barrierDismissible: showCloseButton,
    builder: (ctx) {
      final theme = Theme.of(ctx);
      final l10n = AppLocalizations.of(ctx)!;

      return PopScope(
        canPop: showCloseButton,
        child: Dialog.fullscreen(
          child: Scaffold(
            backgroundColor: theme.colorScheme.surface,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(l10n.parkSelectionTitle),
              actions: [
                if (showCloseButton)
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: MaterialLocalizations.of(ctx).closeButtonTooltip,
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: Text(l10n.parkSelectionSubtitle, style: theme.textTheme.bodyMedium),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: ParkEnum.values.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final park = ParkEnum.values[index];
                      final isSelected = selectedPark == park;
                      final primaryColor = Color(park.primaryColor);

                      return InkWell(
                        onTap: () => Navigator.of(ctx).pop(park),
                        borderRadius: BorderRadius.circular(16),
                        child: Ink(
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? theme.colorScheme.primary.withOpacity(0.08)
                                    : theme.colorScheme.surfaceVariant.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                            ),
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: 100,

                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SvgPicture.asset(park.assetPath, width: 100, height: 40),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      park.name,
                                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      park.city,
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                isSelected ? Icons.check_circle : Icons.chevron_right,
                                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
