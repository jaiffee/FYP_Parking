import 'package:flutter/material.dart';
import 'api_service.dart'; // Import ApiService for API calls
import 'home_page_pro.dart'; // Assuming this is where you navigate after a successful login

class LoginPagePro extends StatefulWidget {
  const LoginPagePro({super.key});

  @override
  State<LoginPagePro> createState() => _LoginPageProState();


}

class _LoginPageProState extends State<LoginPagePro> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      // Show error if fields are empty
      _showError("Please enter both email and password.");
      return;

    }

    // Prepare data for login
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password,
      
    };

    try {
      final response = await ApiService.providerLogin(
          loginData); // Call the provider login API

      if (response["success"] == true) {
        // If login is successful, navigate to HomePagePro
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainHomePage()),
        );
      } else {
        // If login fails, show an error message
        _showError(response["message"]);
      }
    } catch (e) {
      // Handle any other errors (like network issues)
      _showError("An error occurred. Please try again.");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Provider'),
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
                labelText: 'Email',
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
            ElevatedButton(
              onPressed: _login, // Call the login function
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
          ],
        ),
      ),
    );
  }
}
