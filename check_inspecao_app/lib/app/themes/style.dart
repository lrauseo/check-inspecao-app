import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Style {
  //Cor Primaria Padrao
  static Color get _getCorPrimaria => Color(0xff5CC6BA);
  //TextField arredondado
  static OutlineInputBorder _getRoundedBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(50.0),
      ),
    );
  }

  //botao arredondado
  static ButtonThemeData _getRoundedButton() {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    );
  }

  //Padrao botao ElevatedButton
  static ElevatedButtonThemeData _getRoundedElevatedButton() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(_getCorPrimaria),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
    );
  }

  //tema claro
  static ThemeData themeData(BuildContext context) {
    var base = ThemeData.light();
    base = base.copyWith(primaryColor: _getCorPrimaria);
    base = base.copyWith(
        textTheme:
            base.textTheme.copyWith(headline5: TextStyle(color: Colors.white)),
        primaryColor: _getCorPrimaria,
        inputDecorationTheme: base.inputDecorationTheme.copyWith(
          border: _getRoundedBorder(),
        ),
        buttonTheme: _getRoundedButton(),
        elevatedButtonTheme: _getRoundedElevatedButton());
    return base;
  }

  //tema escuro
  static ThemeData themeDataDark(BuildContext context) {
    var base = ThemeData.dark();
    base = base.copyWith(
        textTheme:
            base.textTheme.copyWith(headline5: TextStyle(color: Colors.white)),
        primaryColor: _getCorPrimaria,
        inputDecorationTheme: base.inputDecorationTheme.copyWith(
          border: _getRoundedBorder(),
        ),
        buttonTheme: _getRoundedButton(),
        elevatedButtonTheme: _getRoundedElevatedButton());
    return base;
  }
}
