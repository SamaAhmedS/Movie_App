import 'package:flutter/material.dart';
import 'RegistrationPage.dart';
import 'movies_page.dart';
import 'movie_details_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Login Successful!'),
      ));
      // // ** navigate to home page **
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return MoviesPage(isLoggedIn: true, isFavoritePage: false);
      }));
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
    offset: Offset(-3.0, -3.0),
    // Shadow offset for more 3D effect
    blurRadius: 5.0,
    color: Colors.indigo.withOpacity(1),
    ),
    ],
    ),
    ),
    const SizedBox(height: 175),
    TextFormField(
    controller: emailController,
    decoration: InputDecoration(
    prefixIcon: const Icon(Icons.email),
    labelText: 'Email',
    labelStyle: TextStyle(color: Colors.yellowAccent),
    filled: true,
    fillColor: Colors.black54,
    // Background color for the field
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,

    ),
    errorStyle: TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 14,
    ),

    ),
    style: TextStyle(
    color: Colors.white,
    ),
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
    prefixIcon: const Icon(Icons.lock_outline),
    labelText: 'Password',
    labelStyle: TextStyle(color: Colors.yellowAccent),
    filled: true,
    fillColor: Colors.black54,
    // Background color for the field
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide.none,
    ),
      errorStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    ),
    style: TextStyle(color: Colors.grey),
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
    const SizedBox(height: 50),
    ElevatedButton(
    onPressed: _login,
    style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
    ),
    padding: const EdgeInsets.symmetric(
    horizontal: 80, vertical: 15),
    backgroundColor: Colors.yellowAccent,
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
    child: const Text(
    'Sign up',
    style: TextStyle(
    fontSize: 16,
    color: Colors.yellowAccent,
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    ]
    ,
    )
    ,
    );
  }
}
