import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:most_app/screens/SignInScreen.dart';
import 'package:most_app/styles/Colors.dart';
import 'package:most_app/helper/AuthService.dart';
import 'ScreenWrapper.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Consumer<AuthService>(
        // builder: (context, authService, child) {
        builder: (context, authService, _) {
          if (authService.isLoggedIn) {
            return const ScreenWrapper();
          }
          // return child!;
        // }
        // child: Scaffold(
        return Scaffold(
          backgroundColor: screenBackgroundColor,
          body: SingleChildScrollView(
            child: SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logos/png/logo_MOST.png',
                        width: 178,
                        height: 54,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Witamy w aplikacji\n Salezjańskiego\n Duszpasterstawa\n Akademickiego MOST",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SignInScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: SizedBox(
                      width: 240,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Zaloguj się",
                            style: TextStyle(
                              color: buttonTextColor,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      // Navigate to main app without login
                      print('Kontynuuj bez logowania');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenWrapper()),
                          (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: screenBackgroundColor,
                      side: BorderSide(color: buttonBorderColor, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: SizedBox(
                      width: 240,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Kontynuuj niezalogowany",
                            style: TextStyle(
                              color: buttonBorderColor,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Social login buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Facebook login
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            // Handle Facebook login
                            print('Facebook login');
                            context.read<AuthService>().signInWithFacebook();
                          },
                          padding: EdgeInsets.zero,
                          icon: Image.asset(
                            'assets/logos/png/facebook_icon.png',
                          ),
                        ),
                      ),

                      const SizedBox(width: 20),

                      // Google login
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Handle Google login
                            print('Google login');
                            context.read<AuthService>().signInWithGoogle();
                          },
                          padding: EdgeInsets.zero,
                          icon: Image.asset(
                            'assets/logos/png/gmail_icon.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
            );});

  }
}
