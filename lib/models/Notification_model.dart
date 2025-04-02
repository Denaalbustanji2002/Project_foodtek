class NotificationModel {
  final String title;
  final String message;
  bool isRead;
  final DateTime timestamp;

  NotificationModel({
    required this.title,
    required this.message,
    this.isRead = false,
    required this.timestamp,
  });
}