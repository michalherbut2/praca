import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final Function(int) onIndexSelect;

  final bool isLoggedIn;

  const AppDrawer({super.key, required this.onIndexSelect, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    // Wysokość AppBar, żeby menu nie nachodziło na niego
    final appBarHeight = kToolbarHeight + MediaQuery.of(context).padding.top;

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        margin: EdgeInsets.only(top: appBarHeight),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(-2, 4),
            ),
          ],
          borderRadius: BorderRadius.zero, // kwadratowe rogi
        ),
        child: Material(
          elevation: 12,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              _menuButton('STRONA GŁÓWNA', index: 0,
                isMain: true,
              ),
              // const SizedBox(height: 24),
              _divider(),
              _menuButton('KALENDARZ', index: 1),
              _divider(),
              if (isLoggedIn) ...[
              _menuButton('LODÓWKA', index: 5),
              _divider(),
                _menuButton('ZAPISY', index: 6),
              _divider(),
                _menuButton('Daj Punkty', index: 8),
              _divider(),
                _menuButton('Edytuj usera', index: 9),
              _divider(),
              ],
              _menuButton('KONSTRUKCJA', index: 2),
              _divider(),
              _menuButton('ZAMÓW INTENCJĘ', index: 3),
              _divider(),
              _menuButton('USTAWIENIA', index: 4, last: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() => Divider(
    color: Colors.blue.shade200,
    thickness: 1,
    indent: 32,
    endIndent: 32,
  );

  Widget _menuButton(
      String title, {
        required int index,
        bool last = false,
        bool isMain = false,
      }) {
    return ListTile(
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.blue,
            fontSize: isMain ? 22 : 18,
            fontWeight: isMain ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
      onTap: () {
        onIndexSelect(index);
      },
    );
  }
}