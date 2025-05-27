import 'package:flutter/material.dart';

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime time;
  final NotificationType type;
  final bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });

  // ✅ Hàm copyWith để cập nhật trạng thái isRead
  AppNotification copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? time,
    NotificationType? type,
    bool? isRead,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }
}

enum NotificationType { order, promotion, info }

extension NotificationTypeExtension on NotificationType {
  IconData get icon {
    switch (this) {
      case NotificationType.order:
        return Icons.shopping_bag;
      case NotificationType.promotion:
        return Icons.local_offer;
      case NotificationType.info:
        return Icons.info;
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.order:
        return Colors.blue;
      case NotificationType.promotion:
        return Colors.orange;
      case NotificationType.info:
        return Colors.green;
    }
  }
}
