import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_project/ForgotPasswordPage.dart';
import 'RegistrationPage.dart';
import 'bottom_nav_container.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String _filePath;

  @override
  void initState() {
    super.initState();
    _getFilePath(); // Initialize file path when app starts
  }

  Future<void> _getFilePath() async {
    try {
      final directory = await getExternalStorageDirectory();
      final assetsDirectory = Directory('${directory!.path}/registration data');
      if (!await assetsDirectory.exists()) {
        await assetsDirectory.create();
      }
      setState(() {
        _filePath = '${assetsDirectory.path}/user_credentials.txt';
      });
    } catch (e) {
      print('Failed to get file path: $e');
    }
  }

  Future<bool> _authenticateUser(String email, String password) async {
    try {
      final file = File(_filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        List<String> userBlocks = contents.split('---'); // Split based on user blocks

        for (var block in userBlocks) {
          String? savedEmail, savedPassword;
          List<String> lines = block.trim().split('\n'); // Split block into lines

          for (var line in lines) {
            if (line.startsWith('Email:')) {
              savedEmail = line.replaceFirst('Email: ', '').trim();
            } else if (line.startsWith('Password:')) {
              savedPassword = line.replaceFirst('Password: ', '').trim();
            }
          }

          // Check if this block's email and password match the user input
          if (savedEmail == email && savedPassword == password) {
            return true;
          }
        }
      }
    } catch (e) {
      print('Error reading user data: $e');
    }
    return false;
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      bool isAuthenticated = await _authenticateUser(email, password);

      if (isAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login Successful!'),
        ));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
          return BottomNavContainer();
        }));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid email or password.'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/cinemaSplash.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: const Offset(3.0, 3.0), // Shadow offset
                            blurRadius: 5.0, // Blur radius
                            color: Theme.of(context).primaryColor,
                          ),
                          Shadow(
                            offset: const Offset(-3.0, -3.0),
                            blurRadius: 5.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 175),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Theme.of(context).iconTheme.color),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        filled: true,
                        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).iconTheme.color),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        filled: true,
                        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ));
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 15),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return RegistrationPage();
                        }));
                      },
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
