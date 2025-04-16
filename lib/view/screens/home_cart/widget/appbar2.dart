import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../cubits/ThemeCubit.dart';

class Appbar2 extends StatelessWidget implements PreferredSizeWidget {
  @override


Appbar2({Key? key, })
      : preferredSize = Size.fromHeight(90.0),
        super(key: key);

  final List<Notification> notifications = [
    Notification(title: 'New Order', message: 'You have a new order', timestamp: DateTime.now()),
    Notification(title: 'New Order', message: 'You have a new order', isRead: true, timestamp: DateTime.now()),
    Notification(title: 'New Order', message: 'You have a new order', timestamp: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return  AppBar(

      toolbarHeight: preferredSize.height,
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(

        padding: EdgeInsets.only(
          top: 20.0,
          right: 16.0,
          left: 16.0,
        ),
        child: Column(

          children: [
            SizedBox(height: 20),
            Container(
              width: 368.0,
              height: 48.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // الصورة في الـ AppBar
                  Container(
                    width: 50.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Notif.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 10),
                  // النص والعناصر الأخرى في الـ AppBar
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jl. Soekarno Hatta 15A Malang",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF101010),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18,
                              color: Color(0xFF606060),
                            ),
                            SizedBox(width: 1),
                            Text(
                              "Current location",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF606060),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 18,
                              color: Color(0xFF606060),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  // زر الإشعارات
                  IconButton(
                    color: isDarkMode ? Colors.white : Colors.black,
                    icon: Icon(Icons.notifications_outlined),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
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



        ));}

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