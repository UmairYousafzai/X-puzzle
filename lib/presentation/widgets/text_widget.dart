import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const TextWidget({
    Key? key,
    required this.text,
    this.color = Colors.black, // Default color is black
    this.fontSize = 14.0, // Default font size
    this.fontWeight = FontWeight.normal, // Default font weight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
