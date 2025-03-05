import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'api_service.dart'; // API service for taker signup

class ParkingTakerPage extends StatefulWidget {
  const ParkingTakerPage({super.key});

  @override
  _ParkingTakerPageState createState() => _ParkingTakerPageState();
}

class _ParkingTakerPageState extends State<ParkingTakerPage> {
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  File? _cnicImage;
  File? _profileImage;

  // Function to pick image from camera or gallery
  Future<void> _pickImage(bool isCnic) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera, // Change to ImageSource.gallery if needed
      imageQuality: 80, // Reduce quality to optimize performance
    );

    if (pickedFile != null) {
      setState(() {
        if (isCnic) {
          _cnicImage = File(pickedFile.path);
        } else {
          _profileImage = File(pickedFile.path);
        }
      });
    }
  }

  // Controllers for each form field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _drivingLicenseController =
      TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _carNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Taker'),
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

                // Driving License Field
                TextFormField(
                  controller: _drivingLicenseController,
                  decoration: const InputDecoration(
                    labelText: 'Driving License Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your driving license number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // National ID Field
                TextFormField(
                  controller: _nationalIdController,
                  decoration: const InputDecoration(
                    labelText: 'National ID Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your National ID number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Car Number Field
                TextFormField(
                  controller: _carNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Car Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your car number';
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

                _buildUploadCard(
              'CNIC Picture',
              true,
            ),
            const SizedBox(height: 16),

            _buildUploadCard(
              'upload your live picture',
              true,
            ),
            const SizedBox(height: 16),

                // Submit Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Gather the data to send to the backend
                      final providerData = {
                        "name": _nameController.text,
                        "number": _numberController.text,
                        "licNum": _drivingLicenseController.text,
                        "idNum": _nationalIdController.text,
                        "carNum": _carNumberController.text,
                        "email": _emailController.text,
                        "password": _passwordController.text,
                      };

                      // Call the API to sign up the taker
                      final response =
                          await ApiService.takerSignup(providerData);

                      if (response["success"] == true) {
                        // Show success dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Success'),
                            content: const Text('Parking taker registered!'),
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
                        // Show error dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: Text(response["message"]),
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
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent, // Corrected here
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

Widget _buildUploadCard(String title, bool isCnic) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            // Display selected image
            Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.deepPurpleAccent, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: (isCnic ? _cnicImage : _profileImage) != null
                  ? Image.file(
                      isCnic ? _cnicImage! : _profileImage!,
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: Text(
                        "No Image Selected",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _pickImage(isCnic),
              icon: const Icon(Icons.camera_alt),
              label: const Text("Capture Image"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
