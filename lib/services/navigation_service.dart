import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(Route route) {
    return navigatorKey.currentState!.push(route);
  }

  static Future<dynamic> navigateToReplacement(Route route) {
    return navigatorKey.currentState!.pushReplacement(route);
  }

  static Future<dynamic> navigateAndRemoveUntil(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  static Future<dynamic> navigateToNamedRoute(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static popNavigate() {
    return navigatorKey.currentState!.pop();
  }
}