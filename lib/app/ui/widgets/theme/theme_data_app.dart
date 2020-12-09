import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  final _primaryColor = Color.fromRGBO(35, 35, 142, 1);
  final _primaryColorDark = Color.fromRGBO(0, 0, 156, 1);
  final _primaryColorLight = Color.fromRGBO(50, 50, 205, 1);

  final _textTheme = TextTheme(
    headline1: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: _primaryColorDark,
    ),
  );

  final _inputDecorationTheme = InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: _primaryColorLight,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: _primaryColorDark,
      ),
    ),
  );

  final _buttonTheme = ButtonThemeData(
    colorScheme: ColorScheme.light(
      primary: _primaryColor,
    ),
    buttonColor: _primaryColor,
    splashColor: _primaryColorLight,
    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
  );

  return ThemeData(
    primaryColor: _primaryColor,
    primaryColorDark: _primaryColorDark,
    primaryColorLight: _primaryColorLight,
    accentColor: _primaryColor,
    backgroundColor: Colors.white,
    textTheme: _textTheme,
    inputDecorationTheme: _inputDecorationTheme,
    buttonTheme: _buttonTheme,
  );
}
