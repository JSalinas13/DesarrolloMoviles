import 'package:flutter/material.dart';

class ThemeSettings {
  // Método para obtener el tema personalizado
  static ThemeData customTheme(
      Color _primaryColor, Color _accentColor, String _selectedFont) {
    final theme = ThemeData.light();
    return theme.copyWith(
      scaffoldBackgroundColor: _primaryColor,
      primaryColor: _primaryColor, // Color primario guardado
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: _accentColor, // Color de acento guardado
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor, // Color del AppBar personalizado
        foregroundColor:
            Colors.white, // Color del texto y de los íconos en el AppBar
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:
            _primaryColor, // Color de fondo del BottomNavigationBar
        selectedItemColor: _accentColor, // Color del ítem seleccionado
        unselectedItemColor: Colors.white, // Color del ítem no seleccionado
      ),
      textTheme: theme.textTheme.apply(
        fontFamily: _selectedFont, // Fuente seleccionada
      ),
    );
  }

  static ThemeData darkTheme() {
    final theme = ThemeData.dark();
    return theme.copyWith();
  }

  static ThemeData warmTheme() {
    final theme = ThemeData.light();
    return theme.copyWith();
  }
}
