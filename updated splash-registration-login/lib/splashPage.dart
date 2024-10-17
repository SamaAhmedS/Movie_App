import 'dart:async';
import 'package:flutter/material.dart';
import 'LoginPage.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  _SplashpageState createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/cinemaSplash.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                    shadows: [
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                        color: Colors.indigo.withOpacity(1),
                      ),
                      Shadow(
                        offset: Offset(-3.0, -3.0),
                        blurRadius: 5.0,
                        color: Colors.indigo.withOpacity(1),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Flick Finder',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellowAccent,
                    shadows: [
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 5.0,
                        color: Colors.indigo.withOpacity(1),
                      ),
                      Shadow(
                        offset: Offset(-3.0, -3.0),
                        blurRadius: 5.0,
                        color: Colors.indigo.withOpacity(1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
