import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/screen_index.dart';
import '../../../../cubits/ThemeCubit.dart';
import '../../../../cubits/navigatiion_cubit.dart';
import '../../../../states/ThemeState.dart';
import '../../add_to_cart/screen/cart_screen.dart';
import '../../add_to_cart/screen/history_screen.dart';
import '../../chat_screen/chat_screen.dart';
import '../../checkout_screens/add_card_screen.dart';
import '../../checkout_screens/checkout_screen.dart';
import '../../checkout_screens/order_details_screen.dart';
import '../../checkout_screens/order_done_successfully_screen.dart';
import '../../location_screen/delivery_tracking_screen.dart';
import '../../location_screen/location_screen.dart';
import '../../profile_screens/profile_screen.dart';
import '../../profile_screens/profile_screen_details.dart';
import '../screen/favorites_screen.dart';
import '../screen/filter_item.dart';
import '../screen/food_details.dart';
import '../screen/home_screen.dart';
import '../screen/order_home.dart';

class MainbarScreen extends StatelessWidget {
  const MainbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState.themeMode == ThemeMode.dark;

        return MaterialApp(
          theme: themeState.lightTheme,
          darkTheme: themeState.darkTheme,
          themeMode: themeState.themeMode,
          home: BlocBuilder<NavigationCubit, int>(
            builder: (context, currentIndex) {
              final navCubit = context.read<NavigationCubit>();
              final bool showTrack = _shouldShowTrack(currentIndex, navCubit.previousIndex);

              return Scaffold(
                body: _buildCurrentScreen(currentIndex),
                bottomNavigationBar: _shouldShowBottomNav(currentIndex)
                    ? BottomAppBar(
                  color: isDarkMode
                      ? Colors.grey[900]
                      : const Color(0xFFDBF4D1),
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _bottomBarIcon(
                          context,
                          Icons.home,
                          'Home',
                          0,
                          currentIndex,
                          isDarkMode,
                        ),
                        _bottomBarIcon(
                          context,
                          Icons.favorite,
                          'Favorites',
                          1,
                          currentIndex,
                          isDarkMode,
                        ),
                        GestureDetector(
                          onTap: () => context.read<NavigationCubit>().goTo(ScreenIndex.CartScreen),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: isDarkMode
                                    ? Colors.green[200]
                                    : const Color(0xFF25AE4B),
                              ),
                              Text(
                                'Cart',
                                style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.green[200]
                                        : const Color(0xFF25AE4B),
                                    fontSize: 12
                                ),
                              ),
                            ],
                          ),
                        ),
                        _bottomBarIcon(
                          context,
                          showTrack ? Icons.track_changes : Icons.history,
                          showTrack ? 'Track' : 'History',
                          3,
                          currentIndex,
                          isDarkMode,
                        ),
                        _bottomBarIcon(
                          context,
                          Icons.person,
                          'Profile',
                          4,
                          currentIndex,
                          isDarkMode,
                        ),
                      ],
                    ),
                  ),
                )
                    : null,
              );
            },
          ),
        );
      },
    );
  }

  // ... باقي الدوال保持不变 (_buildCurrentScreen, _shouldShowBottomNav, etc.)

  Widget _bottomBarIcon(
      BuildContext context,
      IconData icon,
      String label,
      int index,
      int currentIndex,
      bool isDarkMode,
      ) {
    final selectedIndex = _getBottomNavIndex(currentIndex);
    final isSelected = selectedIndex == index;

    final selectedColor = isDarkMode ? Colors.green[200]! : const Color(0xFF25AE4B);
    final unselectedColor = isDarkMode ? Colors.grey[400]! : const Color(0xFF484C52);

    return GestureDetector(
      onTap: () {
        final navCubit = context.read<NavigationCubit>();
        final screenIndex = _bottomNavToScreenIndex(
            index,
            _shouldShowTrack(currentIndex, navCubit.previousIndex)
        );
        navCubit.goTo(screenIndex);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? selectedColor : unselectedColor,
          ),
          Text(
            label,
            style: TextStyle(
                color: isSelected ? selectedColor : unselectedColor,
                fontSize: 12
            ),
          ),
        ],
      ),
    );
  }
}
Widget _buildCurrentScreen(int currentIndex) {
  switch (currentIndex) {
    case ScreenIndex.HomeScreen:
      return HomeScreen();
    case ScreenIndex.HistoryScreen:
      return HistoryScreen();
    case ScreenIndex.FilterItem:
      return FilterItem();
    case ScreenIndex.FavoritesScreen:
      return FavoritesScreen(favoriteItems: []);
    case ScreenIndex.CartScreen:
      return CartScreen();
    case ScreenIndex.ProfileScreen:
      return ProfileScreen();
    case ScreenIndex.ProfileScreenDetails:
      return ProfileScreenDetails();
    case ScreenIndex.ChatScreen:
      return ChatScreen();
    case ScreenIndex.DeliveryTrackingScreen:
      return DeliveryTrackingScreen();
    case ScreenIndex.FoodInCateg:
      return FoodInCateg();
    case ScreenIndex.OrderHome:
      return OrderHome();
    case ScreenIndex.OrderDetailsScreen:
      return OrderDetailsScreen();
    case ScreenIndex.CheckoutScreen:
      return CheckoutScreen();
    case ScreenIndex.AddtoCardScreen:
      return AddtoCardScreen();
    case ScreenIndex.OrderDoneSuccessfullyScreen:
      return OrderDoneSuccessfullyScreen();
    case ScreenIndex.LocationScreen:
      return LocationScreen();
    default:
      return HomeScreen();
  }
}

bool _shouldShowBottomNav(int currentIndex) {
  const hiddenScreens = [ScreenIndex.NotificationScreen];
  return !hiddenScreens.contains(currentIndex);
}

bool _shouldShowTrack(int currentIndex, int previousIndex) {
  return currentIndex == ScreenIndex.DeliveryTrackingScreen ||
      currentIndex == ScreenIndex.OrderHome ||
      currentIndex == ScreenIndex.LocationScreen ||
      currentIndex == ScreenIndex.OrderDoneSuccessfullyScreen ||
      currentIndex == ScreenIndex.ProfileScreen ||
      currentIndex == ScreenIndex.ProfileScreenDetails ||
      previousIndex == ScreenIndex.ProfileScreenDetails ||
      previousIndex == ScreenIndex.DeliveryTrackingScreen ||
      currentIndex == ScreenIndex.AddCardScreen ||
      currentIndex == ScreenIndex.CheckoutScreen;
}
int _getBottomNavIndex(int currentIndex) {
  if (!_isBottomNavScreen(currentIndex)) {
    return 0;
  }

  switch (currentIndex) {
    case ScreenIndex.HomeScreen:
      return 0;
    case ScreenIndex.FavoritesScreen:
      return 1;
    case ScreenIndex.CartScreen:
      return 2;
    case ScreenIndex.DeliveryTrackingScreen:
    case ScreenIndex.HistoryScreen:
      return 3;
    case ScreenIndex.ProfileScreen:
      return 4;
    default:
      return 0;
  }
}

bool _isBottomNavScreen(int index) {
  return [
    ScreenIndex.HomeScreen,
    ScreenIndex.FavoritesScreen,
    ScreenIndex.CartScreen,
    ScreenIndex.ProfileScreen,
    ScreenIndex.DeliveryTrackingScreen,
    ScreenIndex.HistoryScreen,
  ].contains(index);
}

int _bottomNavToScreenIndex(int bottomNavIndex, bool showTrack) {
  switch (bottomNavIndex) {
    case 0:
      return ScreenIndex.HomeScreen;
    case 1:
      return ScreenIndex.FavoritesScreen;
    case 2:
      return ScreenIndex.CartScreen;
    case 3:
      return showTrack ? ScreenIndex.DeliveryTrackingScreen : ScreenIndex.HistoryScreen;
    case 4:
      return ScreenIndex.ProfileScreen;
    default:
      return ScreenIndex.HomeScreen;
  }
}
