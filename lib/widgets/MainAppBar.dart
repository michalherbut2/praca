import 'package:flutter/material.dart';
import 'package:most_app/helper/AuthService.dart';
import 'package:most_app/helper/navigation_provider.dart';
import 'package:provider/provider.dart';

import '../styles/Colors.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onProfileIconPressed;

  const MainAppBar({super.key, required this.onProfileIconPressed});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final user = authService.user;

    final String? pictureUrl = user?.pictureUrl;

    return AppBar(
      backgroundColor: buttonTextColor,
      foregroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
          style: IconButton.styleFrom(
            shape: const CircleBorder(),
          ),
          onPressed: onProfileIconPressed,
          icon: (pictureUrl != null && pictureUrl.isNotEmpty)
              ? CircleAvatar(
                  radius: 50, backgroundImage: NetworkImage(pictureUrl))
              : const Icon(Icons.person_outline, size: 40)),

      // KROK 1: Owijamy Twój Row w GestureDetector
      title: GestureDetector(
        onTap: () {
          // KROK 2: Mówimy providerowi, żeby wrócił na HomeScreen (index 0)
          context.read<NavigationProvider>().setIndex(0);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logos/png/logo_MOST.png',
              width: 125,
              height: 38,
            ),
          ],
        ),
      ),
    );
  }
}
