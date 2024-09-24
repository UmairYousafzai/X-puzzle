import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpuzzle/theme/colors.dart';

final theme = ThemeData(
  useMaterial3: true,

// Define the default brightness and colors.
  colorScheme: ColorScheme.fromSeed(
    seedColor: MColors().colorPrimary,
    brightness: Brightness.dark,
  ),

  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),

    titleLarge: GoogleFonts.balooDa2(
      fontSize: 30,
      fontStyle: FontStyle.italic,
    ),

    titleSmall: GoogleFonts.balooDa2(
      fontSize:14
    ),

    titleMedium: GoogleFonts.balooDa2(
      fontSize: 20,
      fontWeight: FontWeight.bold
    ),

    bodyMedium: GoogleFonts.balooDa2(),
    displaySmall: GoogleFonts.balooDa2(),
  ),
);
