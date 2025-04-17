import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_project/view/screens/ordering_screens/Cart_history_screen.dart';
import 'package:foodtek_project/view/screens/ordering_screens/favorites_screen.dart';
import 'package:foodtek_project/view/screens/ordering_screens/home_screen.dart';
import '../../../cubits/navigation_cubit.dart';
import '../../../my_navigator_observer.dart';
import '../../widgets/app_tab.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../chat_screen/chat_screen.dart';
import '../checkout_screens/add_card_screen.dart';
import '../checkout_screens/checkout_screen.dart';
import '../checkout_screens/order_done_successfully_screen.dart';
import '../location_screen/delivery_tracking_screen.dart';
import '../location_screen/location_screen.dart';
import '../profile_screens/profile_screen.dart';
import '../profile_screens/profile_screen_details.dart';
import 'filter_screen.dart';
import 'food_details_screen.dart';
import 'history_screen.dart';
import 'order_details_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final ValueNotifier<String> currentRouteNotifier = ValueNotifier<String>('/');

  Map<AppTab, Widget> get navbarPages => {
    AppTab.home: HomeScreen(),
    AppTab.favorites: FavoritesScreen(),
    AppTab.cartHistory: CartHistoryScreen(),
    AppTab.history: HistoryScreen(),
    AppTab.profile: ProfileScreen(navigatorKey: navigatorKey),
  };

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomeScreen(),
        );
      case '/foodDetails':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder:
              (_) => FoodDetailScreen(
                name: args['name'],
                description: args['description'],
                rating: args['rating'],
                price: args['price'],
                imagePath: args['imagePath'],
              ),
        );

      case '/favorites':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => FavoritesScreen(),
        );
      case '/cartHistory':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CartHistoryScreen(),
        );
      case '/history':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HistoryScreen(),
        );
      case '/profile':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProfileScreen(navigatorKey: navigatorKey),
        );
      case '/location':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LocationScreen(),
        );
      case '/chat':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ChatScreen(),
        );
      case '/orderDetails':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => OrderDetailsScreen(),
        );
      case '/checkout':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CheckoutScreen(),
        );
      case '/filterScreen':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => FilterScreen(),
        );
      case '/addCard':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AddCardScreen(),
        );
      case '/deliveryTracking':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => DeliveryTrackingScreen(),
        );
      case '/orderDone':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => OrderDoneSuccessfullyScreen(),
        );
      case '/profileDetails':
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProfileScreenDetails(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomeScreen(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, AppTab>(
        builder: (context, currentTab) {
          return Scaffold(
            body: Navigator(
              key: navigatorKey,
              initialRoute: '/',
              onGenerateRoute: _onGenerateRoute,
              observers: [MyNavigatorObserver(currentRouteNotifier)],
            ),
            bottomNavigationBar: BottomNavBar(
              currentTab: currentTab,
              navigatorKey: navigatorKey,
              currentRouteNotifier: currentRouteNotifier,
            ),
            floatingActionButton: SizedBox(
              height: 53,
              width: 52,
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF25AE4B),
                shape: const CircleBorder(),
                onPressed: () {
                  context.read<NavigationCubit>().changeTab(AppTab.cartHistory);
                  navigatorKey.currentState!.pushNamedAndRemoveUntil(
                    '/cartHistory',
                    (route) => false,
                  );
                },
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}