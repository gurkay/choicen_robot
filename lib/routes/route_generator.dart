import 'package:choicen_robot/constants/constants.dart';

import '../screens/welcome/screen_welcome.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => ScreenWelcome(),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(cTitleError),
          ),
          body: const Center(
            child: Text('Error ::: path'),
          ),
        );
      },
    );
  }
}
