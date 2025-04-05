import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notification {
  final String title;
  final String message;
  bool isRead;
  final DateTime timestamp;

  Notification({
    required this.title,
    required this.message,
    this.isRead = false,
    required this.timestamp,
  });
}

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Notification> notifications = [
    Notification(title: 'New Order', message: 'You have a new order', timestamp: DateTime.now()),
    Notification(title: 'Update', message: 'System update available', isRead: true, timestamp: DateTime.now().subtract(Duration(hours: 2))),
    Notification(title: 'Reminder', message: 'Meeting at 5PM', timestamp: DateTime.now().subtract(Duration(days: 1))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Notification> _filterNotifications(int tabIndex) {
    switch (tabIndex) {
      case 1:
        return notifications.where((n) => !n.isRead).toList();
      case 2:
        return notifications.where((n) => n.isRead).toList();
      default:
        return notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.notifications_active_outlined),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: Color(0xFF2CDA5E),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF2CDA5E),
            indicatorWeight: 1.0,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Unread'),
              Tab(text: 'Read'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotificationList(0),
                _buildNotificationList(1),
                _buildNotificationList(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(int tabIndex) {
    final filteredNotifications = _filterNotifications(tabIndex);
    return ListView.builder(
      itemCount: filteredNotifications.length,
      itemBuilder: (context, index) {
        final notification = filteredNotifications[index];
        return NotificationItem(
          notification: notification,
          onTap: () {
            setState(() {
              notification.isRead = true;
            });
          },
        );
      },
    );
  }
}

class NotificationItem extends StatelessWidget {
  final Notification notification;
  final VoidCallback onTap;

  const NotificationItem({Key? key, required this.notification, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: notification.isRead ? Colors.white : Color(0xFFF1F6FC),
      child: ListTile(
        title: Text(notification.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification.message),
            Text(
              DateFormat('yyyy-MM-dd – HH:mm').format(notification.timestamp),
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        trailing: notification.isRead
            ? Icon(Icons.done, color: Colors.green)
            : Icon(Icons.circle, color: Colors.blue, size: 12),
        onTap: onTap,
      ),
    );
  }
}
