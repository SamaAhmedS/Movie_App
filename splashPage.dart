import 'registrationPage.dart'; // Import your RegistrationPage here
import 'package:flutter/material.dart';

class Splashpage extends StatelessWidget {
  const Splashpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RegistrationPage()), // Navigate to RegistrationPage
          );
        },
        child: Stack(
          children: [
            // Background image
            SizedBox.expand(
              child: Image.asset(
                'assets/images/cinemaSplash.png',
                fit: BoxFit.cover,
              ),
            ),
            // Welcome text split into two lines
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
                          offset: Offset(3.0, 3.0), // Shadow offset
                          blurRadius: 5.0, // Blur radius
                          color: Colors.indigo.withOpacity(1), // Shadow color
                        ),
                        Shadow(
                          offset: Offset(-3.0, -3.0), // Shadow offset for 3D effect
                          blurRadius: 5.0,
                          color: Colors.indigo.withOpacity(1), // Shadow color
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
                          offset: Offset(3.0, 3.0), // Shadow offset
                          blurRadius: 5.0, // Blur radius
                          color: Colors.indigo.withOpacity(1), // Shadow color
                        ),
                        Shadow(
                          offset: Offset(-3.0, -3.0), // Shadow offset for 3D effect
                          blurRadius: 5.0,
                          color: Colors.indigo.withOpacity(1), // Shadow color
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
