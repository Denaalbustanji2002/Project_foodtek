import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../cubits/ThemeCubit.dart';

class NotificationWidget extends StatelessWidget implements PreferredSizeWidget {
  @override


  NotificationWidget({Key? key, })
      : preferredSize = Size.fromHeight(70.0),
        super(key: key);

  final List<Notification> notifications = [
    Notification(title: 'New Order', message: 'You have a new order', timestamp: DateTime.now()),
    Notification(title: 'New Order', message: 'You have a new order', isRead: true, timestamp: DateTime.now()),
    Notification(title: 'New Order', message: 'You have a new order', timestamp: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: AppBar(
            toolbarHeight: preferredSize.height,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(

                padding: EdgeInsets.only(
                  top: 20.0,
                  right: 16.0,
                  left: 16.0,
                ),
                child: Column(
                    children: [
                      Container(
                        width: 368.0,
                        height: 48.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Spacer(),

                            IconButton(
                              icon: Icon(Icons.notifications_outlined),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                  ),
                                  builder: (context) => NotificationDialog(notifications: notifications),
                                );
                              },
                            ),
                          ],
                        ),
                      ),])



            )));}

  final Size preferredSize;



}

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

class NotificationDialog extends StatefulWidget {
  final List<Notification> notifications;

  const NotificationDialog({super.key, required this.notifications});

  @override
  _NotificationDialogState createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
        return widget.notifications.where((n) => !n.isRead).toList();
      case 2:
        return widget.notifications.where((n) => n.isRead).toList();
      default:
        return widget.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().isDarkMode;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert_outlined,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: Color(0xFF2CDA5E),
            unselectedLabelColor: isDarkMode ? Colors.grey[600] : Colors.grey,
            indicatorColor: Color(0xFF2CDA5E),
            isScrollable: false,
            indicatorWeight: 1.0,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.symmetric(horizontal: 0),
            padding: EdgeInsets.symmetric(horizontal: 100),
            tabs: [Tab(text: 'All'), Tab(text: 'Unread'), Tab(text: 'Read')],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNotificationList(0, isDarkMode),
                _buildNotificationList(1, isDarkMode),
                _buildNotificationList(2, isDarkMode),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList(int tabIndex, bool isDarkMode) {
    final filteredNotifications = _filterNotifications(tabIndex);
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 7),
      itemCount: filteredNotifications.length,
      itemBuilder: (context, index) {
        final notification = filteredNotifications[index];
        return NotificationItem(
          notification: notification,
          isDarkMode: isDarkMode,
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
  final bool isDarkMode;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: notification.isRead
          ? (isDarkMode ? Colors.grey[850] : Colors.white)
          : (isDarkMode ? Colors.grey[800] : Color(0xFFF1F6FC)),
      child: ListTile(
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            Text(
              DateFormat('yyyy-MM-dd – HH:mm').format(notification.timestamp),
              style: TextStyle(
                color: isDarkMode ? Colors.grey[400] : Colors.grey,
                fontSize: 12,
              ),
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