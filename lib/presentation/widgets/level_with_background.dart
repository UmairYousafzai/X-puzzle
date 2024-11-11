import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpuzzle/presentation/theme/colors.dart';

Widget levelWithBackground(String level) {
  return Container(
    width: 73,
    height: 22,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(52),
        color: const Color(0x33F78C0C)),
    child: Center(
        child: Text(
      level,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: MColors().colorSecondaryOrangeDark,
      ),
    )),
  );
}
