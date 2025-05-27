// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import '../../constants.dart';

class Order {
  final String id;
  final DateTime date;
  final String status;
  final double total;
  final int itemCount;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.itemCount,
  });
}

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({Key? key}) : super(key: key);

  // Sample orders
  final List<Order> _orders = [
    Order(
      id: "ORD-2023-001",
      date: DateTime.now().subtract(Duration(days: 2)),
      status: "Delivered",
      total: 45.80,
      itemCount: 3,
    ),
    Order(
      id: "ORD-2023-002",
      date: DateTime.now().subtract(Duration(days: 5)),
      status: "Delivered",
      total: 32.50,
      itemCount: 2,
    ),
    Order(
      id: "ORD-2023-003",
      date: DateTime.now().subtract(Duration(days: 10)),
      status: "Delivered",
      total: 78.20,
      itemCount: 5,
    ),
    Order(
      id: "ORD-2023-004",
      date: DateTime.now().subtract(Duration(hours: 5)),
      status: "Processing",
      total: 56.70,
      itemCount: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Order History", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _orders.isEmpty ? _buildEmptyOrderHistory() : _buildOrderList(),
    );
  }

  Widget _buildEmptyOrderHistory() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: defaultPadding),
          Text(
            "No orders yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: defaultPadding / 2),
          Text(
            "Start shopping to see your orders here",
            style: TextStyle(color: Colors.grey.shade500),
          ),
          SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              // Navigate to home screen
            },
            child: Text("Start Shopping"),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
      padding: EdgeInsets.all(defaultPadding),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(_orders[index]);
      },
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: EdgeInsets.only(bottom: defaultPadding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.id,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                _buildStatusBadge(order.status),
              ],
            ),
            SizedBox(height: defaultPadding / 2),
            Text(
              "Ordered on ${_formatDate(order.date)}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${order.itemCount} items",
                  style: TextStyle(color: Colors.black87),
                ),
                Text(
                  "\$${order.total.toStringAsFixed(2)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: defaultPadding),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // View order details
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text("View Details"),
                  ),
                ),
                SizedBox(width: defaultPadding),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Reorder functionality
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text("Reorder"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor;

    switch (status) {
      case "Delivered":
        badgeColor = Colors.green;
        break;
      case "Processing":
        badgeColor = Colors.orange;
        break;
      case "Cancelled":
        badgeColor = Colors.red;
        break;
      default:
        badgeColor = Colors.blue;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: badgeColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
