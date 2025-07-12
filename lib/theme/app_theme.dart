import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 16, 11, 116),
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 11, 8, 81),
      secondary: Color.fromARGB(255, 206, 49, 13),
      surface: Colors.white,
      background: Color(0xFFF5F7FA),
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F7FA),
    cardColor: Colors.white,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: const Color(0xFF2D3748),
      displayColor: const Color(0xFF2D3748),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 21, 17, 94),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 79, 77, 124),
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 99, 174, 255),
      secondary: Color(0xFF4D8DEE),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
