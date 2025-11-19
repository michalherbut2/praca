import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:most_app/firebase_options.dart';
import 'package:most_app/helper/AnnouncementService.dart';
import 'package:most_app/helper/FridgeService.dart';
import 'package:most_app/helper/PointsService.dart';
import 'package:most_app/helper/navigation_provider.dart';
import 'package:most_app/screens/WelcomeScreen.dart';
import 'package:provider/provider.dart';
import 'helper/AuthService.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'helper/EventService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pl_PL', null);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  // runApp(ChangeNotifierProvider(
  //     create: (context) => AuthService(), child: const MyApp()));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()), // ⬅️ nowy
        ChangeNotifierProvider(
          create: (context) => AnnouncementsService(
            authService: context.read<AuthService>(), // jeśli potrzebujesz token
          ),
        ),
        // DODAJ TO:
        ChangeNotifierProxyProvider<AuthService, EventService>(
          create: (context) => EventService(context.read<AuthService>()),
          update: (context, auth, previous) => EventService(auth),
        ),
        ChangeNotifierProxyProvider<AuthService, FridgeService>(
          create: (context) => FridgeService(context.read<AuthService>()),
          update: (context, auth, previous) => FridgeService(auth),
        ),
        // ============================================
// 11. Dodaj do main.dart
        ChangeNotifierProxyProvider<AuthService, PointsService>(
          create: (context) => PointsService(context.read<AuthService>()),
          update: (context, auth, previous) => PointsService(auth),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Most App',

      // DODAJ TE 3 LINIE:
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pl', 'PL'), // Polski
        Locale('en', 'US'), // Angielski (fallback)
      ],
      locale: const Locale('pl', 'PL'),

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // theme: AppTheme.theme,
      home: WelcomeScreen(),
    );
  }
}


// Custom theme data for better styling
class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: const Color(0xFF1976D2),
      scaffoldBackgroundColor: Colors.grey[500],
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1976D2),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}