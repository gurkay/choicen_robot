import '../../screens/login/screen_login.dart';

import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class ScreenWelcome extends StatelessWidget {
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(cTitleScreenWelcome),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                ScreenLogin.routeName,
              );
            },
            icon: const Icon(Icons.login),
            tooltip: 'Giris Yapiniz',
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(cAboutChoicenRobot),
          ],
        ),
      ),
    );
  }
}
