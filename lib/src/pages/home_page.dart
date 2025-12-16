import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:city_park_app/src/model/ticket/ticket_store_provider.dart';
import 'package:city_park_app/src/pages/settings_page.dart';
import 'package:city_park_app/src/pages/ticket_management_page.dart';
import 'package:city_park_app/src/widget/opening_hours/opening_hours_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tabs = [
      _TabContent(title: l10n.tabArrival, description: l10n.tabArrivalDescription, icon: Icons.directions),
      _TicketsTabContent(
        title: l10n.tabTickets,
        description: l10n.tabTicketsDescription,
        buttonLabel: l10n.ticketsAddSeasonPassButton,
        questionText: l10n.ticketsSeasonPassQuestion,
        ticketsAvailableText: l10n.ticketsAvailableInfo,
        onAddPressed: () => Navigator.of(context).pushNamed(TicketManagementPage.routeName),
      ),
      _TabContent(title: l10n.tabMap, description: l10n.tabMapDescription, icon: Icons.map),
      _TabContent(title: l10n.tabEvents, description: l10n.tabEventsDescription, icon: Icons.event),
    ];

    final tabTitles = [l10n.tabArrival, l10n.tabTickets, l10n.tabMap, l10n.tabEvents];

    return Scaffold(
      appBar: AppBar(
        title: Text(tabTitles[_currentIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed(SettingsPage.routeName),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.directions), label: l10n.tabArrival),
          BottomNavigationBarItem(icon: const Icon(Icons.confirmation_number), label: l10n.tabTickets),
          BottomNavigationBarItem(icon: const Icon(Icons.map), label: l10n.tabMap),
          BottomNavigationBarItem(icon: const Icon(Icons.event), label: l10n.tabEvents),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({required this.title, required this.description, required this.icon});

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

class _TicketsTabContent extends ConsumerWidget {
  const _TicketsTabContent({
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.questionText,
    required this.ticketsAvailableText,
    required this.onAddPressed,
  });

  final String title;
  final String description;
  final String buttonLabel;
  final String questionText;
  final String ticketsAvailableText;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickets = ref.watch(ticketStoreProvider);
    final hasTickets = tickets.isNotEmpty;

    final baseContent = _TabContent(title: title, description: description, icon: Icons.confirmation_number);

    return Column(
      children: [
        Expanded(child: baseContent),
        OpeningHoursWidget(),
        if (!hasTickets)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [
                Text(questionText, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                ElevatedButton(onPressed: onAddPressed, child: Text(buttonLabel)),
              ],
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(ticketsAvailableText, style: Theme.of(context).textTheme.titleMedium),
          ),
      ],
    );
  }
}
