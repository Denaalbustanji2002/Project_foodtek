import 'package:flutter/material.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationModel {
  final String title;
  final String message;
  final String time;
  bool isRead;

  NotificationModel({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}

class NotificationsBottomSheet extends StatefulWidget {
  final ScrollController scrollController;

  const NotificationsBottomSheet({super.key, required this.scrollController});

  @override
  _NotificationsBottomSheetState createState() =>
      _NotificationsBottomSheetState();
}

class _NotificationsBottomSheetState extends State<NotificationsBottomSheet> {
  String selectedTab = "All";

  List<NotificationModel> notifications = [
    NotificationModel(
      title: "Delayed Order",
      message: "We're sorry! Your order is running late. New ETA: 10:30\n\nPM. Thanks for your patience!",
      time: "Last Wednesday at 9:42 AM",
      isRead: false,
    ),
    NotificationModel(
      title: "Promotional Offer",
      message: "Craving something delicious? 🍔 Get 20% off on your next\n\norder. Use code: YUMMY20.",
      time: "Last Wednesday at 9:42 AM",
      isRead: true,
    ),
    NotificationModel(
      title: "Out for Delivery",
      message: "Your order is on the way! 🚗 Estimated arrival: 15 mins.\n\nStay hungry!",
      time: "Last Wednesday at 9:42 AM",
      isRead: false,
    ),
    NotificationModel(
      title: "Order Confirmation",
      message: "Your order has been placed! 🍔 We're preparing it now.\n\nTrack your order live!",
      time: "Last Wednesday at 9:42 AM",
      isRead: true,
    ),
    NotificationModel(
      title: "Delivered",
      message: "Enjoy your meal! 🍕 Your order has been delivered.",
      time: "Last Wednesday at 9:42 AM",
      isRead: false,
    ),
  ];

  List<NotificationModel> getFilteredNotifications() {
    if (selectedTab == "Unread") {
      return notifications.where((notif) => !notif.isRead).toList();
    } else if (selectedTab == "Read") {
      return notifications.where((notif) => notif.isRead).toList();
    }
    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(0, -8),
            blurRadius: 17.1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: responsiveHeight(context, 16)),
          Container(
            width: responsiveWidth(context, 40),
            height: responsiveHeight(context, 5),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Color(0x3C3C434D),
              borderRadius: BorderRadius.circular(2.8),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_outlined),
              ),
              Text(
                "Notifications",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Color(0xFF000000),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTab("All", isSelected: selectedTab == "All"),
              SizedBox(width: 20),
              buildTab("Unread", isSelected: selectedTab == "Unread"),
              SizedBox(width: 20),
              buildTab("Read", isSelected: selectedTab == "Read"),
            ],
          ),
          SizedBox(height: responsiveHeight(context, 16)),

          Expanded(
            child: ListView.builder(
              controller: widget.scrollController,
              itemCount: getFilteredNotifications().length,
              itemBuilder: (context, index) {
                final notif = getFilteredNotifications()[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      notif.isRead = true;
                    });
                  },
                  child: NotificationItem(
                    title: notif.title,
                    message: notif.message,
                    time: notif.time,
                    isRead: notif.isRead,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTab(String text, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = text;
        });
      },
      child: Column(
        children: [
          Text(
            text,
            style: GoogleFonts.inter(
              color: isSelected ? Color(0xFF25AE4B) : Color(0xFF697386),
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 2,
            width: 40,
            color: isSelected ? Colors.green : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final bool isRead;

  const NotificationItem({super.key,
    required this.title,
    required this.message,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF1F6FC),
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
      child: Stack(
        children: [
          if (!isRead)
            Positioned(
              top: 1,
              left: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Color(0xFF00A0FF),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF007BFF), width: 2),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    height: 14 / 20,
                    fontWeight: FontWeight.w500,
                    fontSize: responsiveHeight(context, 16),
                    color: isRead ? Color(0xFF1A1F36) : Color(0xFF1A1F36),
                  ),
                ),
                SizedBox(height: responsiveHeight(context, 8)),
                Text(
                  message,
                  style: GoogleFonts.inter(
                    height: 14 / 20,
                    fontWeight: FontWeight.w400,
                    fontSize: responsiveHeight(context, 14),
                    color: isRead ? Color(0xFF1A1F36) : Color(0xFF1A1F36),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  time,
                  style: GoogleFonts.inter(
                    fontSize: responsiveHeight(context, 14),
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFA5ACB8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void showNotificationsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) => Container(
        width: responsiveWidth(context, 430),
        height: responsiveHeight(context, 700),
        margin: EdgeInsets.only(top: 230),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, -8),
              blurRadius: 17.1,
            ),
          ],
        ),
        child: NotificationsBottomSheet(scrollController: scrollController),
      ),
    ),
  );
}

