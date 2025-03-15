import 'package:flutter/material.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations'),
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
            _buildReservationCard(
              'Reservation 1',
              'Reserved by John Doe',
              '12/12/2024, 2:00 PM',
              Icons.event,
              context,
            ),
            const SizedBox(height: 16),
            _buildReservationCard(
              'Reservation 2',
              'Reserved by Jane Smith',
              '13/12/2024, 5:00 PM',
              Icons.event,
              context,
            ),
            const SizedBox(height: 16),
            _buildReservationCard(
              'Reservation 3',
              'Reserved by David Lee',
              '14/12/2024, 7:00 PM',
              Icons.event,
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationCard(String title, String subtitle, String dateTime,
      IconData icon, BuildContext context) {
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
                  const SizedBox(height: 8),
                  Text(
                    dateTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.deepPurpleAccent,
              ),
              onPressed: () {
                // Navigate to the detailed reservation page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationDetailsPage(
                      title: title,
                      subtitle: subtitle,
                      dateTime: dateTime,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReservationDetailsPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateTime;

  const ReservationDetailsPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation Details'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reservation Title: $title',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Reserved By: $subtitle',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              'Date & Time: $dateTime',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white54, thickness: 1),
            const SizedBox(height: 12),
            const Text(
              'Cancellation Policy:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You can cancel your reservation up to 24 hours before the scheduled time.',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white54, thickness: 1),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Implement cancellation functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.redAccent, // Corrected to backgroundColor
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Cancel Reservation'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement confirmation functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 0, 255, 17), // Corrected to backgroundColor
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Extend Reservation'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
