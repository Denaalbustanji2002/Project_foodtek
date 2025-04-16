import 'package:flutter/material.dart';

class MyNavigatorObserver extends NavigatorObserver {
  final ValueNotifier<String> routeNotifier;

  MyNavigatorObserver(this.routeNotifier);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = route.settings.name ?? '';
    routeNotifier.value = routeName;
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final previousName = previousRoute?.settings.name ?? '';
    routeNotifier.value = previousName;
    super.didPop(route, previousRoute);
  }
}