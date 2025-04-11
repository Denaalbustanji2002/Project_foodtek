import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_project/view/screens/ordering_screens/Cart_history_screen.dart';
import 'package:foodtek_project/view/screens/ordering_screens/favorites_screen.dart';
import 'package:foodtek_project/view/screens/ordering_screens/home_screen.dart';
import '../../../cubits/navigation_cubit.dart';
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
import 'history_screen.dart';
import 'order_details_screen.dart';


class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final Map<AppTab, Widget> navbarPages = {
    AppTab.home: HomeScreen(),
    AppTab.favorites: FavoritesScreen(),
    AppTab.cartHistory: CartHistoryScreen(),
    AppTab.history: HistoryScreen(),
    AppTab.profile: ProfileScreen(),
  };

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/favorites':
        return MaterialPageRoute(builder: (_) => FavoritesScreen());
      case '/cartHistory':
        return MaterialPageRoute(builder: (_) => CartHistoryScreen());
      case '/history':
        return MaterialPageRoute(builder: (_) => HistoryScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/location':
        return MaterialPageRoute(builder: (_) => LocationScreen());
        case '/chat':
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case '/orderDetails':
        return MaterialPageRoute(builder: (_) => OrderDetailsScreen());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case '/filterScreen':
        return MaterialPageRoute(builder: (_) => FilterScreen());
      case '/addCard':
        return MaterialPageRoute(builder: (_) => AddCardScreen());
      case '/deliveryTracking':
        return MaterialPageRoute(builder: (_) => DeliveryTrackingScreen());
      case '/orderDone':
        return MaterialPageRoute(builder: (_) => OrderDoneSuccessfullyScreen());
      case '/profileDetails':
        return MaterialPageRoute(builder: (_) => ProfileScreenDetails());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
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
            ),
            bottomNavigationBar: BottomNavBar(
              currentTab: currentTab,
              navigatorKey: navigatorKey, // تمرير المفتاح هنا
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xFF25AE4B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onPressed: () {
                // كمثال، نقوم بتغيير التاب لعرض عربة التسوق
                context.read<NavigationCubit>().changeTab(AppTab.cartHistory);
                navigatorKey.currentState!
                    .pushNamedAndRemoveUntil('/cartHistory', (route) => false);
              },
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }
}
