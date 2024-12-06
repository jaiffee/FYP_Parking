import 'package:flutter/material.dart';
import 'history_page.dart';
import 'profile_page_taker.dart';
import 'reservations_page.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;

  // Define the list of pages corresponding to each BottomNavigationBar item
  final List<Widget> _pages = [
    const OrdersPage(),
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
        ],
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
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
            _buildOrderCard(
              context,
              'John Doe',
              'Toyota Corolla',
              '2:00 PM - 4:00 PM',
              'Order #001',
            ),
            const SizedBox(height: 16),
            _buildOrderCard(
              context,
              'Jane Smith',
              'Honda Civic',
              '5:00 PM - 7:00 PM',
              'Order #002',
            ),
            const SizedBox(height: 16),
            _buildOrderCard(
              context,
              'Michael Johnson',
              'Ford Mustang',
              '3:00 PM - 5:00 PM',
              'Order #003',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, String userName, String carModel,
      String orderTime, String orderId) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white.withOpacity(0.9),
      child: ListTile(
        leading: const Icon(
          Icons.car_repair,
          color: Colors.deepPurpleAccent,
          size: 40,
        ),
        title: Text(
          '$userName - $carModel',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        subtitle: Text(
          'Time: $orderTime\nOrder ID: $orderId',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsPage(
                userName: userName,
                carModel: carModel,
                orderTime: orderTime,
                orderId: orderId,
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrderDetailsPage extends StatelessWidget {
  final String userName;
  final String carModel;
  final String orderTime;
  final String orderId;

  const OrderDetailsPage({
    super.key,
    required this.userName,
    required this.carModel,
    required this.orderTime,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
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
              'Order ID: $orderId',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'User: $userName',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              'Car Model: $carModel',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              'Order Time: $orderTime',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const Divider(color: Colors.white54, thickness: 1),
            const SizedBox(height: 12),
            const Text(
              'Facilities & Extra Services: ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            // Add other order details here
          ],
        ),
      ),
    );
  }
}
