import 'package:flutter/material.dart';
 class AppTheme {


   final ThemeData _lightTheme = ThemeData(
  );

  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
  );

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;

}
