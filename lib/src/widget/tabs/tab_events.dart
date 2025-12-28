import 'package:city_park_app/src/model/park/last_used_park_provider.dart';
import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EventsTab extends ConsumerStatefulWidget {
  const EventsTab({super.key});

  @override
  ConsumerState<EventsTab> createState() => _EventsTabState();
}

class _EventsTabState extends ConsumerState<EventsTab> {
  late final WebViewController _controller;
  ParkEnum? _currentPark;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.transparent);
  }

  @override
  Widget build(BuildContext context) {
    final park = ref.watch(lastUsedParkProvider) ?? ParkEnum.essenGrugapark;

    if (_currentPark != park) {
      _currentPark = park;
      _controller.loadRequest(Uri.parse(park.eventsUrl!));
    }

    return SafeArea(child: WebViewWidget(controller: _controller));
  }
}
