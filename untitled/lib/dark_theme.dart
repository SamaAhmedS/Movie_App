import 'package:flutter/material.dart';

AppBarTheme appBarThemeDark = AppBarTheme(
    backgroundColor: Colors.yellow,
    foregroundColor: Colors.black
);

FloatingActionButtonThemeData fabDark = const FloatingActionButtonThemeData(
    backgroundColor: Colors.tealAccent,
    foregroundColor: Colors.white
);





ElevatedButtonThemeData elevatedButtonDarkTheme =  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white70,
        foregroundColor: Colors.white
    )

);

TextTheme textThemeDark = TextTheme(
  titleLarge:
  const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
  titleMedium: const TextStyle(color: Colors.green),
  labelLarge: TextStyle(color: Colors.yellow[300]),
  bodyMedium: const TextStyle(color: Colors.white),
);