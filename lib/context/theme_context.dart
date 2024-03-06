import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeContext {
  static ThemeData from(BuildContext context) {
    return Theme.of(context).copyWith(
      cardTheme: CardTheme.of(context).copyWith(
        elevation: 5,
        color: const Color.fromRGBO(100, 65, 164, 1),
      ),
      navigationRailTheme: NavigationRailTheme.of(context).copyWith(
        unselectedIconTheme: const IconThemeData(
          color: Color.fromRGBO(33, 33, 33, 1),
        ),
        selectedIconTheme: const IconThemeData(
          color: Color.fromRGBO(33, 33, 33, 1),
        ),
      ),
      textTheme: TextTheme(
        bodySmall: GoogleFonts.getFont(
          'Lato',
          fontSize: 12,
          color: const Color.fromRGBO(225, 225, 225, 1),
          letterSpacing: 1,
        ),
        bodyMedium: GoogleFonts.getFont(
          'Lato',
          fontSize: 16,
          color: const Color.fromRGBO(225, 225, 225, 1),
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
        bodyLarge: GoogleFonts.getFont(
          'Lato',
          fontSize: 24,
          color: const Color.fromRGBO(33, 33, 33, 1),
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      iconTheme: IconTheme.of(context).copyWith(
        color: const Color.fromRGBO(33, 33, 33, 1),
      ),
    );
  }
}
