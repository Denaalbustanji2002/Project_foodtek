import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../core/screen_index.dart';
import '../../cubits/ThemeCubit.dart';
import '../../cubits/navigatiion_cubit.dart' show NavigationCubit;
import '../screens/home_cart/screen/filter_item.dart';


// إنشاء الـ CustomAppBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({Key? key})
    : preferredSize = Size.fromHeight(150.0),
      super(key: key);

  final List<Notification> notifications = [
    Notification(
      title: 'New Order',
      message: 'You have a new order',
      timestamp: DateTime.now(),
    ),
    Notification(
      title: 'New Order',
      message: 'You have a new order',
      isRead: true,
      timestamp: DateTime.now(),
    ),
    Notification(
      title: 'New Order',
      message: 'You have a new order',
      timestamp: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeCubit>().isDarkMode;
    return AppBar(
      toolbarHeight: preferredSize.height,
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: 25.0, right: 16.0, left: 32.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              width: 368.0,
              height: 48.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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

                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jl. Soekarno Hatta 15A Malang",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDarkMode ? Colors.white : Color(0xFF101010),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18,
                              color: isDarkMode ? Colors.grey[400] : Color(0xFF606060),
                            ),
                            SizedBox(width: 1),
                            Text(
                              "Current location",
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode ? Colors.grey[400] : Color(0xFF606060),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 18,
                              color: isDarkMode ? Colors.grey[400] : Color(0xFF606060),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.notifications_outlined),
                    color: isDarkMode ? Colors.white : Colors.black,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                        ),
                        builder: (context) => NotificationDialog(
                          notifications: notifications,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.only(
                top: 16,
                left: 0.0,
                right: 16.0,
              ),
              child: Container(
                width: 370.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  border: Border.all(
                      color: isDarkMode ? (Colors.grey[800] ?? Colors.grey) : Color(0xFFD6D6D6),

                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_outlined,
                      size: 18,
                      color: isDarkMode ? Colors.grey[400] : Color(0xFF878787),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: isDarkMode ? Colors.white : Color(0xFF878787),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search menu, restaurant, or etc',
                          hintStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: isDarkMode ? Colors.grey[400] : Color(0xFF878787),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 1,
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.sliders,
                        size: 18,
                        color: isDarkMode ? Colors.grey[400] : Color(0xFF878787),
                      ),
                      onPressed: () async {
                        context.read<NavigationCubit>().goTo(ScreenIndex.FilterItem);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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