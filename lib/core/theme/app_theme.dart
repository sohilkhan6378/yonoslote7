import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildLightTheme() {
  final base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: const Color(0xFF8B3FFC),
      secondary: const Color(0xFF00C2A8),
      error: Colors.redAccent,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
    appBarTheme: const AppBarTheme(centerTitle: true),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(120, 48),
      ),
    ),
  );
}

ThemeData buildDarkTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: const Color(0xFFBB86FC),
      secondary: const Color(0xFF03DAC6),
      error: Colors.redAccent,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(120, 48),
      ),
    ),
  );
}
