import '../../constants/constants.dart';
import 'package:flutter/material.dart';

class ScreenWelcome extends StatelessWidget {
  static String routeName = '/';
  const ScreenWelcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(cTitleScreenWelcome),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
