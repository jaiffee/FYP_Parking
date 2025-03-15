import 'package:flutter/material.dart';
import 'user_preferences.dart';
import 'api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _profileData; // To store profile data
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeProfile();
  }

  Future<void> _initializeProfile() async {
    try {
      final userId = await UserPreferences.getUserId(); // Resolve Future here
      if (userId != 0) {
        _fetchProfile(userId.toString());
      } else {
        setState(() {
          _errorMessage = "User ID not found. Please log in.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred while fetching the User ID: $e";
      });
    }
  }

  Future<void> _fetchProfile(String userId) async {
    print("Fetching profile for userId: $userId"); // Debug log
    try {
      final profileResponse = await ApiService.getProfile(userId);

      if (profileResponse["success"] == true) {
        print("Profile data: ${profileResponse["data"]}"); // Debug log
        setState(() {
          _profileData = profileResponse["data"];
        });
      } else {
        setState(() {
          _errorMessage = profileResponse["message"];
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred: $e";
      });
    }
  }

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
        child: _profileData != null
            ? ListView(
                children: [
                  _buildProfileCard('Name', _profileData!['name'] ?? 'N/A',
                      Icons.account_circle),
                  const SizedBox(height: 16),
                  _buildProfileCard(
                      'Email', _profileData!['email'] ?? 'N/A', Icons.email),
                  const SizedBox(height: 16),
                  _buildProfileCard(
                      'Phone', _profileData!['phone'] ?? 'N/A', Icons.phone),
                  const SizedBox(height: 16),
                  _buildProfileCard('Address',
                      _profileData!['address'] ?? 'N/A', Icons.location_on),
                ],
              )
            : Center(
                child: _errorMessage == null
                    ? const CircularProgressIndicator()
                    : Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
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
}
