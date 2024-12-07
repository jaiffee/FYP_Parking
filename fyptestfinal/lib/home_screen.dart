import 'package:flutter/material.dart';
import 'history_page.dart';
import 'profile_page_taker.dart';
import 'reservations_page.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Define the list of pages corresponding to each BottomNavigationBar item
  final List<Widget> _pages = [
    const BookingPage(),
    const HistoryPage(),
    const ProfilePage(),
    const ReservationsPage(),
  ];

  // Update the page content based on selected index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              'Parkalot',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.deepPurpleAccent,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurpleAccent, Colors.purple],
                ),
              ),
              child: Center(
                child: Text(
                  widget.username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.call, color: Colors.deepPurpleAccent),
              title: const Text('SOS Call'),
              onTap: () {
                // Implement SOS Call logic here
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('SOS Call'),
                    content: const Text('Calling Emergency Services...'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help, color: Colors.deepPurpleAccent),
              title: const Text('Help Center'),
              onTap: () {
                // Navigate to Help Center Page
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelpCenterPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.deepPurpleAccent),
              title: const Text('About Company'),
              onTap: () {
                // Navigate to About Company Page
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutCompanyPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.deepPurpleAccent),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurpleAccent,
        selectedItemColor: Colors.yellowAccent,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Reservation',
          ),
        ],
      ),
    );
  }
}

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
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
            _buildBookingCard(
              context,
              'Central Park Parking',
              '2:00 PM - 6:00 PM',
              '\$5/hour',
              'ParkEasy',
            ),
            const SizedBox(height: 16),
            _buildBookingCard(
              context,
              'Downtown Mall Parking',
              '10:00 AM - 4:00 PM',
              '\$3/hour',
              'SafePark',
            ),
            const SizedBox(height: 16),
            _buildBookingCard(
              context,
              'Beachside Resort Parking',
              '8:00 AM - 8:00 PM',
              '\$7/hour',
              'BeachSecure',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, String location, String time,
      String rate, String provider) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white.withOpacity(0.9),
      child: ListTile(
        leading: const Icon(
          Icons.local_parking,
          color: Colors.deepPurpleAccent,
          size: 40,
        ),
        title: Text(
          location,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        subtitle: Text(
          'Time: $time\nRate: $rate\nProvider: $provider',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ParkingProviderDetailsPage(
                location: location,
                provider: provider,
                time: time,
                rate: rate,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ParkingProviderDetailsPage extends StatelessWidget {
  final String location;
  final String provider;
  final String time;
  final String rate;

  const ParkingProviderDetailsPage({
    super.key,
    required this.location,
    required this.provider,
    required this.time,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Details'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location: $location',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Provider: $provider',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              'Time: $time',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              'Rate: $rate',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const Divider(color: Colors.white54, thickness: 1),
            const SizedBox(height: 12),
            const Text(
              'Facilities & Extra Services:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '- CCTV Surveillance\n- EV Charging Stations\n- Covered Parking\n- Security Guards',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const Divider(color: Colors.white54, thickness: 1),
            const SizedBox(height: 12),
            const Text(
              'Customer Reviews:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.star, color: Colors.yellowAccent),
                Icon(Icons.star, color: Colors.yellowAccent),
                Icon(Icons.star, color: Colors.yellowAccent),
                Icon(Icons.star_half, color: Colors.yellowAccent),
                Icon(Icons.star_border, color: Colors.yellowAccent),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '"Great service and convenient location!"\n- User123',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: null, // Placeholder; non-functional
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: null, // Placeholder; non-functional
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                  ),
                  child: const Text(
                    'Reserve for Later',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: const Center(
        child: Text(
          'This is the Help Center Page.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class AboutCompanyPage extends StatelessWidget {
  const AboutCompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Company'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: const Center(
        child: Text(
          'This is the About Company Page.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
