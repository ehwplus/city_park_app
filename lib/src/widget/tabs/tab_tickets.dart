import 'package:city_park_app/src/model/ticket/ticket_store_provider.dart';
import 'package:city_park_app/src/widget/opening_hours/opening_hours_widget.dart';
import 'package:city_park_app/src/widget/tabs/tab.dart';
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
