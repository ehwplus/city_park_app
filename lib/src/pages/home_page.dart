import 'package:city_park_app/src/feature_flags.dart';
import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:city_park_app/src/model/park/last_used_park_provider.dart';
import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:city_park_app/src/pages/settings_page.dart';
import 'package:city_park_app/src/pages/ticket_management_page.dart';
import 'package:city_park_app/src/widget/park_selection_overlay.dart';
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
  bool _hasCheckedInitialPark = false;
  bool _isShowingParkOverlay = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ensureParkSelection();
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _ensureParkSelection() async {
    if (_hasCheckedInitialPark || !mounted) return;
    _hasCheckedInitialPark = true;

    await ref.read(lastUsedParkProvider.notifier).loadFromStorage();
    if (!mounted) return;

    if (ref.read(lastUsedParkProvider) == null) {
      await _openParkSelectionOverlay(showCloseButton: false);
    }
  }

  Future<void> _openParkSelectionOverlay({required bool showCloseButton}) async {
    if (_isShowingParkOverlay || !mounted) return;

    _isShowingParkOverlay = true;
    try {
      final selected = await showParkSelectionOverlay(
        context: context,
        showCloseButton: showCloseButton,
        selectedPark: ref.read(lastUsedParkProvider),
      );
      if (!mounted || selected == null) return;

      await ref.read(lastUsedParkProvider.notifier).setPark(selected);
    } finally {
      _isShowingParkOverlay = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selectedPark = ref.watch(lastUsedParkProvider);
    final park = selectedPark ?? ParkEnum.essenGrugapark;
    final tabs = [
      if (FeatureFlags.tabArrivalEnabled)
        TabContent(title: l10n.tabArrival, description: l10n.tabArrivalDescription, icon: Icons.directions),
      TicketsTabContent(
        ticketsAvailableText: l10n.ticketsAvailableInfo,
        onAddPressed: () => Navigator.of(context).pushNamed(TicketManagementPage.routeName),
      ),
      ExploreTab(title: l10n.tabMap, description: l10n.tabMapDescription),
      if (park.eventsUrl != null) const EventsTab(),
    ];

    final tabTitles = [
      if (FeatureFlags.tabArrivalEnabled) l10n.tabArrival,
      l10n.tabTickets,
      l10n.tabMap,
      if (park.eventsUrl != null) l10n.tabEvents,
    ];

    final maxIndex = tabTitles.length - 1;
    final currentIndex = _currentIndex > maxIndex ? maxIndex : _currentIndex;

    if (currentIndex != _currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _currentIndex = currentIndex;
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: InkWell(
            onTap: () => _openParkSelectionOverlay(showCloseButton: true),
            borderRadius: BorderRadius.circular(12),
            child: Padding(padding: const EdgeInsets.all(4), child: SvgPicture.asset(park.assetPath)),
          ),
        ),
        title: Text(tabTitles[currentIndex]),
        backgroundColor: Colors.transparent,
        systemOverlayStyle: context.isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed(SettingsPage.routeName),
          ),
        ],
      ),
      body: IndexedStack(index: currentIndex, children: tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onTabSelected,
        items: [
          if (FeatureFlags.tabArrivalEnabled)
            BottomNavigationBarItem(icon: const Icon(Icons.directions), label: l10n.tabArrival),
          BottomNavigationBarItem(icon: const Icon(Icons.confirmation_number), label: l10n.tabTickets),
          BottomNavigationBarItem(icon: const Icon(Icons.map), label: l10n.tabMap),
          if (park.eventsUrl != null) BottomNavigationBarItem(icon: const Icon(Icons.event), label: l10n.tabEvents),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
