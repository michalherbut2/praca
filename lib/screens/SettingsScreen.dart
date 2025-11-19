import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:most_app/helper/AuthService.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Używamy Padding i Center, aby przycisk nie był przyklejony do krawędzi
    // i znajdował się w sensownym miejscu.
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Kolumna zajmie tylko potrzebne miejsce
          children: [
            const Text(
              'Ustawienia Konta',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            if (context.watch<AuthService>().isLoggedIn)
              ElevatedButton.icon(
                onPressed: () {
                  // Wywołujemy akcję wylogowania z naszego serwisu.
                  // Używamy `context.read`, bo to jednorazowa akcja.
                  context.read<AuthService>().signOut();

                  // WAŻNE: Nie potrzebujemy tutaj żadnej nawigacji!
                  // Główny widget (`SignInScreen` lub inny, który nasłuchuje na
                  // zmiany w AuthService) sam wykryje zmianę stanu `isLoggedIn`
                  // i automatycznie zamieni `MainScreenWrapper` na ekran logowania.
                  // To jest właśnie siła tej architektury.
                },
                icon: const Icon(Icons.logout, size: 20),
                label: const Text('Wyloguj się'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      Colors.red.shade700, // Wyraźny, "ostrzegawczy" kolor
                  minimumSize: const Size(
                      double.infinity, 50), // Przycisk na całą szerokość
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
