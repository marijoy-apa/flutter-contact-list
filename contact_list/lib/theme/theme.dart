import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';


var kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: const Color.fromARGB(255, 190, 190, 190),
  background: const Color.fromARGB(255, 255, 255, 255),
  primaryContainer: const Color.fromARGB(255, 220, 220, 220),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 54, 54, 57),
  background: const Color.fromARGB(255, 68, 66, 70),
  primaryContainer: const Color.fromARGB(255, 40, 40, 40),
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  colorScheme: kColorScheme,
  primaryColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kColorScheme.primaryContainer,
      unselectedItemColor: Colors.black38),
  iconTheme: const IconThemeData(color: Colors.black45),
  textTheme: GoogleFonts.robotoFlexTextTheme().copyWith(
    titleSmall: GoogleFonts.robotoFlex(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.robotoFlex(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.robotoFlex(
      fontWeight: FontWeight.bold,
    ),
  ),
);

final darkTheme = ThemeData().copyWith(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
  colorScheme: kDarkColorScheme,
  primaryColor: Colors.black,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kDarkColorScheme.primaryContainer,
      unselectedItemColor: Colors.white30),
  iconTheme: const IconThemeData(color: Colors.white60),
  textTheme: GoogleFonts.robotoFlexTextTheme().copyWith(
    titleSmall: GoogleFonts.robotoFlex(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.robotoFlex(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.robotoFlex(
      fontWeight: FontWeight.bold,
    ),
  ),
);