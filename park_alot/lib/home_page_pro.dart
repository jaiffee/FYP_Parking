import 'package:flutter/material.dart';
import 'package:park_alot/main.dart';
import 'history_page.dart';
import 'profile_page_provider.dart';
import 'reservations_page.dart';
import 'api_service.dart';

class MainHomePage extends StatefulWidget {
  final String username;
  final int providerId;

  const MainHomePage({
    super.key,
    required this.username,
    required this.providerId,
  });

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      AddParkingPage(providerId: widget.providerId),
      HistoryPage(),
      ProfilePageParkingProvider(providerId: widget.providerId),
      ReservationsPage(),
    ];
  }

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
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Orders'),
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

class AddParkingPage extends StatefulWidget {
  final int providerId;

  AddParkingPage({Key? key, required this.providerId}) : super(key: key);

  @override
  State<AddParkingPage> createState() => _AddParkingPageState();
}

class _AddParkingPageState extends State<AddParkingPage> {
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  String? selectedCity;
  String? selectedAddress;

  List<String> cities = [];
  List<String> addresses = [];

  @override
  void initState() {
    super.initState();
    _fetchCities();
  }

  Future<void> _fetchCities() async {
    try {
      final result = await ApiService.getAllCities();
      if (result['success']) {
        setState(() {
          cities = List<String>.from(result['data']);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error fetching cities: $e')));
    }
  }

  Future<void> _fetchAddresses(String cityName) async {
    try {
      final result = await ApiService.getAddressesByCity(cityName);
      if (result['success']) {
        setState(() {
          addresses = List<String>.from(result['data']);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error fetching addresses: $e')));
    }
  }

  Future<void> _submitParking() async {
    String size = sizeController.text;
    String price = priceController.text;

    if (selectedCity == null ||
        selectedAddress == null ||
        size.isEmpty ||
        price.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    Map<String, dynamic> parkingSpot = {
      "location": selectedCity,
      "address": selectedAddress,
      "size": size,
      "price": price,
    };

    final result = await ApiService.addParking(parkingSpot, widget.providerId);

    if (result["success"]) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result["message"])));
      sizeController.clear();
      priceController.clear();
      setState(() {
        selectedCity = null;
        selectedAddress = null;
        addresses = [];
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result["message"])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Parking'),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Parking Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCity,
                items:
                    cities.map((city) {
                      return DropdownMenuItem(value: city, child: Text(city));
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                    selectedAddress = null;
                    addresses = [];
                  });
                  if (value != null) {
                    _fetchAddresses(value);
                  }
                },
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedAddress,
                items:
                    addresses.map((address) {
                      return DropdownMenuItem(
                        value: address,
                        child: Text(address),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAddress = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: sizeController,
                decoration: InputDecoration(
                  labelText: 'Size',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _submitParking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
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
