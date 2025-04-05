import 'package:flutter/material.dart';

class BottomNavigationWithFAB extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  BottomNavigationWithFAB({required this.currentIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // هنا نترك فقط BottomNavigationBar و FloatingActionButton
        Expanded(
          child: Container(),  // يمكن أن يكون هذا مكان محتوى الصفحة الذي يجب أن يظهر.
        ),
        BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: currentIndex,
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: const Color(0XFF25AE4B),
          unselectedItemColor: const Color(0XFF484C52),
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
              icon: Icon(Icons.history_rounded),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
        ),
      ],
    );
  }
}
