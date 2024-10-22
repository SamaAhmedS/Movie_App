import 'package:flutter/material.dart';
import 'themes.dart';
import 'splashPage.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Flutter Demo',
    theme: lightTheme,
    darkTheme: darkTheme,
    themeMode: ThemeMode.system,
      home: Splashpage(),
      debugShowCheckedModeBanner: false,
    );
  }
}