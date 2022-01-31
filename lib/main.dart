import '../../routes/route_generator.dart';
import 'package:flutter/material.dart';

import 'screens/welcome/screen_welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secim Robotu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: ScreenWelcome.routeName,
      routes: {
        ScreenWelcome.routeName: (context) => ScreenWelcome(),
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
