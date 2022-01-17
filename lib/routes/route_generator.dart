import 'package:flutter/material.dart';

import '../screens/activity/screen_activity.dart';
import '../screens/criteria/screen_criteria.dart';
import '../screens/singup/screen_singup.dart';
import '../constants/constants.dart';
import '../screens/login/screen_login.dart';
import '../screens/welcome/screen_welcome.dart';
import '../screens/home/screen_home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    dynamic args = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => ScreenWelcome(),
        );
      case '/screen_login':
        return MaterialPageRoute(
          builder: (_) => ScreenLogin(),
        );
      case '/screen_singup':
        return MaterialPageRoute(
          builder: (_) => ScreenSingup(),
        );
      case '/screen_home':
        return MaterialPageRoute(
          builder: (_) => ScreenHome(
            signOut: () => VoidCallback,
          ),
        );
      case '/screen_activity':
        return MaterialPageRoute(
          builder: (_) => ScreenActivity(
            category: args,
          ),
        );
      case '/screen_criteria':
        return MaterialPageRoute(
          builder: (_) => ScreenCriteria(
            category: args,
          ),
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
