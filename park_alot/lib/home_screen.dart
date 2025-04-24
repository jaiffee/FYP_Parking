import 'package:flutter/material.dart';
import 'package:park_alot/map_screen.dart';
import 'history_page.dart';
import 'profile_page_taker.dart';
import 'reservations_page.dart';
import 'main.dart';
import 'api_service.dart';
import 'user_preferences.dart';

class HomePage extends StatefulWidget {
  final String username;
  final int userId;

  const HomePage({
    super.key,
    required this.username,
    required this.userId,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Define the list of pages corresponding to each BottomNavigationBar item
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    // Add pages to the list, passing the userId to ProfilePage
    _pages.addAll([
      BookingPage(),
      HistoryPage(),
      ProfilePage(), // Pass userId here
      ReservationsPage(),
    ]);
  }

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
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              'Parkalot',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurpleAccent, Colors.purple],
                ),
              ),
              child: Center(
                child: Text(
                  widget.username,
                  style: TextStyle(
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
                  builder:
                      (context) => AlertDialog(
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
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Booking'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Reservation',
          ),
        ],
      ),
    );
  }
}

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<dynamic> parkingData = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchParkingData();
  }

  Future<void> fetchParkingData() async {
    try {
      // Call the getAllParking API
      Map<String, dynamic> response = await ApiService.getAllParking();

      if (response["success"] == true) {
        // Update the state with fetched data
        setState(() {
          parkingData = response['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = response['message'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch parking data.';
        isLoading = false;
      });
    }
  }

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
        child:
            isLoading
                ? const Center(
                  child: CircularProgressIndicator(),
                ) // Show loader while fetching
                : errorMessage.isNotEmpty
                ? Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ) // Show error message if any
                : ListView.builder(
                  itemCount: parkingData.length,
                  itemBuilder: (context, index) {
                    final parking = parkingData[index];
                    return Column(
                      children: [
                        _buildBookingCard(
                          context,
                          parking['location'], // Location from API
                          parking['size'], // Size from API
                          '${parking['price']}', // Price from API (without $)
                          // Price from API
                          parking['id'], // Pass the parking ID here
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
      ),
    );
  }

  Widget _buildBookingCard(
    BuildContext context,
    String location,
    String size,
    String price,
    int parkingId,
  ) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
          'Size: $size\nPrice: $price',
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
        onTap: () {
          // Navigate to the ParkingProviderDetailsPage (adjust fields as needed)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ParkingProviderDetailsPage(parkingId: parkingId),
            ),
          );
        },
      ),
    );
  }
}

class ParkingProviderDetailsPage extends StatefulWidget {
  final int parkingId;

  const ParkingProviderDetailsPage({Key? key, required this.parkingId})
    : super(key: key);

  @override
  State<ParkingProviderDetailsPage> createState() =>
      _ParkingProviderDetailsPageState();
}

class _ParkingProviderDetailsPageState
    extends State<ParkingProviderDetailsPage> {
  Map<String, dynamic>? parkingDetails;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchParkingDetails();
  }

  Future<void> fetchParkingDetails() async {
    try {
      // Call the getParkingById API
      Map<String, dynamic> response = await ApiService.getParkingById(
        widget.parkingId,
      );

      if (response["success"] == true) {
        setState(() {
          parkingDetails = response['data'];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = response['message'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch parking details.';
        isLoading = false;
      });
    }
  }

  Future<void> bookParking() async {
    // Fetch the takerId from SharedPreferences using UserPreferences
    final takerId = await UserPreferences.getUserId();

    // Replace with actual values or user input for these fields
    final bookingDetails = {
      "takerId": takerId, // Get takerId from SharedPreferences
      "parkingSpotId": widget.parkingId, // Use parkingId from widget
      "startTime": "2024-12-27T10:00:00", // Replace with dynamic start time
      "endTime": "2024-12-27T12:00:00", // Replace with dynamic end time
    };

    try {
      // Call the booking API
      Map<String, dynamic> response = await ApiService.bookNow(bookingDetails);

      if (response["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Booking successful: ${response['message']}"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${response['message']}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to book parking. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(parkingDetails?['location'] ?? 'Loading...'),
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
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
                : _buildParkingDetails(),
      ),
    );
  }

  Widget _buildParkingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location: ${parkingDetails!['location']}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Size: ${parkingDetails!['size']}',
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Text(
          'Price: ${parkingDetails!['price']}',
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),

        Text(
          'Address: ${parkingDetails!['address']}',
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
        const Spacer(),
        ElevatedButton(
          onPressed: bookParking,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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

        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          child: const Text(
            'Cancel Booking',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Reservation Form'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: const InputDecoration(labelText: 'Date'),
                      ),
                      TextField(
                        decoration: const InputDecoration(labelText: 'Hours'),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(onPressed: () {}, child: const Text('Submit')),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          child: const Text(
            'Reservation',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => MapScreen(
                      address: '${parkingDetails?['address'] ?? ""}',
                    ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          child: const Text(
            'Find Location',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
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
