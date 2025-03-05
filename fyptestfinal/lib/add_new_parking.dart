import 'package:flutter/material.dart';
import 'api_service.dart'; // API service for provider signup

class AddNewParking extends StatefulWidget {
  const AddNewParking({super.key});

  @override
  _AddNewParkingState createState() => _AddNewParkingState();
}

class _AddNewParkingState extends State<AddNewParking> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each form field
 // final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  //final TextEditingController _nationalCardController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _parkingSpotController = TextEditingController();
  final TextEditingController _othersController = TextEditingController();
  //final TextEditingController _emailController = TextEditingController();
  //final TextEditingController _passwordController = TextEditingController();

  // Function to handle form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Create the provider data object
      final providerData = {
       // 'name': _nameController.text,
        'number': _numberController.text,
       // 'cardNum': _nationalCardController.text,
        'location': _locationController.text,
        'dayAndTime': _parkingSpotController.text,
        'perHourRate': _othersController.text,
        //'email': _emailController.text,
        //'password': _passwordController.text,
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
        title: const Text('Add New Parking Spot'),
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

                // Number Field
                TextFormField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
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

                // Location of Parking Field
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Exact Location of Parking',
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
                  controller: _parkingSpotController,
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

                // Working Days and Timings Field
                TextFormField(
                  controller: _othersController,
                  decoration: const InputDecoration(
                    labelText: 'Extra Security etc',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter here';
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
