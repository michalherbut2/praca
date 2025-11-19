import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String text;
  final Color color;
  final double thickness;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const SectionHeader({
    super.key,
    required this.text,
    this.color = Colors.blue,
    this.thickness = 1.0,
    this.fontSize = 20.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(thickness: thickness, color: color),
        ),
        Padding(
          padding: padding,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Divider(thickness: thickness, color: color),
        ),
      ],
    );
  }
}

// Row(
// children: [
// Expanded(
// child: Divider(
// color: blueColor.withOpacity(0.5),
// thickness: 1,
// endIndent: 12,
// ),
// ),
// const Text(
// 'Ogólny plan tygodnia',
// style: TextStyle(
// fontSize: 16,
// color: blueColor,
// fontWeight: FontWeight.w500,
// ),
// ),
// Expanded(
// child: Divider(
// color: blueColor.withOpacity(0.5),
// thickness: 1,
// indent: 12,
// ),
// ),
// ],
// ),