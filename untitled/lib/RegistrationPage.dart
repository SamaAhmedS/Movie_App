import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;


class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _email, _password;
  late String _filePath;


  @override
  void initState() {
    super.initState();
    _getFilePath(); // Initialize file path when app starts
  }

  // Get the external storage directory for saving the file
  Future<void> _getFilePath() async {
    try {
      final directory = await getExternalStorageDirectory(); // Get the external storage directory
      final assetsDirectory = Directory('${directory!.path}/registration data'); // Create the registration data folder
      if (!await assetsDirectory.exists()) {
        await assetsDirectory.create(); //Create the folder if it doesn't exist
      }
      setState(() {
        _filePath = '${assetsDirectory.path}/user_credentials.txt'; // Set the path for the text file
      });
    } catch (e) {
      print('Failed to get file path: $e');
    }
  }

  // Write data to the file
  Future<void> _writeToFile() async {
    try {
      final file = File(_filePath);
      String content = 'Name: $_name\nEmail: $_email\nPassword: $_password';
      await file.writeAsString(content);
      print('Data written to file: $_filePath');
    } catch (e) {
      print('Failed to write data to file: $e');
    }
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Save the user data to the file after registration
      _writeToFile();

      // Registration logic goes here
      print('Name: $_name, Email: $_email, Password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Unfocus the text fields
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/cinemaSplash.png'),
              fit: BoxFit.cover, // Cover the whole screen
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(3.0, 3.0), // Shadow offset
                            blurRadius: 5.0, // Blur radius
                            color: Colors.indigo.withOpacity(1), // Shadow color
                          ),
                          Shadow(
                            offset: Offset(-3.0, -3.0), // Shadow offset for more 3D effect
                            blurRadius: 5.0,
                            color: Colors.indigo.withOpacity(1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),

                    // Name Field
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.yellowAccent),
                        filled: true,
                        fillColor: Colors.black54,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
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
                    SizedBox(height: 20),

                    // Email Field
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.yellowAccent),
                        filled: true,
                        fillColor: Colors.black54, // Background color for the field
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
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
                    SizedBox(height: 20),

                    // Password Field
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.yellowAccent),
                        filled: true,
                        fillColor: Colors.black54, // Background color for the field
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
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
                    SizedBox(height: 40),

                    // Register Button
                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellowAccent, // Button color
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
