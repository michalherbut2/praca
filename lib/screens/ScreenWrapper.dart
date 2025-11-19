import 'package:flutter/material.dart';
import 'package:most_app/screens/AdminAddAnnouncementScreen.dart';
import 'package:most_app/screens/AdminAwardPointsScreen.dart';
import 'package:most_app/screens/AdminManageUsersScreen.dart';
import 'package:most_app/screens/ConstructionScreen.dart';
import 'package:most_app/screens/EventListScreen.dart';
import 'package:most_app/screens/EventsScreen.dart';
import 'package:provider/provider.dart';
import 'package:most_app/screens/CalendarScreen.dart';
import 'package:most_app/screens/FridgeScreen.dart';
import 'package:most_app/screens/HomeScreen.dart';
import 'package:most_app/screens/OrderIntentionScreen.dart';
import 'package:most_app/screens/ProfileScreen.dart';
import 'package:most_app/screens/SettingsScreen.dart';
import 'package:most_app/screens/AdminAddEventScreen.dart';
import 'package:most_app/widgets/AppDrawer.dart';
import 'package:most_app/widgets/MainAppBar.dart';
import 'package:most_app/helper/AuthService.dart';
import 'package:most_app/widgets/ProfileDialog.dart';

import '../helper/navigation_provider.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({super.key});

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  // int _selectedIndex = 0;
  //
  // int _previousIndex = 0;

  // Lista ekranów dostępnych dla wszystkich
  static const List<Widget> _guestScreens = <Widget>[
    HomeScreen(),                 // index 0
    CalendarScreen(),             // index 1
    ConstructionScreen(),         // index 2
    OrderIntentionScreen(),       // index 3
    SettingsScreen(),             // index 4
  ];

  // Lista ekranów tylko dla zalogowanych
  static const List<Widget> _userScreens = <Widget>[
    FridgeScreen(),               // index 5
    // EventsScreen(),               // index 6
    EventListScreen(),
    ProfileScreen()               // index 7
  ];

  // Lista ekranów tylko dla adminów
  static const List<Widget> _adminScreens = <Widget>[
    AdminAwardPointsScreen(),      // index 8
    AdminManageUsersScreen()        // index 9
  ];

  void _onDrawerItemTapped(int index) {
    // setState(() {
    //   _selectedIndex = index;
    // });
    context.read<NavigationProvider>().setIndex(index);

    Navigator.of(context).pop(); // Zamknij szufladę
  }

  final int _profileScreenIndex = 7;

  void _onProfileIconTapped() {
    final authService = context.read<AuthService>();
    final navigation = context.read<NavigationProvider>();

    if (authService.isLoggedIn) {
      // Jeśli user jest zalogowany, zmień body na ProfileScreen.
      setState(() {
        // if (_selectedIndex == _profileScreenIndex) {
        if (navigation.selectedIndex == _profileScreenIndex) {
          // [LOGIKA 1] Jesteśmy już na ekranie konta. Wróć do poprzedniego ekranu.
          // _selectedIndex = _previousIndex;
          navigation.setIndex(navigation.previousIndex);
        } else {
          // [LOGIKA 2] Przechodzimy na ekran konta. Zapisz, gdzie byliśmy.
          // _previousIndex = _selectedIndex;
          // _selectedIndex = _profileScreenIndex;
          navigation.setIndex(7);
        }
      });
    } else {
      // Jeśli nie, pokaż dialog logowania.
      showDialog(
        context: context,
        builder: (context) => const ProfileDialog(),
      );
    }
  }

  // // [NOWA METODA] Logika obsługi przycisku "wstecz"
  // Future<bool> _onWillPop() async {
  //   if (_selectedIndex == _profileScreenIndex) {
  //     // Jeśli jesteśmy na ekranie konta...
  //     setState(() {
  //       // ...wróć do poprzedniego ekranu.
  //       _selectedIndex = _previousIndex;
  //     });
  //     // Zwróć `false`, aby powiedzieć systemowi: "Nie zamykaj aplikacji,
  //     // ja już obsłużyłem to zdarzenie".
  //     return false;
  //   }
  //   // W każdym innym przypadku pozwól systemowi na domyślne zachowanie
  //   // (czyli zamknięcie aplikacji, bo jesteśmy na głównym ekranie).
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    // Pobieramy stan autentykacji, aby dynamicznie budować UI
    final authService = context.watch<AuthService>();

    // Łączymy listy ekranów w zależności od stanu zalogowania
    final allAvailableScreens = [
      ..._guestScreens,
      if (authService.isLoggedIn) ..._userScreens,
      // if (authService.isAdmin) ..._adminScreens, // Przykład dla adminów
      if (authService.isLoggedIn) ..._adminScreens, // Przykład dla adminów
    ];
    final navigation = context.watch<NavigationProvider>();

    return PopScope(
      // canPop: !(authService.isLoggedIn && _selectedIndex == _profileScreenIndex),
      canPop: !(authService.isLoggedIn && navigation.selectedIndex == _profileScreenIndex),

      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          return;
        }

        // setState(() {
        //   _selectedIndex = _previousIndex;
        // });
        context.read<NavigationProvider>().setIndex(navigation.previousIndex);
      },

      child: Scaffold(
        appBar: MainAppBar(onProfileIconPressed: _onProfileIconTapped,),
        endDrawer: AppDrawer(
          isLoggedIn: authService.isLoggedIn,
          onIndexSelect: _onDrawerItemTapped,
        ),
        // Tutaj dzieje się magia: ciało Scaffolda to wybrany ekran z listy

      // body: allAvailableScreens[_selectedIndex],
        body: allAvailableScreens[navigation.selectedIndex],

      ),
    );
  }
}
