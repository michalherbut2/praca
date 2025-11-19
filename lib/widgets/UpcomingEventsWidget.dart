import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:most_app/helper/AnnouncementService.dart';
import 'package:most_app/models/Announcement.dart';
import 'package:provider/provider.dart';
// <-- KROK A: Zmieniamy importy na Serwis i Model Ogłoszeń
// import 'package:most_app/screens/AdminAddAnnouncementScreen_fixed.dart'; // Zakładam, że tu są Twoje klasy
import 'SectionHeader.dart';

//
// KROK 1: StatefulWidget bez zmian
//
class UpcomingEventsWidget extends StatefulWidget {
  const UpcomingEventsWidget({super.key});

  @override
  State<UpcomingEventsWidget> createState() => _UpcomingEventsWidgetState();
}

class _UpcomingEventsWidgetState extends State<UpcomingEventsWidget> {
  // <-- KROK B: Zmieniamy nazwę Future
  late Future<void> _fetchAnnouncementsFuture;

  @override
  void initState() {
    super.initState();
    // <-- KROK C: Zmieniamy serwis na AnnouncementsService
    _fetchAnnouncementsFuture =
        Provider.of<AnnouncementsService>(context, listen: false)
            .fetchAnnouncements(); // i wołamy metodę fetchAnnouncements()
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        // <-- KROK D: Zmieniamy tytuł sekcji
        const SectionHeader(text: 'Ważne Ogłoszenia i Zapisy'),

        //
        // KROK 2: FutureBuilder bez zmian
        //
        FutureBuilder(
          future: _fetchAnnouncementsFuture, // <-- Zmiana
          builder: (ctx, snapshot) {
            // 1. STAN: Ładowanie
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. STAN: Błąd
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(
                  child: Text('Nie udało się pobrać ogłoszeń.'));
            }

            // 3. STAN: Sukces (dane pobrane)
            // <-- KROK E: Zmieniamy Consumer na AnnouncementsService
            return Consumer<AnnouncementsService>(
              builder: (ctx, announcementService, child) {
                // <-- KROK F: NOWA LOGIKA FILTROWANIA
                // Bierzemy tylko te ogłoszenia, które admin "przypiął"
                final pinnedAnnouncements = announcementService.announcements
                    .where((a) => a.pinned == true)
                    .toList();

                if (pinnedAnnouncements.isEmpty) {
                  return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Brak przypiętych ogłoszeń.',
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                      ));
                }

                //
                // KROK G: Mapujemy na nowy widget PinnedAnnouncementCard
                //
                return Column(
                  children: pinnedAnnouncements
                      .map((ann) => PinnedAnnouncementCard(announcement: ann))
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
// KROK H: Nowy widget do wyświetlania przypiętego ogłoszenia
// Zamiast starej EventCard
//
class PinnedAnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  const PinnedAnnouncementCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    // Prosta logika do wybierania ikonki i koloru na podstawie kategorii
    IconData categoryIcon;
    Color categoryColor;

    switch (announcement.category) {
      case 'IMPORTANT':
        categoryIcon = Icons.warning_amber_rounded;
        categoryColor = Colors.red[600]!;
        break;
      case 'EVENTS':
        categoryIcon = Icons.calendar_month_outlined;
        categoryColor = Colors.blue[600]!;
        break;
      case 'SPIRITUALITY':
        categoryIcon = Icons.church;
        categoryColor = Colors.purple[600]!;
        break;
      default:
        categoryIcon = Icons.push_pin;
        categoryColor = Colors.grey[700]!;
    }

    return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          // Kolorowa belka z boku dla wyróżnienia
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: categoryColor, width: 8)),
            color: Colors.white,
          ),
          child: ListTile(
            leading: Icon(categoryIcon, color: categoryColor, size: 40),
            title: Text(
              announcement.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(
              announcement.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            isThreeLine: true,
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            onTap: () {
              // TODO: Zrobić nawigację do pełnego widoku ogłoszenia
              print("Otwórz ogłoszenie: ${announcement.id}");
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => EventDetailsScreen(event: event),
              //   ),
              // );
            },
          ),
        ));
  }
}