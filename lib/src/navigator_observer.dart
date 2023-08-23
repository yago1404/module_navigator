import 'package:flutter/material.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint(
        'Navigator push: ${previousRoute?.settings.name} ------> ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint(
        'Navigator pushReplacement: ${oldRoute?.settings.name} ------> ${newRoute?.settings.name}');
    super.didReplace();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    debugPrint(
        'Navigator Remove: ${previousRoute?.settings.name} ------> ${route.settings.name}');
    super.didRemove(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint(
        'Navigator pop: ${route.settings.name} ------> ${previousRoute?.settings.name}');
    super.didPop(route, previousRoute);
  }
}