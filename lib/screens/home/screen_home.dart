import 'package:choicen_robot/constants/constants.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  static String routeName = '/screen_home';

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(cTitleScreenHome),
      ),
      body: Text('home page'),
    );
  }
}
