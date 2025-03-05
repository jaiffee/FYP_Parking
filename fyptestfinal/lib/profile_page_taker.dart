import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProfileCard(
              'waqas',
              'waqas@example.com',
              Icons.account_circle,
            ),
            const SizedBox(height: 16),
            _buildProfileCard(
              'Phone Number',
              '+1 123 456 7890',
              Icons.phone,
            ),
            const SizedBox(height: 16),
            _buildProfileCard(
              'Address',
              '123 Main Street, City, Country',
              Icons.location_on,
            ),
            const SizedBox(height: 16),
            _buildProfileCard(
              'Date of Birth',
              '01/01/1990',
              Icons.calendar_today,
            ),
            const SizedBox(height: 16),
            _buildProfileCard(
              'CNIC',
              '12345-6789012-3',
              Icons.badge,
            ),
            const SizedBox(height: 16),
            _buildUploadCard(
              'CNIC Picture',
              'Upload CNIC Picture',
              Icons.camera_alt,
            ),
            const SizedBox(height: 16),
            _buildUploadCard(
              'upload your live picture',
              'upload your picture ',
              Icons.drive_eta,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(String title, String subtitle, IconData icon) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.deepPurpleAccent,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadCard(String title, String buttonText, IconData icon) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.deepPurpleAccent,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Implement file upload logic
                      _showUploadDialog();
                    },
                    icon: const Icon(Icons.upload_file),
                    label: Text(buttonText),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUploadDialog() {
    // Implement your file upload dialog logic here
    print("Upload button clicked!");
  }
}
