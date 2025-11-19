import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:most_app/helper/AnnouncementService.dart';
import 'package:most_app/models/Announcement.dart';
import 'package:provider/provider.dart';
import 'SectionHeader.dart';

class AnnouncementWidget extends StatefulWidget {
  const AnnouncementWidget({super.key});

  @override
  State<AnnouncementWidget> createState() => _AnnouncementWidgetState();
}

class _AnnouncementWidgetState extends State<AnnouncementWidget> {
  // Ten Future jest współdzielony z UpcomingEventsWidget.
  // Provider jest na tyle mądry, że `fetchAnnouncements` wykona się tylko raz.
  late Future<void> _fetchAnnouncementsFuture;

  @override
  void initState() {
    super.initState();
    _fetchAnnouncementsFuture =
        Provider.of<AnnouncementsService>(context, listen: false)
            .fetchAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        const SectionHeader(text: 'Tablica Ogłoszeń'),
        FutureBuilder(
          future: _fetchAnnouncementsFuture,
          builder: (ctx, snapshot) {
            // 1. STAN: Ładowanie
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Pokazujemy mniejszy wskaźnik, bo dane mogły być już załadowane
              // przez widget "Ważne Ogłoszenia"
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }

            // 2. STAN: Błąd
            if (snapshot.hasError) {
              return const Center(
                  child: Text('Błąd ładowania tablicy ogłoszeń.'));
            }

            // 3. STAN: Sukces (dane pobrane)
            return Consumer<AnnouncementsService>(
              builder: (ctx, announcementService, child) {
                //
                // KROK F: NOWA LOGIKA FILTROWANIA
                // Bierzemy tylko te ogłoszenia, które NIE SĄ przypięte
                //
                final regularAnnouncements = announcementService.announcements
                    .where((a) => a.pinned == false) // <-- ODWROTNY FILTR
                    .toList();

                // Sortujemy od najnowszego (zakładając, że lista z serwera
                // nie jest jeszcze posortowana, chociaż nasz serwis dodaje na początek)
                regularAnnouncements.sort((a, b) => b.createdAt.compareTo(a.createdAt));


                if (regularAnnouncements.isEmpty) {
                  return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Brak nowych ogłoszeń.',
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                      ));
                }

                //
                // KROK G: Mapujemy na nowy widget AnnouncementCard
                //
                return Column(
                  children: regularAnnouncements
                      .map((ann) => AnnouncementCard(announcement: ann))
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
// KROK H: Nowy widget do wyświetlania zwykłego ogłoszenia
//
class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementCard({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    // Formatujemy datę
    final String timeAgo = _formatDate(announcement.createdAt);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // TODO: Zrobić nawigację do pełnego widoku ogłoszenia
          print("Otwórz ogłoszenie: ${announcement.id}");
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nagłówek (Kategoria + Data)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // Przekształcamy 'EVENTS' na 'Wydarzenia'
                    _formatCategory(announcement.category),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  Text(
                    timeAgo,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Tytuł
              Text(
                announcement.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),

              // Treść (fragment)
              Text(
                announcement.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Funkcja pomocnicza do formatowania daty
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min temu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} godz. temu';
    } else if (difference.inDays == 1) {
      return 'Wczoraj';
    } else {
      return DateFormat('dd.MM.yyyy', 'pl_PL').format(date);
    }
  }

  // Funkcja pomocnicza do formatowania kategorii
  String _formatCategory(String category) {
    switch (category) {
      case 'IMPORTANT':
        return 'WAŻNE';
      case 'EVENTS':
        return 'WYDARZENIA';
      case 'SPIRITUALITY':
        return 'DUCHOWOŚĆ';
      case 'GENERAL':
        return 'OGÓLNE';
      default:
        return category;
    }
  }
}