import 'package:flutter/material.dart';
import 'package:most_app/models/Event.dart';
import 'package:most_app/widgets/ScreenHeader.dart';
import 'package:most_app/widgets/SectionHeader.dart';
import 'package:most_app/styles/Colors.dart';
// import 'package:webview_flutter/webview_flutter.dart'; // <-- JUŻ NIEPOTRZEBNE
import 'package:table_calendar/table_calendar.dart'; // <-- NOWY IMPORT
import 'package:provider/provider.dart'; // <-- NOWY IMPORT
import 'package:most_app/helper/EventService.dart'; // <-- NOWY IMPORT
import 'package:intl/intl.dart'; // <-- NOWY IMPORT

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Stan dla kalendarza
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Mapa do przechowywania pobranych wydarzeń (optymalizacja)
  Map<DateTime, List<Event>> _eventsByDay = {};

  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      final eventService = Provider.of<EventService>(context, listen: false);
      // Pobieramy wszystkie eventy. Serwis je zapamięta.
      await eventService.fetchEvents();

      // Przetwarzamy eventy do mapy dla kalendarza
      _eventsByDay.clear();
      for (final event in eventService.events) {
        // Musimy obsłużyć eventy wielodniowe
        DateTime day = event.startDate;
        while (day.isBefore(event.endDate.add(const Duration(days: 1)))) {
          final dayOnly = DateTime.utc(day.year, day.month, day.day);
          if (_eventsByDay[dayOnly] == null) {
            _eventsByDay[dayOnly] = [];
          }
          // Dodajemy event tylko raz na dany dzień, nawet jeśli trwa cały dzień
          if (!_eventsByDay[dayOnly]!.contains(event)) {
            _eventsByDay[dayOnly]!.add(event);
          }
          day = day.add(const Duration(days: 1));
        }
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = 'Błąd ładowania wydarzeń: $e';
        });
      }
    }
  }

  // Funkcja, którą woła TableCalendar, żeby pobrać eventy dla dnia
  List<Event> _getEventsForDay(DateTime day) {
    final dayOnly = DateTime.utc(day.year, day.month, day.day);
    return _eventsByDay[dayOnly] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    // Pobieramy listę wydarzeń dla aktualnie wybranego dnia
    final selectedEvents = _getEventsForDay(_selectedDay ?? DateTime.now());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ScreenHeader(title: "KALENDARZ"),

            // --- NOWY DYNAMICZNY KALENDARZ ---
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar<Event>(
                  locale: 'pl_PL', // Polskie nazwy
                  firstDay: DateTime.now().subtract(const Duration(days: 365)),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false, // Ukrywamy przycisk "2 Weeks"
                    titleCentered: true,
                  ),
                  calendarStyle: CalendarStyle(
                    // Style dla kropek
                    markerDecoration: BoxDecoration(
                      color: Colors.red[400],
                      shape: BoxShape.circle,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  // Magia dzieje się tutaj - podpinamy nasze wydarzenia
                  eventLoader: _getEventsForDay,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- DYNAMICZNA LISTA WYDARZEŃ DLA WYBRANEGO DNIA ---
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_error.isNotEmpty)
              Center(child: Text(_error, style: const TextStyle(color: Colors.red)))
            else ...[ // Używamy 'spread operator'
                Text(
                  'Wydarzenia na ${DateFormat('dd MMMM yyyy', 'pl_PL').format(_selectedDay!)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                if (selectedEvents.isEmpty)
                  const Text('Brak wydarzeń tego dnia.', style: TextStyle(color: Colors.grey))
                else
                  ListView.builder(
                    shrinkWrap: true, // Ważne wewnątrz SingleChildScrollView
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectedEvents.length,
                    itemBuilder: (context, index) {
                      final event = selectedEvents[index];
                      final time = DateFormat('HH:mm', 'pl_PL').format(event.startDate.toLocal());
                      return Card(
                        elevation: 1,
                        child: ListTile(
                          leading: Text(time, style: TextStyle(fontWeight: FontWeight.bold, color: blueColor, fontSize: 16)),
                          title: Text(event.title),
                          subtitle: event.location != null ? Text(event.location!) : null,
                          dense: true,
                        ),
                      );
                    },
                  ),
              ],

            const SizedBox(height: 24),

            // --- TWÓJ STARY, STATYCZNY PLAN TYGODNIA (Zostawiamy, bo jest super) ---
            const SectionHeader(text: "Ogólny plan tygodnia"),
            const SizedBox(height: 18),
            // Niedziela
            Text(
              'NIEDZIELA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: blueColor,
                fontSize: 15,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            _planLine('18:00 – Próba scholi (salka kaflowa)', blueColor),
            _planLine(
                '18:30 – Spotkanie Liturgicznej Służby Ołtarza (salka wężowa)',
                blueColor),
            _planLine('19:25 – Didascalia (kościół NSJ)', blueColor),
            _planLine('19:30 – Msza święta (kościół NSJ)', blueColor),
            _planLine('20:30 – Kolacja (Stolarnia)', blueColor),
            const SizedBox(height: 16),

            // ... (reszta Twojego statycznego planu tygodnia) ...
            // Poniedziałek
            Text(
              'PONIEDZIAŁEK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: blueColor,
                fontSize: 15,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            _planLine('18:30 – Próba scholi (salka kaflowa)', blueColor),
            _planLine('18:40 – Różaniec (kościół NSJ)', blueColor),
            _planLine('19:00 – Msza święta (kościół NSJ)', blueColor),
            _planLine(
                '20:00 – Lectio Divina – Spotkanie Biblijne (salka MOSTu)',
                blueColor),
            const SizedBox(height: 16),

            // Wtorek
            Text(
              'WTOREK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: blueColor,
                fontSize: 15,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            _planLine('18:30 – Próba scholi (salka kaflowa)', blueColor),
            _planLine('18:40 – Różaniec (kościół NSJ)', blueColor),
            _planLine('19:00 – Msza święta (kościół NSJ)', blueColor),
            _planLine('19:45 – Adoracja (kościół NSJ)', blueColor),
            _planLine(
                '20:15 – Spotkania Formacyjne',
                blueColor),
            const SizedBox(height: 16),

            // Środa
            Text(
              'ŚRODA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: blueColor,
                fontSize: 15,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            _planLine('17:00 – Dziewczyny zza płota', blueColor),
            _planLine('18:30 – Próba scholi (salka kaflowa)', blueColor),
            _planLine('19:00 – Msza święta (kościół NSJ)', blueColor),
            _planLine(
                '20:00 – Iloraz (salka kaflowa)',
                blueColor),
            const SizedBox(height: 16),

            // Czwartek
            Text(
              'CZWARTEK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: blueColor,
                fontSize: 15,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            _planLine('17:30 – Gitara (salka kaflowa)', blueColor),
            _planLine('18:30 – Próba scholi (salka kaflowa)', blueColor),
            _planLine('19:00 – Msza święta (kościół NSJ)', blueColor),
            _planLine(
                '20:00 – Wyjścia / Wieczory / Imprezy (Stolarnia)',
                blueColor),
            const SizedBox(height: 16),

            // Piątek
            Text(
              'PIĄTEK',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: blueColor,
                fontSize: 15,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            _planLine('18:30 – Próba scholi (salka kaflowa)', blueColor),
            _planLine('19:00 – Msza święta (kościół NSJ)', blueColor),
            _planLine('20:00 – Tabor (salka kaflowa)', blueColor),
            _planLine(
                '22:00 – Salka z MOSTem (Salezjańska Szkoła Podstawowa ul. Świętokrzyska 45)',
                blueColor),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Ta funkcja jest bez zmian, idealnie pasuje
  Widget _planLine(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(right: 8, top: 6),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}