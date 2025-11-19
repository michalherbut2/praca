import 'package:flutter/material.dart';
import 'package:most_app/screens/AdminAddAnnouncementScreen.dart';
import 'package:most_app/screens/AdminAddEventScreen.dart';
import 'package:most_app/widgets/MostPostsWidget.dart';
import 'package:most_app/widgets/NewsFeedWidget.dart';
import 'package:most_app/widgets/UpcomingEventsWidget.dart';
import 'package:most_app/widgets/AnnouncementWidget.dart';
import 'package:most_app/widgets/TodayEventsWidget.dart';

// Importy, których potrzebujemy do przycisku
import 'package:provider/provider.dart';
import 'package:most_app/helper/AuthService.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../helper/navigation_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Używamy Consumera, aby pobrać stan logowania
    // Twój ScreenWrapper już używa 'context.watch', więc Provider działa
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        // Sprawdzamy, czy user jest liderem/adminem
        // Poniżej używam 'authService.isLoggedIn' jako przykładu z Twojego kodu.
        // ZMIEŃ 'isLoggedIn' na właściwą zmienną z Twojego AuthService,
        // np. 'authService.isAdmin' lub 'authService.isLiderDzialu'
        final bool isLider = authService.isLoggedIn; // <-- UPEWNIJ SIĘ, ŻE TU JEST POPRAWNA ZMIENNA (np. authService.isAdmin)

        // Używamy Stack, tak jak w Twoim przykładzie z FridgeScreen
        return Stack(
          children: [
            // Twój dotychczasowy, scrollowany content
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Sekcja "Czwartek" z wydarzeniami
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TodayEventsWidget(),
                  ),
                  const SizedBox(height: 20),
                  // Sekcja "Zbliżają się" // EVENTS
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: UpcomingEventsWidget(), // git
                  ),
                  const SizedBox(height: 20),
                  // Sekcja z postami społecznościowymi // ANNOUNCEMENTS
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: AnnouncementWidget(),
                  ),
                  // WAŻNE: Dodatkowy padding na dole, aby FAB nie zasłaniał ostatniego elementu
                  const SizedBox(height: 100),
                ],
              ),
            ),

            // A TUTAJ MAGIA (Renderowanie warunkowe FABa)
            // Używamy 'Positioned', tak jak Ty w FridgeScreen
            if (isLider)
              Positioned(
                bottom: 20,
                right: 20, // W prawym dolnym rogu
                child: _buildSpeedDial(context),
              ),
          ],
        );
      },
    );
  }

  // Prywatna metoda budująca "Speed Dial" FAB (skopiowana z poprzedniej sugestii)
  Widget _buildSpeedDial(BuildContext context) {
    return SpeedDial(
      // Główna ikona (plus)
      icon: Icons.add,
      // Ikona po otwarciu (krzyżyk)
      activeIcon: Icons.close,
      backgroundColor: Colors.blue[500],
      foregroundColor: Colors.white,
      activeBackgroundColor: Colors.red[500],
      activeForegroundColor: Colors.white,
      buttonSize: const Size(64.0, 64.0),
      childrenButtonSize: const Size(60.0, 60.0),
      curve: Curves.bounceIn,
      // transition: SpeedDialTransition.scale,

      // Lista "dzieci" (rozwijane przyciski)
      children: [
        SpeedDialChild(
          child: const Icon(Icons.campaign, color: Colors.white),
          label: 'Dodaj Ogłoszenie',
          backgroundColor: Colors.blue[400],
          labelStyle: const TextStyle(fontSize: 16),
          onTap: () {
            // Tutaj logika nawigacji do ekranu tworzenia ogłoszenia
            // context.read<NavigationProvider>().setIndex(9); // (bo 8 to AdminAddAnnouncementScreen)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminAddAnnouncementScreen(),
              ),
            );
            print('Nawigacja do: Ekran Tworzenia Ogłoszenia');
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.calendar_month, color: Colors.white),
          label: 'Dodaj Wydarzenie',
          backgroundColor: Colors.blue[400],
          labelStyle: const TextStyle(fontSize: 16),
          onTap: () {
            // Logika nawigacji (np. używając Twojego NavigationProvider)
            // context.read<NavigationProvider>().setIndex(8); // (bo 8 to AdminAddEventScreen)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminAddEventScreen(),
              ),
            );
            print('Nawigacja do: Ekran Tworzenia Wydarzenia');
          },
        ),
      ],
    );
  }
}