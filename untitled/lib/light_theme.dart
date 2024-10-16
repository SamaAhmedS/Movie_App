import 'package:flutter/material.dart';
AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: Colors.orange,
  foregroundColor: Colors.white
);
FloatingActionButtonThemeData fab = const FloatingActionButtonThemeData(
  backgroundColor: Colors.blue,
  foregroundColor: Colors.purple
);


ElevatedButtonThemeData elevatedButtonTheme =  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white
    )

);
IconButtonThemeData iconButtonThemeData = IconButtonThemeData(

);

TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(color: Colors.red[900], fontWeight: FontWeight.bold),
    titleMedium: const TextStyle(color: Colors.blue),
    labelLarge: TextStyle(color: Colors.indigo[800]),
    bodyMedium: TextStyle(color: Colors.grey[700]),
);