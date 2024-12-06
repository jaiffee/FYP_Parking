import 'package:flutter/material.dart';
import 'api_service.dart'; // API service for provider signup

class ParkingProviderPage extends StatefulWidget {
  const ParkingProviderPage({super.key});

  @override
  _ParkingProviderPageState createState() => _ParkingProviderPageState();
}

class _ParkingProviderPageState extends State<ParkingProviderPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each form field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _nationalCardController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _workingDaysController = TextEditingController();
  final TextEditingController _perHourRateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to handle form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Create the provider data object
      final providerData = {
        'name': _nameController.text,
        'number': _numberController.text,
        'cardNum': _nationalCardController.text,
        'location': _locationController.text,
        'dayAndTime': _workingDaysController.text,
        'perHourRate': _perHourRateController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      };

      try {
        // Send the data to the server
        final response = await ApiService.providerSignup(providerData);

        if (response['success'] == true) {
          // Show success message
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Success'),
              content: const Text('Parking provider data saved!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          // Show error message
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(response['message'] ?? 'Something went wrong'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (error) {
        // Handle any errors (e.g., network errors)
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to save data. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Provider'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Number Field
                TextFormField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: 'Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // National Card Number Field
                TextFormField(
                  controller: _nationalCardController,
                  decoration: const InputDecoration(
                    labelText: 'National Card Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your National Card Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Location of Parking Field
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location of Parking',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the parking location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Working Days and Timings Field
                TextFormField(
                  controller: _workingDaysController,
                  decoration: const InputDecoration(
                    labelText: 'Working Days and Timings',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter working days and timings';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Per Hour Rate Field
                TextFormField(
                  controller: _perHourRateController,
                  decoration: const InputDecoration(
                    labelText: 'Per Hour Rate',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the per hour rate';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
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

                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
