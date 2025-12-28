import 'package:barcode_widget/barcode_widget.dart';
import 'package:card_stack_widget/card_stack_widget.dart';
import 'package:city_park_app/src/l10n/l10n.dart';
import 'package:city_park_app/src/model/park/last_used_park_provider.dart';
import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:city_park_app/src/model/ticket/ticket_model.dart';
import 'package:city_park_app/src/model/ticket/ticket_store_provider.dart';
import 'package:city_park_app/src/pages/add_ticket_page.dart';
import 'package:city_park_app/src/widget/opening_hours/opening_hours_widget.dart';
import 'package:city_park_app/src/widget/tabs/tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketsTabContent extends ConsumerWidget {
  const TicketsTabContent({
    super.key,
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

  static const double _ticketCardHeight = 280;
  static const double _actionCardHeight = 280;
  static const double _cardStackPositionFactor = 1.2;
  static const double _cardStackScaleFactor = 1.4;
  static const double _cardStackSpacing = _cardStackPositionFactor * 10;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final park = ref.watch(lastUsedParkProvider) ?? ParkEnum.essenGrugapark;
    final tickets = ref.watch(ticketStoreProvider);
    final hasTickets = tickets.isNotEmpty;
    final parkTickets = !hasTickets ? [] : tickets.where((ticket) => ticket.parks.contains(park)).toList();

    final List<CardModel> cards = [
      if (parkTickets.isNotEmpty) ...parkTickets.map((ticket) => _buildTicketCard(context, ticket, park)),
      _buildActionCard(context, park, hasTickets: parkTickets.isNotEmpty),
    ];
    final stackHeight = _calculateStackHeight(cards.length);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 0),
      children: [
        SizedBox(
          height: stackHeight,
          child: CardStackWidget(
            cardList: cards,
            reverseOrder: true,
            cardDismissOrientation: CardOrientation.down,
            swipeOrientation: CardOrientation.down,
            animateCardScale: true,
            opacityChangeOnDrag: true,
            positionFactor: _cardStackPositionFactor,
            scaleFactor: _cardStackScaleFactor,
            alignment: Alignment.topCenter,
          ),
        ),
        const SizedBox(height: 32),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: OpeningHoursWidget()),
      ],
    );
  }

  double _calculateStackHeight(int cardCount) {
    const double baseHeight = _ticketCardHeight + 30 * 2;
    final double extraSpacing = cardCount > 1 ? (cardCount - 1) * _cardStackSpacing : 0;
    return baseHeight + extraSpacing;
  }

  CardModel _buildTicketCard(BuildContext context, TicketModel ticket, ParkEnum park) {
    final theme = Theme.of(context);
    final name =
        [ticket.firstName, ticket.lastName].where((value) => value != null && value.isNotEmpty).join(' ').trim();
    final displayName = name.isEmpty ? ticket.uuid : name;
    final subtitle = <String>[
      park.name,
      ticket.type == TicketType.seasonPass ? context.l10n.ticketSeasonPass : context.l10n.ticketSingle,
      if (ticket.cardNumber != null && ticket.cardNumber!.isNotEmpty) ticket.cardNumber!,
    ].join(' · ');

    return CardModel(
      key: ValueKey(ticket.uuid),
      backgroundColor: Colors.amber,
      shadowColor: theme.colorScheme.shadow.withOpacity(0.2),
      shadowBlurRadius: 8,
      radius: const Radius.circular(18),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 64,
        height: _ticketCardHeight,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor)),
                    ],
                  ),
                ),
                Icon(Icons.confirmation_number, color: theme.colorScheme.primary),
              ],
            ),
            const SizedBox(height: 16),
            if (ticket.qrCode != null && ticket.qrCode!.isNotEmpty)
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.white),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    Center(child: BarcodeWidget(barcode: Barcode.qrCode(), data: ticket.qrCode!)),
                    const SizedBox(height: 12),
                    Text(
                      ticket.uuid,
                      style: theme.textTheme.labelMedium?.copyWith(color: theme.hintColor, fontSize: 10),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  CardModel _buildActionCard(BuildContext context, ParkEnum park, {required bool hasTickets}) {
    final theme = Theme.of(context);
    final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
    final l10n = context.l10n;
    final onPrimary = theme.colorScheme.onPrimaryContainer;

    Future<void> openTicketsShop() async {
      final url = Uri.parse(park.buyTicketUrl);
      final launched = await launchUrl(url, mode: LaunchMode.inAppBrowserView);
      if (!launched) {
        scaffoldMessenger?.showSnackBar(SnackBar(content: Text(l10n.ticketsOpenShopError)));
      }
    }

    return CardModel(
      key: const ValueKey('ticket-actions'),
      backgroundColor: theme.colorScheme.primaryContainer,
      shadowColor: theme.colorScheme.primary.withOpacity(0.2),
      shadowBlurRadius: 8,
      radius: const Radius.circular(18),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 64,
        height: _actionCardHeight,
        child: Column(
          children: [
            Text(
              hasTickets ? context.l10n.ticketsAvailableInfo : context.l10n.ticketsSeasonPassQuestion,
              style: theme.textTheme.titleLarge?.copyWith(color: onPrimary, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(AddTicketPage.routeName),
              icon: const Icon(Icons.add),
              label: Text(context.l10n.ticketsAddSeasonPassButton),
              style: FilledButton.styleFrom(foregroundColor: onPrimary),
            ),
            ElevatedButton.icon(
              onPressed: openTicketsShop,
              icon: const Icon(Icons.open_in_browser),
              label: Text(context.l10n.ticketsBuyTicketButton),
              style: FilledButton.styleFrom(foregroundColor: onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
