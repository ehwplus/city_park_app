import 'package:city_park_app/src/feature_flags.dart';
import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:city_park_app/src/model/park/last_used_park_provider.dart';
import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:city_park_app/src/pages/settings_page.dart';
import 'package:city_park_app/src/pages/ticket_management_page.dart';
import 'package:city_park_app/src/widget/tabs/tab.dart';
import 'package:city_park_app/src/widget/tabs/tab_events.dart';
import 'package:city_park_app/src/widget/tabs/tab_map.dart';
import 'package:city_park_app/src/widget/tabs/tab_tickets.dart';
import 'package:fl_ui_config/fl_ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = FeatureFlags.tabArrivalEnabled ? 1 : 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tabs = [
      if (FeatureFlags.tabArrivalEnabled)
        TabContent(title: l10n.tabArrival, description: l10n.tabArrivalDescription, icon: Icons.directions),
      TicketsTabContent(
        title: l10n.tabTickets,
        description: l10n.tabTicketsDescription,
        buttonLabel: l10n.ticketsAddSeasonPassButton,
        questionText: l10n.ticketsSeasonPassQuestion,
        ticketsAvailableText: l10n.ticketsAvailableInfo,
        onAddPressed: () => Navigator.of(context).pushNamed(TicketManagementPage.routeName),
      ),
      ExploreTab(title: l10n.tabMap, description: l10n.tabMapDescription),
      const EventsTab(),
    ];

    final tabTitles = [
      if (FeatureFlags.tabArrivalEnabled) l10n.tabArrival,
      l10n.tabTickets,
      l10n.tabMap,
      l10n.tabEvents,
    ];

    final park = ref.watch(lastUsedParkProvider) ?? ParkEnum.essenGrugapark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56,
        leading: Padding(padding: const EdgeInsets.only(left: 16), child: SvgPicture.asset(park.assetPath)),
        title: Text(tabTitles[_currentIndex]),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: context.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
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
          if (FeatureFlags.tabArrivalEnabled)
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
