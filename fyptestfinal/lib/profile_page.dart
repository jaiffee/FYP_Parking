import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepPurpleAccent,
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
        child: ListView(
          children: [
            _buildProfileCard(
              'John Doe',
              'johndoe@example.com',
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
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(
      String title, String subtitle, IconData icon) {
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
}
