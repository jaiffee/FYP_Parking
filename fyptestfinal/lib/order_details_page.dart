// order_details_page.dart
import 'package:flutter/material.dart';

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
        title: const Text("Order Details"),
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
          ],
        ),
      ),
    );
  }
}
