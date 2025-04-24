import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import HomePage
import 'signup_page.dart'; // Import SignUpPage
import 'login_page_pro.dart'; // Import the new login page for parking provider
import 'api_service.dart'; // Import the ApiService to call the login endpoint
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch:
        Colors.deepPurple, // Set to deep purple to align with the theme
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Function to save userId in Hive
  Future<void> _saveUserId(int userId) async {
    var box = await Hive.openBox('userBox'); // Open a Hive box
    await box.put('userId', userId); // Save userId to the box
    print('User ID saved globally: $userId');
  }

  // Function to handle login
  void _login() async {
    setState(() {
      _isLoading = true;
    });

    // Call the taker login API
    final response = await ApiService.takerLogin({
      "email": _emailController.text,
      "password": _passwordController.text,
    });

    setState(() {
      _isLoading = false;
    });

    if (response['success'] == true) {
      // Retrieve userId and username from API response
      final String username = response['username'] ?? 'Guest';
      final int userId = response['id'];

      // Save userId to Hive
      await _saveUserId(userId);

      // Clear the input fields after successful login
      _emailController.clear();
      _passwordController.clear();

      // Navigate to the HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(username: username, userId: userId)),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response['message']),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor:
        Colors.deepPurpleAccent, // Match the deep purple accent theme
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            Center(
              child: Image.asset(
                'lib/assets/logo.png', // Path to the logo image
                width: 300, // Adjust size as needed
                height: 100,
              ),
            ),
            const SizedBox(height: 9), // Space between logo and text fields

            // Added "Login as a Parking Taker" text
            const Text(
              'Login as a Parking Taker',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16), // Space between text and text field

            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email/Number',
                labelStyle: TextStyle(color: Colors.black), // Black label text
                filled: true,
                fillColor: Colors.white, // White background
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                  color: Colors.black), // Black text inside the field
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 9),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black), // Black label text
                filled: true,
                fillColor: Colors.white, // White background
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                  color: Colors.black), // Black text inside the field
              obscureText: true,
            ),
            const SizedBox(height: 9),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                Colors.deepPurpleAccent, // Keep the original color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Navigate to SignUpPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
              child: const Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16), // Space between buttons
            TextButton(
              onPressed: () {
                // Navigate to the new login page for parking providers
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPagePro()),
                );
              },
              child: const Text(
                'Login as a Parking Provider',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
