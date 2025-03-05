import 'package:flutter/material.dart';
import 'package:fyptestfinal/parking_listing.dart';
import 'orders_page.dart'; // Import the new OrdersPage file
import 'history_page.dart';
import 'profile_page_taker.dart';
import 'reservations_page.dart';
import 'main.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;
  String _userName = "John Doe";  // Example user name. You can set this dynamically

  // Define the list of pages corresponding to each BottomNavigationBar item
  final List<Widget> _pages = [
    const OrdersPage(),
    const HistoryPage(),
    const ProfilePage(),
    const ReservationsPage(),
    const ParkingListingPage()
  ];

  // Update the page content based on selected index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Handle logout
  void _handleLogout() {
  // Your logout logic here, such as clearing user session
  // For now, just show a snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Logged out successfully')),
  );

  // Navigate back to main.dart (assuming main.dart contains your entry point)
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const MyApp()), // Assuming MyApp is your main entry point
  );
}


  // Handle SOS call
  void _handleSOSCall() {
    // Your SOS logic here, like making an emergency call
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('SOS call initiated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parkalot'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: _pages[_selectedIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header with user name
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurpleAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _userName, // Displaying user name
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            // SOS Call Button
            ListTile(
              leading: const Icon(Icons.phone_in_talk, color: Colors.red),
              title: const Text('SOS Call'),
              onTap: _handleSOSCall,
            ),
            // Logout Button
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: _handleLogout,
            ),
          ],
        ),
      ),
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
            icon: Icon(Icons.receipt),
            label: 'Orders',
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

          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Parking Listing',
          ),
        ],
      ),
    );
  }
}
