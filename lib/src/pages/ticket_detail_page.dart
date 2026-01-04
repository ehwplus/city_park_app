import 'package:barcode_widget/barcode_widget.dart';
import 'package:city_park_app/src/common/screen_brightness.dart';
import 'package:city_park_app/src/l10n/l10n.dart';
import 'package:city_park_app/src/model/park/park_enum.dart';
import 'package:city_park_app/src/model/ticket/ticket_model.dart';
import 'package:city_park_app/src/widget/ticket/resolve_background_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TicketDetailArguments {
  const TicketDetailArguments({required this.ticket, required this.park});

  final TicketModel ticket;
  final ParkEnum park;
}

class TicketDetailPage extends StatefulWidget {
  const TicketDetailPage({super.key, required this.args});

  static const routeName = '/tickets/detail';

  final TicketDetailArguments args;

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  @override
  void initState() {
    super.initState();
    setMaximalScreenBrightness().catchError((_) {});
  }

  @override
  void dispose() {
    resetScreenBrightness().catchError((_) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticket = widget.args.ticket;
    final park = widget.args.park;

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.tabTickets)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: _TicketDetailCard(ticket: ticket, park: park),
        ),
      ),
    );
  }
}

class _TicketDetailCard extends StatelessWidget {
  const _TicketDetailCard({required this.ticket, required this.park});

  final TicketModel ticket;
  final ParkEnum park;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final baseColor = resolveTicketBackgroundColor(park: park, ticket: ticket);
    final accentColor = _resolveAccentColor(baseColor, ticket.type);
    final name = _buildName(ticket, l10n);
    final typeLabel = _typeLabel(ticket.type, l10n);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final parks = ticket.parks;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [baseColor, accentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 8),
            color: theme.shadowColor.withOpacity(0.25),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (parks.length == 1 && park.assetPath.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                            child: SvgPicture.asset(
                              park.assetPath,
                              height: 28,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ),
                    Text(
                      name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (parks.length == 1)
                      Text(
                        '${park.name} · ${park.city}',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                  ],
                ),
              ),
              _TypeBadge(label: typeLabel, baseColor: baseColor),
            ],
          ),
          const SizedBox(height: 12),
          if (parks.length > 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(l10n.ruhrTopcardConditions, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white)),
            ),
          if (parks.length > 1)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  parks
                      .map(
                        (parkEntry) => _Pill(
                          label: parkEntry.name,
                          color: Color(parkEntry.primaryColor).withOpacity(0.18),
                          textColor: Colors.white,
                        ),
                      )
                      .toList(),
            ),
          const SizedBox(height: 16),
          if (ticket.cardNumber != null && ticket.cardNumber!.isNotEmpty)
            _InfoRow(label: l10n.ticketsFormCardNumber, value: ticket.cardNumber!),
          if (ticket.expirationDate != null)
            _InfoRow(label: l10n.ticketsFormExpirationDate, value: _formatDate(ticket.expirationDate!, locale)),
          if (ticket.birthday != null)
            _InfoRow(label: l10n.ticketsFormBirthday, value: _formatDate(ticket.birthday!, locale)),
          const SizedBox(height: 16),
          if (ticket.qrCode != null && ticket.qrCode!.isNotEmpty)
            _TicketCodeBlock(label: l10n.ticketsFormQrCode, data: ticket.qrCode!, barcode: Barcode.qrCode()),
          if (ticket.barCode != null && ticket.barCode!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: _TicketCodeBlock(
                label: l10n.ticketsFormBarCode,
                data: ticket.barCode!,
                barcode: Barcode.code128(),
              ),
            ),
        ],
      ),
    );
  }

  Color _resolveAccentColor(Color base, TicketType type) {
    final hslBase = HSLColor.fromColor(base);
    switch (type) {
      case TicketType.single:
        return hslBase
            .withHue((hslBase.hue + 24) % 360)
            .withLightness(_clampLightness(hslBase.lightness + 0.1))
            .toColor();
      case TicketType.ruhrTopCard:
        return hslBase.withLightness(_clampLightness(hslBase.lightness - 0.06)).toColor();
      case TicketType.seasonPass:
        return hslBase
            .withSaturation(_clampSaturation(hslBase.saturation + 0.1))
            .withLightness(_clampLightness(hslBase.lightness - 0.05))
            .toColor();
    }
  }

  double _clampLightness(double value) => value.clamp(0.0, 1.0).toDouble();

  double _clampSaturation(double value) => value.clamp(0.0, 1.0).toDouble();

  String _buildName(TicketModel ticket, AppLocalizations l10n) {
    final parts =
        [ticket.firstName, ticket.lastName].where((value) => value != null && value.isNotEmpty).join(' ').trim();
    return parts.isEmpty ? '${l10n.ticketsFormFirstName} ${l10n.ticketsFormLastName}' : parts;
  }

  String _formatDate(DateTime date, String locale) {
    return DateFormat('dd.MM.yyyy', locale).format(date);
  }

  String _typeLabel(TicketType type, AppLocalizations l10n) {
    switch (type) {
      case TicketType.single:
        return l10n.ticketSingle;
      case TicketType.seasonPass:
        return l10n.ticketSeasonPass;
      case TicketType.ruhrTopCard:
        return 'Ruhr.Topcard';
    }
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.label, required this.baseColor});

  final String label;
  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.12),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Text(label, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white))],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: textTheme.labelMedium?.copyWith(color: Colors.white70))),
          const SizedBox(width: 12),
          Flexible(
            flex: 2,
            child: Text(
              value,
              style: textTheme.bodyLarge?.copyWith(color: Colors.white),
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.color, required this.textColor});

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: textColor)),
    );
  }
}

class _TicketCodeBlock extends StatelessWidget {
  const _TicketCodeBlock({required this.label, required this.data, required this.barcode});

  final String label;
  final String data;
  final Barcode barcode;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isQrCode = barcode.name == 'QR-Code';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Column(
        children: [
          Text(label, style: textTheme.titleMedium?.copyWith(color: Colors.black87)),
          Padding(
            padding: EdgeInsets.only(top: 12, bottom: isQrCode ? 8 : 0),
            child: BarcodeWidget(barcode: barcode, data: data, height: isQrCode ? 140 : 64),
          ),
          if (isQrCode) Text(data, style: textTheme.bodySmall?.copyWith(color: Colors.black54)),
        ],
      ),
    );
  }
}
