import 'package:flutter/material.dart';

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
      iconTheme: IconTheme.of(context).copyWith(
        color: const Color.fromRGBO(33, 33, 33, 1),
      ),
    );
  }
}
