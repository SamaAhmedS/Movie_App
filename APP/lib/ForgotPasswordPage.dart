import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _phone, _email, _newPassword;
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

  Future<bool> _checkUserCredentials(String name,String phone, String email) async {
    try {
      final file = File(_filePath);
      String content = await file.readAsString();
      List<String> lines = content.split('\n');

      String? storedName;
      String? storedPhone;
      String? storedEmail;

      for (var line in lines) {
        if (line.startsWith('Name:')) {
          storedName = line.substring(6).trim();
        } else if (line.startsWith('Email:')) {
          storedEmail = line.substring(7).trim();
        }else if (line.startsWith('Phone Number:')) {
          storedPhone = line.substring(14).trim();
        }
      }

      if (storedName == name && storedEmail == email && storedPhone == phone) {
        return true;
      }
    } catch (e) {
      print('Failed to read user credentials: $e');
    }

    return false;
  }

  Future<void> _updatePassword() async {
    try {
      final file = File(_filePath);
      String content = await file.readAsString();
      List<String> lines = content.split('\n');

      for (int i = 0; i < lines.length; i++) {
        if (lines[i].startsWith('Password:')) {
          lines[i] = 'Password: $_newPassword';
          break;
        }
      }

      await file.writeAsString(lines.join('\n'));
      print('Password updated successfully');
    } catch (e) {
      print('Failed to update password: $e');
    }
  }

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      bool isValidUser = await _checkUserCredentials(_name!, _phone!, _email!);
      if (isValidUser) {
        _updatePassword();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password updated successfully')),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid username or email')),
        );
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
                  children: [
                    const SizedBox(height: 150),
                    Text(
                      'Reset your password',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 30,
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
                    const SizedBox(height: 16),

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
                    const SizedBox(height: 16),
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
                        } else
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    const SizedBox(height: 20),

                    // New Password Field
                    TextFormField(
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                      decoration: InputDecoration(
                        labelText: 'New Password',
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
                          return 'Please enter a new password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newPassword = value;
                      },
                    ),
                    const SizedBox(height: 40),

                    // Reset Password Button
                    ElevatedButton(
                      onPressed: _resetPassword,
                      child: const Text('Reset Password'),
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
