import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/screen_index.dart';
import '../../../../cubits/navigatiion_cubit.dart';
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
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        final navCubit = context.read<NavigationCubit>();
        final bool showTrack = _shouldShowTrack(currentIndex, navCubit.previousIndex);

        return Scaffold(
          body: _buildCurrentScreen(currentIndex),
          bottomNavigationBar: _buildAdaptiveBottomNavBar(context, currentIndex, showTrack),
        );
      },
    );
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
      case ScreenIndex.HistoryScreen:
        return HistoryScreen();
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
    const hiddenScreens = [
      //ScreenIndex.ProfileScreen,
      // ScreenIndex.FoodInCateg,
     // ScreenIndex.ChatScreen,
       ScreenIndex.NotificationScreen,
    ];
    return !hiddenScreens.contains(currentIndex);
  }

  bool _shouldShowTrack(int currentIndex, int previousIndex) {
    return currentIndex == ScreenIndex.DeliveryTrackingScreen ||
        currentIndex == ScreenIndex.OrderHome
        ||
        currentIndex == ScreenIndex.LocationScreen ||
        currentIndex == ScreenIndex.OrderDoneSuccessfullyScreen ||
        currentIndex == ScreenIndex.ProfileScreen|| currentIndex == ScreenIndex.ProfileScreenDetails || // أضف هذه الشاشة
        previousIndex == ScreenIndex.ProfileScreenDetails || previousIndex == ScreenIndex.DeliveryTrackingScreen ||currentIndex == ScreenIndex.AddCardScreen || currentIndex == ScreenIndex.CheckoutScreen;
  }

  Widget? _buildAdaptiveBottomNavBar(BuildContext context, int currentIndex, bool showTrack) {
    if (!_shouldShowBottomNav(currentIndex)) {
      return null;
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        BottomNavigationBar(
          backgroundColor: const Color(0xFFDBF4D1),
          currentIndex: _getBottomNavIndex(currentIndex),
          selectedItemColor: const Color(0xFF25AE4B),
          unselectedItemColor: Color(0xFF484C52),
          onTap: (index) => _handleBottomNavTap(context, index, showTrack),
          type: BottomNavigationBarType.fixed,
          items: _buildBottomNavItems(showTrack),
        ),
        _buildFloatingCartButton(context),
      ],
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavItems(bool showTrack) {
    return [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home' ,),
      const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
      const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
      BottomNavigationBarItem(
        icon: Icon(showTrack ? Icons.track_changes : Icons.history),
        label: showTrack ? 'Track' : 'History',
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
    ];
  }

  Widget _buildFloatingCartButton(BuildContext context) {
    return Positioned(
      bottom: 35,
      left: MediaQuery.of(context).size.width / 2 - 32,
      child: GestureDetector(
        onTap: () => context.read<NavigationCubit>().goTo(ScreenIndex.CartScreen),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF25AE4B),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFDBF4D1), width: 4),
          ),
          child: const Icon(Icons.shopping_cart_outlined,
              color: Color(0xFFDBF4D1), size: 24),
        ),
      ),
    );
  }

  void _handleBottomNavTap(BuildContext context, int index, bool showTrack) {
    final targetIndex = _bottomNavToScreenIndex(index, showTrack);

    if (targetIndex == ScreenIndex.ProfileScreen) {
      context.read<NavigationCubit>().goTo(ScreenIndex.ProfileScreen);
    }
    else if (targetIndex == ScreenIndex.ProfileScreenDetails) {
      context.read<NavigationCubit>().goTo(ScreenIndex.ProfileScreenDetails);
    }
    else {
      context.read<NavigationCubit>().goTo(targetIndex);
    }

  }

  int _getBottomNavIndex(int currentIndex) {
    if (!_isBottomNavScreen(currentIndex)) {
      return _findClosestBottomNavIndex(currentIndex);
    }

    switch (currentIndex) {
      case ScreenIndex.HomeScreen: return 0;
      case ScreenIndex.FavoritesScreen: return 1;
      case ScreenIndex.CartScreen: return 2;
      case ScreenIndex.ProfileScreen: return 4;
      case ScreenIndex.DeliveryTrackingScreen:
      case ScreenIndex.HistoryScreen: return 3;
      default: return 0;
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

  int _findClosestBottomNavIndex(int currentIndex) {
    return 0;
  }

  int _bottomNavToScreenIndex(int bottomNavIndex, bool showTrack) {
    switch (bottomNavIndex) {
      case 0: return ScreenIndex.HomeScreen;
      case 1: return ScreenIndex.FavoritesScreen;
      case 2: return ScreenIndex.CartScreen;
      case 3: return showTrack ? ScreenIndex.DeliveryTrackingScreen : ScreenIndex.HistoryScreen;
      case 4: return ScreenIndex.ProfileScreen;
      default: return ScreenIndex.HomeScreen;
    }
  }
}