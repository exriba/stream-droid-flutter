import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream_droid_app/core/utils/local_storage.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:stream_droid_app/core/utils/dependency_manager.dart';

const backgroundColorKey = 'backgroundColor';

class ThemeContext extends ChangeNotifier {
  ThemeContext() {
    _localStorage = DependencyManager.getIt.get<ILocalStorage>();
  }
  late ILocalStorage _localStorage;

  Color? _backgroundColor;
  static const Color defaultNavigationColor = Color(0xFF616161);
  static const Color defaultBackgroundColor = Color(0xFF212121);
  static const Color _defaultCardColor = Color(0xFF6441A4);
  static const Color _smallFontColor = Color.fromRGBO(225, 225, 225, 1);

  Color get backgroundColor {
    if (_backgroundColor != null) {
      return _backgroundColor!;
    }

    final value = _localStorage.read(key: backgroundColorKey);
    _backgroundColor =
        value != null ? Color(int.parse(value)) : defaultBackgroundColor;
    return _backgroundColor!;
  }

  void updateBackgroundColor(Color color) {
    _localStorage.write(key: backgroundColorKey, value: '0x${color.hexAlpha}');
    _backgroundColor = color;
    notifyListeners();
  }

  static ThemeData from(BuildContext context) {
    return Theme.of(context).copyWith(
        cardTheme: CardTheme.of(context).copyWith(
          elevation: 5,
          color: _defaultCardColor,
        ),
        navigationRailTheme: NavigationRailTheme.of(context).copyWith(
          unselectedIconTheme: const IconThemeData(
            color: defaultBackgroundColor,
          ),
          selectedIconTheme: const IconThemeData(
            color: defaultBackgroundColor,
          ),
        ),
        textTheme: TextTheme(
          bodySmall: GoogleFonts.getFont(
            'Lato',
            fontSize: 12,
            color: _smallFontColor,
            letterSpacing: 1,
          ),
          bodyMedium: GoogleFonts.getFont(
            'Lato',
            fontSize: 16,
            color: _smallFontColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
          bodyLarge: GoogleFonts.getFont(
            'Lato',
            fontSize: 24,
            color: defaultBackgroundColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        iconTheme: IconTheme.of(context).copyWith(
          color: defaultBackgroundColor,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: defaultBackgroundColor,
          foregroundColor: defaultBackgroundColor,
        ));
  }
}
