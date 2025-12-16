import 'package:flutter/material.dart';

class TabContent extends StatelessWidget {
  const TabContent({super.key, required this.title, required this.description, required this.icon});

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 64, color: theme.colorScheme.primary),
              const SizedBox(height: 16),
              Text(title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(description, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
