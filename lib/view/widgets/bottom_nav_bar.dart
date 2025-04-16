import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek_project/helper/responsive.dart';
import '../../cubits/navigation_cubit.dart';
import 'app_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavBar extends StatelessWidget {
  final AppTab currentTab;
  final GlobalKey<NavigatorState> navigatorKey;
  final ValueNotifier<String> currentRouteNotifier;

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
    '/filterScreen',
  ];

  BottomNavBar({
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
          color: const Color(0xFFDBF4D1),
          notchMargin: 0,
          elevation: 5,
          shadowColor: const Color(0xFFDBF4D1),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIcon(
                context,
                Icons.home_outlined,
                AppLocalizations.of(context)!.home,
                AppTab.home,
                currentRoute,
              ),
              _buildIcon(
                context,
                Icons.favorite_border_rounded,
                AppLocalizations.of(context)!.favoriteNav,
                AppTab.favorites,
                currentRoute,
              ),
              SizedBox(width: responsiveWidth(context, 24)),
              _buildIcon(
                context,
                trackingPages.contains(currentRoute)
                    ? Icons.track_changes_outlined
                    : Icons.history,
                _getHistoryLabel(currentRoute, context),
                AppTab.history,
                currentRoute,
              ),
              _buildIcon(
                context,
                Icons.person_2_outlined,
                AppLocalizations.of(context)!.profile,
                AppTab.profile,
                currentRoute,
              ),
            ],
          ),
        );
      },
    );
  }

  String _getHistoryLabel(String currentRoute, BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return trackingPages.contains(currentRoute) ? local.track : local.history;
  }

  Widget _buildIcon(
      BuildContext context,
      IconData icon,
      String label,
      AppTab tab,
      String currentRoute,
      ) {
    final List<String> bottomRoutes = ['/', '/favorites', '/cartHistory', '/history', '/profile'];
    final bool isBottomScreen = bottomRoutes.contains(currentRoute);
    final bool isSelected = isBottomScreen && (currentTab == tab);
    final bool shouldShowTrack = trackingPages.contains(currentRoute);
    final AppTab actualTab = (tab == AppTab.history && shouldShowTrack) ? AppTab.track : tab;

    return InkWell(
      onTap: () {
        if (!isSelected) {
          context.read<NavigationCubit>().changeTab(actualTab);
          String targetRoute;
          switch (actualTab) {
            case AppTab.home:
              targetRoute = '/';
              break;
            case AppTab.favorites:
              targetRoute = '/favorites';
              break;
            case AppTab.cartHistory:
              targetRoute = '/cartHistory';
              break;
            case AppTab.track:
              targetRoute = '/deliveryTracking';
              break;
            case AppTab.history:
              targetRoute = '/history';
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
                color: isSelected
                    ? const Color(0xFF25AE4B)
                    : const Color(0xFF484C52),
              ),
              SizedBox(height: responsiveHeight(context, 6)),
              Text(
                label,
                style: TextStyle(
                  fontSize: responsiveHeight(context, 12),
                  fontWeight: FontWeight.w500,
                  height: 12 / 16,
                  color: isSelected
                      ? const Color(0xFF25AE4B)
                      : const Color(0xFF484C52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}