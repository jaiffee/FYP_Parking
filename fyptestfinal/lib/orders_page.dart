import 'package:flutter/material.dart';
import 'order_details_page.dart'; // Make sure this import is correct

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // Ensure OrderDetailsPage is properly imported and has correct parameters
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
