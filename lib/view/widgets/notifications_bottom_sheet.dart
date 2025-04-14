import 'package:flutter/material.dart';
import 'package:foodtek_project/helper/responsive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  String selectedTab = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        selectedTab = AppLocalizations.of(context)!.tabAll;
      });
    });
  }
  List<NotificationModel> notifications = [];

  List<NotificationModel> getFilteredNotifications() {
    if (selectedTab == AppLocalizations.of(context)!.tabUnread) {
      return notifications.where((notif) => !notif.isRead).toList();
    } else if (selectedTab == AppLocalizations.of(context)!.tabRead) {
      return notifications.where((notif) => notif.isRead).toList();
    }
    return notifications;
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notifications = [
      NotificationModel(
        title: AppLocalizations.of(context)!.notifDelayedOrderTitle,
        message:
AppLocalizations.of(context)!.notifDelayedOrderMsg ,
        time: AppLocalizations.of(context)!.notifTime1,
        isRead: false,
      ),
      NotificationModel(
        title: AppLocalizations.of(context)!.notifPromoTitle,
        message:
AppLocalizations.of(context)!.notifPromoMsg ,
        time: AppLocalizations.of(context)!.notifTime1,
        isRead: true,
      ),
      NotificationModel(
        title:AppLocalizations.of(context)!.notifOutForDeliveryTitle,
        message: AppLocalizations.of(context)!.notifOutForDeliveryMsg ,time: AppLocalizations.of(context)!.notifTime1,
        isRead: false,
      ),
      NotificationModel(
        title: AppLocalizations.of(context)!.notifConfirmedTitle,
        message:AppLocalizations.of(context)!.notifConfirmedMsg ,
        time: AppLocalizations.of(context)!.notifTime1,
        isRead: true,
      ),
      NotificationModel(
        title: AppLocalizations.of(context)!.notifDeliveredTitle,
        message: AppLocalizations.of(context)!.notifDeliveredMsg,
        time: AppLocalizations.of(context)!.notifTime1,
        isRead: false,
      ),
    ];
    setState(() {});
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
               AppLocalizations.of(context)!.notifications,
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
              buildTab(AppLocalizations.of(context)!.tabAll, isSelected: selectedTab == AppLocalizations.of(context)!.tabAll),
              SizedBox(width: 20),
              buildTab(AppLocalizations.of(context)!.tabUnread, isSelected: selectedTab == AppLocalizations.of(context)!.tabUnread),
              SizedBox(width: 20),
              buildTab(AppLocalizations.of(context)!.tabRead, isSelected: selectedTab == AppLocalizations.of(context)!.tabRead),
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

