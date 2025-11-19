import 'package:flutter/material.dart';
import 'package:most_app/styles/Colors.dart';
import 'package:most_app/widgets/CustomOutlinedButton.dart';
import 'package:most_app/widgets/SectionHeader.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/navigation_provider.dart';
// <-- KROK 1: Importujemy nasz nowy serwis i model
import 'package:most_app/helper/EventService.dart';
import 'package:most_app/models/Event.dart';

class TodayEventsWidget extends StatefulWidget {
  const TodayEventsWidget({super.key});

  @override
  State<TodayEventsWidget> createState() => _TodayEventsWidgetState();
}

class _TodayEventsWidgetState extends State<TodayEventsWidget> {
  // <-- KROK 2: Zmieniamy typ listy ze starej Mapy na nasz nowy model Event
  List<Event> _todayEvents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // <-- KROK 3: Zmieniamy nazwę funkcji, żeby była bardziej czytelna
    _fetchTodayEvents();
  }

  // <-- KROK 4: CAŁKOWICIE PRZEBUDOWANA LOGIKA POBIERANIA DANYCH
  Future<void> _fetchTodayEvents() async {
    // Używamy try-catch do obsługi błędów
    try {
      // Pobieramy serwis z Providera. 'listen: false' jest kluczowe w initState!
      final eventService = Provider.of<EventService>(context, listen: false);

      // Pobieramy WSZYSTKIE eventy. Serwis sam je przechowa w liście _events
      // Jeśli już były pobrane, to (idealnie) serwis powinien sam zdecydować,
      // czy pobierać je znowu.
      await eventService.fetchEvents();

      // Teraz, gdy serwis ma już listę, filtrujemy ją
      final allEvents = eventService.events;
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      // Logika filtrowania:
      // Wydarzenie jest "dzisiaj", jeśli:
      // 1. Zaczyna się PRZED końcem dzisiejszego dnia (jutrem)
      // 2. ORAZ kończy się PO rozpoczęciu dzisiejszego dnia
      // (To poprawnie obsługuje wydarzenia, które trwają np. od wczoraj do jutra)
      final filteredEvents = allEvents.where((event) {
        final startsBeforeTomorrow = event.startDate.isBefore(endOfDay);
        final endsAfterToday = event.endDate.isAfter(startOfDay);
        return startsBeforeTomorrow && endsAfterToday;
      }).toList();

      // Sortujemy po godzinie rozpoczęcia
      filteredEvents.sort((a, b) => a.startDate.compareTo(b.startDate));

      // <-- KROK 5: NAPRAWA BŁĘDU 'setState() called after dispose()'
      // Sprawdzamy, czy widget nadal jest "zamontowany" (widoczny)
      if (mounted) {
        setState(() {
          _todayEvents = filteredEvents;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Błąd pobierania wydarzeń na dziś: $e');
      // Tutaj też sprawdzamy 'mounted'
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final weekday =
    DateFormat('EEEE', 'pl_PL').format(DateTime.now()).toUpperCase();

    return Column(
      children: [
        // Nagłówek z poziomymi liniami
        const SectionHeader(text: 'Dzisiaj w Moście'),

        // Główne pudełko
        Container(
          decoration: BoxDecoration(
            color: calendarBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                weekday,
                style: const TextStyle(
                  fontSize: 26,
                  color: Color(0xFF6BA100),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 12),

              // <-- KROK 6: AKTUALIZACJA LOGIKI WYŚWIETLANIA
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                )
              else if (_todayEvents.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Brak zaplanowanych wydarzeń na dziś.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _todayEvents.map((event) {
                    // Formatujemy godzinę dla każdego eventu
                    final time = DateFormat('HH:mm', 'pl_PL')
                        .format(event.startDate.toLocal());
                    return _EventRow(
                      time: time,
                      title: event.title,
                    );
                  }).toList(),
                ),
              const SizedBox(height: 20),

              // Przycisk do kalendarza
              CustomOutlinedButton(
                text: 'PRZEJDŹ DO KALENDARZA',
                // nawigacja do kalendarza
                onPressed: () {
                  context.read<NavigationProvider>().setIndex(1); // CalendarScreen
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

// Podrzędny widget na jeden wiersz wydarzenia
// (Bez zmian, bo idealnie pasuje)
class _EventRow extends StatelessWidget {
  final String time;
  final String title;

  const _EventRow({required this.time, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              time,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}