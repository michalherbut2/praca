import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:most_app/widgets/ScreenHeader.dart';
import 'package:most_app/helper/AuthService.dart';
import 'package:most_app/styles/Colors.dart';

import '../models/AppUser.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final user = authService.user!;

    // final String? pictureUrl = user.pictureUrl;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(title: "PROFIL"),
          // Center(
          //   child: CircleAvatar(
          //     radius: 50,
          //     backgroundImage: (pictureUrl != null && pictureUrl.isNotEmpty)
          //         ? NetworkImage(pictureUrl)
          //         : null,
          //     child: pictureUrl!.isEmpty
          //         ? const Icon(Icons.person, size: 50)
          //         : null,
          //   ),
          // ),
          const SizedBox(height: 32),
          Text(
            user.name,
            style: TextStyle(
              color: blueColor,
              fontSize: 38,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Twoje punkty: ',
                style: TextStyle(
                  color: blueColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                user.points.toString(),
                style: TextStyle(
                  color: blueColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          StreamBuilder<AppUser>(
            stream: context.read<AuthService>().streamUser(user.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              final user = snapshot.data!;
              return Text('Witaj ${user.name}, masz ${user.points} punktów');
            },
          ),
          const SizedBox(height: 28),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: blueColor,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
              ),
              children: [
                const TextSpan(text: 'Korzystasz z aplikacji jako: '),
                TextSpan(
                  text: user.role,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12, right: 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    SizedBox(height: 487), // ← Twoja zawartość
                                  ],
                                ),
                              ),
                              // X close button
                              Positioned(
                                top: 4,
                                right: 4,
                                child: IconButton(
                                  icon: Icon(Icons.close, size: 40, color: blueColor),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 6, bottom: 2),
                      child: CircleAvatar(
                        radius: 13,
                        backgroundColor: Colors.grey.shade300,
                        child: Text(
                          '?',
                          style: TextStyle(
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
