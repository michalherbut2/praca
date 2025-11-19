import 'package:flutter/material.dart';
import 'package:most_app/screens/SignUpScreen.dart';

import '../screens/WelcomeScreen.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key});

  // Helper do nawigacji, żeby nie powtarzać kodu
  void _navigateToSignIn(BuildContext context) {
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(builder: (context) => const SignInScreen()),
    //       (route) => false,
    // );
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
    );
  }

  void _navigateToRegister(BuildContext context) {
    // Na razie placeholder
    print('Nawigacja do ekranu rejestracji');

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          // color: Colors.transparent,

          child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header z przyciskiem X
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.close,
                          color: Color(0xFF64B5F6),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 12),

                // Główna zawartość
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  child: Column(
                    children: [
                      // Tekst główny
                      // RichText(
                      //   textAlign: TextAlign.center,
                      //   text: const TextSpan(
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       color: Color(0xFF64B5F6),
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //     children: [
                      //       TextSpan(text: 'Aby móc przeglądać swój\nprofil, '),
                      //       TextSpan(
                      //         text: 'zaloguj się',
                      //         style: TextStyle(
                      //           decoration: TextDecoration.underline,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //       TextSpan(text: '.'),
                      //     ],
                      //   ),
                      // ),

                      Wrap(
                        alignment: WrapAlignment.center, // Wyśrodkuj elementy
                        crossAxisAlignment: WrapCrossAlignment.center, // Wyśrodkuj w pionie
                        children: [
                          const Text(
                            'Aby móc przeglądać swój profil,',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Color(0xFF64B5F6)),
                          ),
                          TextButton(
                            onPressed: () => _navigateToSignIn(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 4), // Minimalny padding
                              minimumSize: Size.zero, // Pozwól przyciskowi być małym
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Zmniejsz obszar klikania
                            ),
                            child: const Text(
                              'zaloguj się',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Drugi tekst
                      // RichText(
                      //   textAlign: TextAlign.center,
                      //   text: const TextSpan(
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       color: Color(0xFF64B5F6),
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //     children: [
                      //       TextSpan(text: 'Nie masz jeszcze konta\nMostowiaka?\n'),
                      //       TextSpan(
                      //         text: 'Zarejestruj się!',
                      //         style: TextStyle(
                      //           decoration: TextDecoration.underline,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      // [ZMIANA] To samo robimy dla rejestracji
                      const Text(
                        'Nie masz jeszcze konta Mostowiaka?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Color(0xFF64B5F6)),
                      ),
                      TextButton(
                        onPressed: () => _navigateToRegister(context),
                        child: const Text(
                          'Zarejestruj się!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                  // const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}