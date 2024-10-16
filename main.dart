
import 'package:flutter/material.dart';
import 'RegistrationPage.dart';
import 'splashPage.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splashpage(),
      debugShowCheckedModeBanner: false,
    );
  }
}