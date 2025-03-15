import 'dart:async';
import 'package:flutter/material.dart';
import 'api_service.dart';

class ProfilePageParkingProvider extends StatefulWidget {
  final int providerId; // Provider ID for API call

  const ProfilePageParkingProvider({super.key, required this.providerId});

  @override
  _ProfilePageParkingProviderState createState() =>
      _ProfilePageParkingProviderState();
}

class _ProfilePageParkingProviderState
    extends State<ProfilePageParkingProvider> {
  Map<String, dynamic>? _profileData; // Stores fetched profile data
  String? _errorMessage; // Stores error messages

  @override
  void initState() {
    super.initState();
    _fetchProfile(widget.providerId.toString());
  }

  Future<void> _fetchProfile(String providerId) async {
    try {
      final profileResponse = await ApiService.getProviderProfile(providerId);

      if (profileResponse["success"] == true) {
        setState(() {
          _profileData = profileResponse["data"];
          _errorMessage = null; // Clear any previous error messages
        });
      } else {
        setState(() {
          _profileData = null; // Clear previous data
          _errorMessage =
              profileResponse["message"] ?? "Unknown error occurred.";
        });
      }
    } catch (e) {
      setState(() {
        _profileData = null; // Clear previous data
        _errorMessage = "An error occurred: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Provider Profile'),
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
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_profileData != null) {
      return ListView(
        children: [
          _buildProfileCard(
              'Provider Name', _profileData!['name'], Icons.account_circle),
          const SizedBox(height: 16),
          _buildProfileCard('Email', _profileData!['email'], Icons.email),
          const SizedBox(height: 16),
          _buildProfileCard('Phone', _profileData!['phone'], Icons.phone),
          const SizedBox(height: 16),
          _buildProfileCard(
              'Address', _profileData!['address'], Icons.location_on),
          const SizedBox(height: 16),
          _buildProfileCard(
            'Parking Spaces',
            _profileData!['spaces']?.toString() ?? 'N/A',
            Icons.local_parking,
          ),
        ],
      );
    } else if (_errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildProfileCard(String title, String? subtitle, IconData icon) {
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
                    subtitle ?? 'N/A',
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
