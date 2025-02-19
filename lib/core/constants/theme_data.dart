import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[300],
    brightness: Brightness.light,
    fontFamily: 'Cairo',
    colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: Colors.grey[200]!,
        secondary: Colors.black,
        tertiary: Colors.white24));

final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: 'Cairo',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: Colors.grey[900]!,
        secondary: Colors.white,
        tertiary: Colors.grey[800]));
