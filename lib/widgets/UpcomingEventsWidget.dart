import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../helper/AuthService.dart';
import '../helper/EventService.dart';
import '../models/Event.dart';
import '../screens/EventDetailsScreen.dart';
import '../screens/SignInScreen.dart';
import 'SectionHeader.dart';

class UpcomingEventsWidget extends StatefulWidget {
  const UpcomingEventsWidget({super.key});

  @override
  State<UpcomingEventsWidget> createState() => _UpcomingEventsWidgetState();
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget> {
  // Zmienna na Future do pobierania wydarzeń
  late Future<void> _fetchEventsFuture;

  @override
  void initState() {
    super.initState();
    // Pobieramy wydarzenia przy inicjalizacji widgetu
    _fetchEventsFuture =
        Provider.of<EventService>(context, listen: false).fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        // Nagłówek sekcji
        const SectionHeader(text: 'Zapisy na wydarzenia'),

        FutureBuilder(
          future: _fetchEventsFuture,
          builder: (ctx, snapshot) {
            // 1. Ładowanie
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. Błąd
            if (snapshot.hasError) {
              return const Center(child: Text('Nie udało się pobrać wydarzeń.'));
            }

            // 3. Sukces - budujemy listę
            return Consumer<EventService>(
              builder: (ctx, eventService, child) {
                // Filtrowanie: tylko te, gdzie allowRSVP jest true ORAZ data jest w przyszłości
                final rsvpEvents = eventService.events.where((e) {
                  final isFuture = e.startDate.isAfter(DateTime.now());
                  return e.allowRsvp && isFuture;
                }).toList();

                // Opcjonalnie: sortowanie od najbliższego
                rsvpEvents.sort((a, b) => a.startDate.compareTo(b.startDate));

                if (rsvpEvents.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Brak aktywnych zapisów na wydarzenia.',
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                  );
                }

                // Mapowanie na widgety kart
                return Column(
                  children: rsvpEvents
                      .map((event) => EventRsvpCard(event: event))
                      .toList(),
                );
              },
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

//
// Widget karty dla wydarzenia z zapisami
//
class EventRsvpCard extends StatelessWidget {
  final Event event;

  const EventRsvpCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // Formatowanie daty (np. 27.11.2025 18:00)
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');

    // Sprawdzamy czy użytkownik jest zalogowany
    final authService = Provider.of<AuthService>(context);
    final isLoggedIn = authService.isLoggedIn;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (isLoggedIn) {
            // Jeśli zalogowany -> idź do szczegółów wydarzenia
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailsScreen(event: event),
              ),
            );
          } else {
            // Jeśli NIEzalogowany -> idź do logowania
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Musisz się zalogować, aby zapisać się na wydarzenie.")),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignInScreen(),
              ),
            );
          }
        },
        child: Container(
          // Kolor paska: Zielony (ok) lub Pomarańczowy (wymaga akcji/logowania)
          decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: isLoggedIn ? Colors.green : Colors.orange,
                    width: 8)),
            color: Colors.white,
          ),
          child: ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            // Ikonka: Dostępne lub Kłódka
            leading: Icon(
              isLoggedIn
                  ? Icons.event_available_rounded
                  : Icons.lock_outline_rounded,
              color: isLoggedIn ? Colors.green : Colors.orange,
              size: 40,
            ),
            title: Text(
              event.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      dateFormat.format(event.startDate),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Tekst zachęty zależny od stanu logowania
                Text(
                  isLoggedIn
                      ? "Kliknij, aby się zapisać!"
                      : "Zaloguj się, aby się zapisać",
                  style: TextStyle(
                    color: isLoggedIn
                        ? Theme.of(context).primaryColor
                        : Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          ),
        ),
      ),
    );
  }
}