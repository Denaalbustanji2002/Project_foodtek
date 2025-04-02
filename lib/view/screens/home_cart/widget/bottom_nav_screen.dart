import 'package:flutter/material.dart';
import 'package:foodtec/view/screens/home_cart/screen/profile_screen.dart';

import '../../add_to_cart/screen/cart_screen.dart';

import '../../add_to_cart/screen/history_screen.dart';
import '../screen/favorites_screen.dart';
import '../screen/filter_items.dart';
import '../screen/food_details.dart';

import '../screen/home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;

  // مفاتيح التنقل لكل تبويب
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // توليد الصفحات مع Navigator لكل تبويب
  Widget _buildOffstageNavigator(int index, Widget screen) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => screen,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          _buildOffstageNavigator(0, HomeScreen()),
          _buildOffstageNavigator(1, FavoritesScreen(favoriteItems: [])),
          _buildOffstageNavigator(2, CartScreen()),
          _buildOffstageNavigator(3, HistoryScreen()),
          _buildOffstageNavigator(4, ProfileScreen()),
        ],
      ),
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
                if (index == _currentIndex) {
                  // إذا ضغط المستخدم على نفس التبويب، نرجع إلى الصفحة الرئيسية للتبويب
                  _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
                } else {
                  setState(() {
                    _currentIndex = index;
                  });
                }
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home, size: 24), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined, size: 24), label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined, size: 24), label: ''),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history, size: 24),
                  label: 'History',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.person, size: 24), label: 'Profile'),
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            left: MediaQuery.of(context).size.width / 2 - 32,
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Color(0xFF25AE4B),
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFDBF4D1), width: 4),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart_outlined, color: Color(0xFFDBF4D1), size: 24),
                onPressed: () {
                  setState(() {
                    _currentIndex = 2; // التبديل إلى CartScreen
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
