import 'package:check_inspecao_app/app/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  //AppTheme(BuildContext context);
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    _isDarkTheme = false;
    final themeBase = ThemeData.light();
    return themeBase.copyWith(
      primaryColor: CustomColors.orange,
      appBarTheme: AppBarTheme(backgroundColor: CustomColors.darkBlue),
      brightness: Brightness.light,
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: CustomColors.pink),
    );
  }

  static ThemeData get darkTheme {
    final themeBase = ThemeData.dark();
    return themeBase.copyWith(
        primaryColor: CustomColors.darkBlue,
        backgroundColor: CustomColors.lightBlue,
        appBarTheme: AppBarTheme(backgroundColor: CustomColors.darkBlue));
  }
}
