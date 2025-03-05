import 'package:flutter/material.dart';
import 'package:fyptestfinal/add_new_parking.dart';

class ParkingListingPage extends StatefulWidget {
  const ParkingListingPage({super.key});

  @override
  _ParkingListingPageState createState() => _ParkingListingPageState();
}

class _ParkingListingPageState extends State<ParkingListingPage> {
  List<Map<String, String>> parkingList = [
    {
      'location': 'Downtown Parking',
      'timing': 'Mon-Fri, 9 AM - 6 PM',
      'security': 'CCTV, Guarded'
    },
    {
      'location': 'Mall Basement',
      'timing': '24/7',
      'security': 'CCTV, Well-lit'
    },
  ];

  void _navigateToAddParking() async {
    final newParking = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewParking()),
    );

    if (newParking != null) {
      setState(() {
        parkingList.add(newParking);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Listings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: parkingList.length,
        itemBuilder: (context, index) {
          final parking = parkingList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(parking['location'] ?? 'Unknown Location'),
              subtitle: Text(
                'Timing: ${parking['timing']}\nSecurity: ${parking['security']}',
              ),
              trailing: const Icon(Icons.directions_car),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddParking,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
