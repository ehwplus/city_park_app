import 'package:city_park_app/src/model/park/last_used_park_provider.dart';
import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreTab extends ConsumerWidget {
  const ExploreTab({super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final park = ref.watch(lastUsedParkProvider) ?? ParkEnum.essenGrugapark;
    final assetPath = 'assets/${park.assetFolder}/map.svg';
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(description, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 16),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 6,
                boundaryMargin: const EdgeInsets.all(32),
                child: SvgPicture.asset(
                  assetPath,
                  fit: BoxFit.contain,
                  placeholderBuilder: (_) => const Center(child: CircularProgressIndicator()),
                  alignment: Alignment.topLeft,
                  allowDrawingOutsideViewBox: true,
                  height: double.infinity,
                  width: double.infinity,
                  colorFilter: null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
