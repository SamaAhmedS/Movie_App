import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_project/LoginPage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _phone, _email, _password;
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

  Future<void> _writeToFile() async {
    try {
      final file = File(_filePath);
      String content = 'Name: $_name\nEmail: $_email\nPassword: $_password\nPhone Number: $_phone';
      await file.writeAsString(content);
      print('Data written to file: $_filePath');
    } catch (e) {
      print('Failed to write data to file: $e');
    }
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _writeToFile().then((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
      print('Name: $_name, Email: $_email, Password: $_password, Phone Number: $_phone');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/cinemaSplash.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Title
                        Text(
                          'Register',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: const Offset(3.0, 3.0),
                                blurRadius: 5.0,
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
                        const SizedBox(height: 40),

                        // Name Field
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                          decoration: InputDecoration(
                            labelText: 'Name',
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Phone Number Field
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
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
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(value)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _phone = value;
                          },
                        ),

                        const SizedBox(height: 20),

                        // Email Field
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                          decoration: InputDecoration(
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Password Field
                        TextFormField(
                          style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                          decoration: InputDecoration(
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
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value;
                          },
                        ),
                        const SizedBox(height: 40),

                        // Register Button
                        ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }));
                          },
                          child: Text(
                            'Log in',
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
            ),
          ),
        ),
      ),
    );
  }
}