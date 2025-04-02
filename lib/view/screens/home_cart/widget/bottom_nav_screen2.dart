import 'package:flutter/material.dart';
import 'package:foodtec/view/screens/home_cart/screen/profile_screen.dart';
import 'package:foodtec/view/screens/home_cart/screen/track_screen.dart';


import '../../add_to_cart/screen/cart_screen.dart';

import '../screen/favorites_screen.dart';
import '../screen/home_screen.dart';
import '../screen/order_home.dart';

class BottomNavScreen2 extends StatefulWidget {
  const BottomNavScreen2({super.key});

  @override
  State<BottomNavScreen2> createState() => _BottomNavScreen2State();
}

class _BottomNavScreen2State extends State<BottomNavScreen2> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    OrderHome(),
    FavoritesScreen(favoriteItems: [],),
    CartScreen(),
   TrackScreen (),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: _screens[_currentIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 83,
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Color(0xFFDBF4D1),
              selectedItemColor: Color(0xFF25AE4B),
              unselectedItemColor: Colors.black54,
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 24),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_outlined, size: 24),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox.shrink(),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_outlined, size: 24),
                  label: 'Track',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 24),
                  label: 'Profile',
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 35, // ✅ ضبط موقع الأيقونة ليظهر نصفها فوق البار
            left: MediaQuery.of(context).size.width / 2 - 32, // ✅ لجعلها في المنتصف
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Color(0xFF25AE4B),
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFDBF4D1), width: 4),
              ),
              child: Icon(Icons.shopping_cart_outlined, color: Color(0xFFDBF4D1), size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
