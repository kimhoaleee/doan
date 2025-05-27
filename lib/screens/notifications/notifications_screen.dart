// ignore_for_file: unreachable_switch_default, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/notification.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Sample notifications
  List<AppNotification> _notifications = [
    AppNotification(
      id: "1",
      title: "Order Delivered",
      message: "Your order #ORD-2023-001 has been delivered successfully.",
      time: DateTime.now().subtract(Duration(hours: 2)),
      type: NotificationType.order,
    ),
    AppNotification(
      id: "2",
      title: "Special Offer",
      message: "Get 20% off on all vegetables this weekend!",
      time: DateTime.now().subtract(Duration(days: 1)),
      type: NotificationType.promotion,
      isRead: true,
    ),
    AppNotification(
      id: "3",
      title: "New Products",
      message: "Check out our new organic fruits collection.",
      time: DateTime.now().subtract(Duration(days: 3)),
      type: NotificationType.info,
      isRead: true,
    ),
    AppNotification(
      id: "4",
      title: "Order Processing",
      message: "Your order #ORD-2023-004 is being processed.",
      time: DateTime.now().subtract(Duration(hours: 5)),
      type: NotificationType.order,
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      _notifications =
          _notifications.map((n) => n.copyWith(isRead: true)).toList();
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("All notifications marked as read")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Notifications", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.mark_email_read, color: Colors.black),
            onPressed: _markAllAsRead,
            tooltip: 'Mark all as read',
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return ListTile(
            leading: Icon(
              _getIcon(notification.type),
              color: notification.isRead ? Colors.grey : Colors.green,
            ),
            title: Text(
              notification.title,
              style: TextStyle(
                fontWeight:
                    notification.isRead ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            subtitle: Text(notification.message),
            trailing: Text(
              _formatTime(notification.time),
              style: TextStyle(fontSize: 12),
            ),
            tileColor: notification.isRead ? Colors.white : Colors.green[50],
          );
        },
      ),
    );
  }

  IconData _getIcon(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Icons.shopping_cart;
      case NotificationType.promotion:
        return Icons.local_offer;
      case NotificationType.info:
        return Icons.info;
      default:
        return Icons.notifications;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 1) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 1) {
      return "${difference.inHours} hours ago";
    } else {
      return "${difference.inMinutes} minutes ago";
    }
  }
}
