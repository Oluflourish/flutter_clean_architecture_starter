import 'package:flutter/material.dart';

class NavigatorService {
  NavigatorService._internal();
  static final NavigatorService _instance = NavigatorService._internal();
  factory NavigatorService() => _instance;

  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get key => _navKey;

  pushNamed(String routeName, {dynamic arguments}) {
    return _navKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  pop(value) {
    return _navKey.currentState!.pop(value);
  }

  goBack() {
    return _navKey.currentState!.pop();
  }

  popUntil(String routeName, {dynamic arguments}) {
    return _navKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  pushNamedAndRemoveUntil(String routeName, {dynamic arguments}) {
    return _navKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: arguments);
  }

  pushReplacementNamed(String routeName, {dynamic arguments}) {
    return _navKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  BuildContext get context => _navKey.currentContext!;
}
