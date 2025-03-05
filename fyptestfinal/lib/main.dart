import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import HomePage
import 'signup_page.dart'; // Import SignUpPage
import 'login_page_pro.dart'; // Import the new login page for parking provider
import 'api_service.dart'; // Import the ApiService to call the login endpoint

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF422672, // Deep purple color value
          <int, Color>{
            50: Color(0xFFE1D4F7),
            100: Color(0xFFD1A9E0),
            200: Color(0xFFB57CC9),
            300: Color(0xFF9A4FC4),
            400: Color(0xFF8737BF),
            500: Color(0xFF422672), // Main deep purple color
            600: Color(0xFF3B2263),
            700: Color(0xFF331E59),
            800: Color(0xFF2A1950),
            900: Color(0xFF1E1441),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false, // This removes the debug banner
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
      // Handle successful login (e.g., navigate to another screen)
      final String username = response['username'] ?? 'Guest';
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(username: username)),
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
