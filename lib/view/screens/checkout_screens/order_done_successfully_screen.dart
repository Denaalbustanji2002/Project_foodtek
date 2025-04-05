import 'package:flutter/material.dart';
import 'package:foodtek_project/view/widgets/order_done_successfully_animation_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../../helper/responsive.dart';
import '../../widgets/notifications_bottom_sheet.dart';
import '../location_screen/delivery_tracking_screen.dart';
import '../ordering_screens/cart_history_screen.dart';
import '../ordering_screens/favorites_screen.dart';
import '../ordering_screens/home_screen.dart';
import '../profile_screens/profile_screen.dart';

class OrderDoneSuccessfullyScreen extends StatefulWidget {
  @override
  State<OrderDoneSuccessfullyScreen> createState() =>
      _OrderDoneSuccessfullyScreenState();
}

class _OrderDoneSuccessfullyScreenState
    extends State<OrderDoneSuccessfullyScreen> {
  int selectedIndex = 2;

  void onItemTapped(int index) {
    Widget nextScreen;

    switch (index) {
      case 0:
        nextScreen = HomeScreen();
        break;
      case 1:
        nextScreen = FavoritesScreen();
        break;
      case 3:
        nextScreen = DeliveryTrackingScreen();
        break;
      case 4:
        nextScreen = ProfileScreen();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );

    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {
              showNotificationsSheet(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: responsiveHeight(context, 14)),
              Text(
                "Checkout",
                style: GoogleFonts.inter(
                  color: const Color(0xFF391713),
                  fontSize: responsiveHeight(context, 20),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  height: 1.0,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 20)),

              SizedBox(
                height: responsiveHeight(context, 400),
                width: responsiveWidth(context, 450),
                child: OrderDoneSuccessfullyAnimationWidget(),
              ),
              SizedBox(height: responsiveHeight(context, 20)),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Your Order Done Successfully",
                      style: GoogleFonts.inter(
                        fontSize: responsiveWidth(context, 24),
                        fontWeight: FontWeight.w700,
                        color: Color(0XFF263238),
                        letterSpacing: -0.02,
                        height: 1.3,
                      ),
                    ),

                    SizedBox(height: responsiveHeight(context, 12)),

                    Text(
                      "You will get your order within 12min.\n thanks for using our services.",
                      style: GoogleFonts.inter(
                        fontSize: responsiveWidth(context, 20),
                        color: Color(0XFF263238),
                        letterSpacing: -0.01,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsiveHeight(context, 50)),
              Center(
                child: SizedBox(
                  width: responsiveWidth(context, 327),
                  height: responsiveHeight(context, 58),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeliveryTrackingScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25AE4B),
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveWidth(context, 22),
                        vertical: responsiveHeight(context, 18),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Track Your Order",
                      style: GoogleFonts.inter(
                        fontSize: responsiveHeight(context, 18),
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.0,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartHistoryScreen()),
          );
        },
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
          size: responsiveHeight(context, 24),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        color: Color(0xFFDBF4D1),
        child: Padding(
          padding: EdgeInsets.only(bottom: responsiveHeight(context, 10)),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            selectedItemColor: Color(0XFF25AE4B),
            unselectedItemColor: Color(0XFF484C52),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_rounded),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
              BottomNavigationBarItem(
                icon: Icon(Icons.track_changes),
                label: 'Track',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
