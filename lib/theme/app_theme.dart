import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpuzzle/theme/colors.dart';

final ThemeData theme = ThemeData(
  useMaterial3: true,

  colorScheme: ColorScheme.fromSeed(
    seedColor: MColors().colorPrimary,
    brightness: Brightness.dark,
  ),

  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
        color: Colors.black

    ),

    titleLarge: GoogleFonts.balooDa2(
      fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.black

    ),

    titleSmall: GoogleFonts.balooDa2(
      fontSize:14,
        color: Colors.black

    ),

    titleMedium: GoogleFonts.balooDa2(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),

    bodyMedium: GoogleFonts.balooDa2(
        color: Colors.black
    ),

    displaySmall: GoogleFonts.balooDa2(
        color: Colors.black

    ),

  ),
);
