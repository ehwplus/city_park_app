import 'package:city_park_app/src/l10n/generated/app_localizations.dart';
import 'package:city_park_app/src/l10n/l10n.dart';
import 'package:city_park_app/src/model/ticket/ticket_store_provider.dart';
import 'package:city_park_app/src/pages/add_ticket_page.dart';
import 'package:city_park_app/src/widget/show_selection_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketManagementPage extends ConsumerWidget {
  const TicketManagementPage({super.key});

  static const routeName = '/settings/tickets';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tickets = ref.watch(ticketStoreProvider);
    final notifier = ref.read(ticketStoreProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.ticketsManagementTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onAddNewTicket(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.ticketsAddTicketButton),
      ),
      body:
          tickets.isEmpty
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    l10n.ticketsManagementEmpty,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              : ListView.separated(
                itemCount: tickets.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  final name =
                      [ticket.firstName, ticket.lastName].where((e) => e != null && e.isNotEmpty).join(' ').trim();
                  final subtitleParts = <String>[];
                  if (ticket.cardNumber != null && ticket.cardNumber!.isNotEmpty) {
                    subtitleParts.add(ticket.cardNumber!);
                  }
                  if (ticket.parks.isNotEmpty) {
                    subtitleParts.add(ticket.parks.map((p) => p.name).join(', '));
                  }
                  final subtitle = subtitleParts.join(' · ');

                  return ListTile(
                    title: Text(name.isEmpty ? ticket.uuid : name),
                    subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
                    trailing: TextButton(
                      onPressed: () async => notifier.removeById(ticket.uuid),
                      child: Text(l10n.ticketsManagementRemove),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(AddTicketPage.routeName, arguments: ticket);
                    },
                  );
                },
              ),
    );
  }

  void _onAddNewTicket(BuildContext context) async {
    final navigator = Navigator.of(context);
    final selected = await showSelectionBottomSheet(
      context: context,
      title: context.l10n.ticketsSelectCardType,
      items: [context.l10n.ticketSeasonPass, 'Ruhr.Topcard'],
      labelOf: (s) => s,
    );
    if (selected == context.l10n.ticketSeasonPass) {
      navigator.pushNamed(AddTicketPage.routeName);
    } else if (selected == 'Ruhr.Topcard') {
      navigator.pushNamed(AddTicketPage.routeNameRuhrTopCard);
    }
  }
}
