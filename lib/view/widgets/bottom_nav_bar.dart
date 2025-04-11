import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/navigation_cubit.dart';
import 'app_tab.dart';

class BottomNavBar extends StatelessWidget {
  final AppTab currentTab;
  final GlobalKey<NavigatorState> navigatorKey; // المفتاح الذي يتم تمريره من MainScreen

  const BottomNavBar({
    super.key,
    required this.currentTab,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIcon(context, Icons.home, "Home", AppTab.home),
          _buildIcon(context, Icons.favorite, "Favorites", AppTab.favorites),
          const SizedBox(width: 40),
          _buildIcon(
            context,
            Icons.history,
            _getHistoryLabel(context),
            AppTab.history,
          ),
          _buildIcon(context, Icons.person, "Profile", AppTab.profile),
        ],
      ),
    );
  }

  Widget _buildIcon(
      BuildContext context, IconData icon, String label, AppTab tab) {
    final bool isSelected = currentTab == tab;

    return InkWell(
      onTap: () {
        // فقط إذا كان التاب مختلف عن الحالي ننفذ التنقل
        if (currentTab != tab) {
          context.read<NavigationCubit>().changeTab(tab);
          // تحديد الريوت المناسب لكل تاب:
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
              targetRoute = '/history';
              break;
            case AppTab.profile:
              targetRoute = '/profile';
              break;
            default:
              targetRoute = '/';
          }
          // الانتقال للريوت الجديد وإزالة باقي التراكات
          navigatorKey.currentState!
              .pushNamedAndRemoveUntil(targetRoute, (route) => false);
        } else {
          // إذا كان التاب هو الحالي يمكنك مثلاً عمل pop حتى الصفحة الجذرية لذلك التاب
          navigatorKey.currentState!.popUntil((route) => route.isFirst);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              color: isSelected ? const Color(0xFF25AE4B) : Colors.grey),
          Text(label,
              style: TextStyle(
                  color: isSelected ? const Color(0xFF25AE4B) : Colors.grey)),
        ],
      ),
    );
  }

  String _getHistoryLabel(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final List<String> trackingPages = [
      '/profile',
      '/profileDetails',
      '/orderDetails',
      '/chat',
      '/deliveryTracking',
      '/orderDone',
      '/checkout',
      '/addCard',
    ];
    return trackingPages.contains(currentRoute) ? "Track" : "History";
  }
}
