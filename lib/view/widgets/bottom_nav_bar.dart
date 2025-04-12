import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_project/helper/responsive.dart';
import '../../cubits/navigation_cubit.dart';
import 'app_tab.dart';

class BottomNavBar extends StatelessWidget {
  final AppTab currentTab;
  final GlobalKey<NavigatorState> navigatorKey;
  final ValueNotifier<String> currentRouteNotifier;

  const BottomNavBar({
    super.key,
    required this.currentTab,
    required this.navigatorKey,
    required this.currentRouteNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: currentRouteNotifier,
      builder: (context, currentRoute, child) {
        return BottomAppBar(
          color: Color(0xFFDBF4D1),
          notchMargin: 0,
          elevation: 5,
          shadowColor: Color(0xFFDBF4D1),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIcon(
                context,
                Icons.home_outlined,
                "Home",
                AppTab.home,
                currentRoute,
              ),
              _buildIcon(
                context,
                Icons.favorite_border_rounded,
                "Favorites",
                AppTab.favorites,
                currentRoute,
              ),
              SizedBox(width: responsiveWidth(context, 40)),
              _buildIcon(
                context,
                Icons.history,
                _getHistoryLabel(currentRoute),
                AppTab.history,
                currentRoute,
              ),
              _buildIcon(
                context,
                Icons.person_2_outlined,
                "Profile",
                AppTab.profile,
                currentRoute,
              ),
            ],
          ),
        );
      },
    );
  }

  String _getHistoryLabel(String currentRoute) {
    final List<String> trackingPages = [
      '/foodDetails',
      '/checkout',
      '/addCard',
      '/orderDone',
      '/deliveryTracking',
      '/chat',
      '/orderDetails',
      '/profileDetails',
      '/profile',
    ];
    return trackingPages.contains(currentRoute) ? "Track" : "History";
  }

  Widget _buildIcon(
    BuildContext context,
    IconData icon,
    String label,
    AppTab tab,
    String currentRoute,
  ) {
    final bool isSelected = currentTab == tab;
    return InkWell(
      onTap: () {
        if (currentTab != tab) {
          context.read<NavigationCubit>().changeTab(tab);
          String targetRoute;
          switch (tab) {
            case AppTab.home:
              targetRoute = '/';
              break;
            case AppTab.favorites:
              targetRoute = '/favorites';
              break;
            case AppTab.cartHistory:
              targetRoute = '/cartHistory';
              break;
            case AppTab.history:
              final List<String> trackingPages = [
                '/foodDetails',
                '/checkout',
                '/addCard',
                '/orderDone',
                '/deliveryTracking',
                '/chat',
                '/orderDetails',
                '/profileDetails',
                '/profile',
              ];
              if (trackingPages.contains(currentRoute)) {
                targetRoute = '/deliveryTracking';
              } else {
                targetRoute = '/history';
              }
              break;
            case AppTab.profile:
              targetRoute = '/profile';
              break;
            default:
              targetRoute = '/';
          }
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
            targetRoute,
            (route) => false,
          );
        } else {
          navigatorKey.currentState!.popUntil((route) => route.isFirst);
        }
      },
      child: SizedBox(
        width: responsiveWidth(context, 81.2),
        height: responsiveHeight(context, 100),
        child: Padding(
          padding: EdgeInsets.only(bottom: responsiveHeight(context, 19)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFF25AE4B) : Color(0xFF484C52),
              ),
              SizedBox(height: responsiveHeight(context, 6)),
              Text(
                label,
                style: TextStyle(
                  fontSize: responsiveHeight(context, 12),
                  fontWeight: FontWeight.w500,
                  height: 12 / 16,
                  color:
                      isSelected ? const Color(0xFF25AE4B) : Color(0xFF484C52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
