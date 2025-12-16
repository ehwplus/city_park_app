import 'package:barcode_widget/barcode_widget.dart';
import 'package:city_park_app/src/l10n/l10n.dart';
import 'package:city_park_app/src/model/ticket/ticket_store_provider.dart';
import 'package:city_park_app/src/widget/opening_hours/opening_hours_widget.dart';
import 'package:city_park_app/src/widget/tabs/tab.dart';
import 'package:fl_ui_config/fl_ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickets = ref.watch(ticketStoreProvider);
    final hasTickets = tickets.isNotEmpty;

    final baseContent = TabContent(title: title, description: description, icon: Icons.confirmation_number);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        baseContent,
        OpeningHoursWidget(),
        const SizedBox(height: 12),
        if (hasTickets)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final ticket in tickets)
                  Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(
                        [
                              ticket.firstName,
                              ticket.lastName,
                            ].where((e) => e != null && e.isNotEmpty).join(' ').trim().isEmpty
                            ? ticket.uuid
                            : [
                              ticket.firstName,
                              ticket.lastName,
                            ].where((e) => e != null && e.isNotEmpty).join(' ').trim(),
                      ),
                      subtitle:
                          ticket.cardNumber != null && ticket.cardNumber!.isNotEmpty
                              ? Text('Nr. ${ticket.cardNumber}')
                              : null,
                      trailing:
                          ticket.qrCode != null && ticket.qrCode!.isNotEmpty
                              ? SizedBox(
                                height: 56,
                                width: 56,
                                child: BarcodeWidget(
                                  barcode: Barcode.qrCode(),
                                  data: ticket.qrCode!,
                                  padding: EdgeInsets.zero,
                                  color: colorPalette.basic0,
                                ),
                              )
                              : null,
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                title: Text(
                                  context.l10n.ticketsQrDialogTitle,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.copyWith(color: colorPaletteLight.fontColors.normal),
                                ),
                                backgroundColor: Colors.white,
                                content: SizedBox(
                                  height: 220,
                                  width: 220,
                                  child: Center(
                                    child: BarcodeWidget(
                                      barcode: Barcode.qrCode(),
                                      data: ticket.qrCode!,
                                      width: 200,
                                      height: 200,
                                    ),
                                  ),
                                ),
                              ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [
                Text(questionText, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                ElevatedButton(onPressed: onAddPressed, child: Text(buttonLabel)),
              ],
            ),
          ),
        const SizedBox(height: 16),
        if (hasTickets) TextButton(onPressed: onAddPressed, child: Text(buttonLabel)),
      ],
    );
  }
}
