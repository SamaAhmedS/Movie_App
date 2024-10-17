import 'package:flutter/material.dart';
import 'package:the_project/movies_page.dart';
import 'splashPage.dart';
import 'movie_details_page.dart';
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