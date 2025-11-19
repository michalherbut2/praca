import 'package:flutter/material.dart';
import 'package:most_app/styles/Colors.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final double fontSize;

  const ScreenHeader({
    super.key,
    required this.title,
    this.fontSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Column(
          children: [
            Container(
              height: 2,
              margin: const EdgeInsets.only(bottom: 6),
              color: headerTextColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                title,
                style: TextStyle(
                  color: headerTextColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Container(
              height: 2,
              margin: const EdgeInsets.only(top: 6, bottom: 18),
              color: headerTextColor,
            ),
          ],
        ),
      ),
    );
  }
}