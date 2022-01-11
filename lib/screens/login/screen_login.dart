import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ScreenLogin extends StatefulWidget {
  static String routeName = '/screen_login';

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return loginStatusNotSignIn();
      case LoginStatus.signIn:
        return Text('Giris');
    }
  }

  Scaffold loginStatusNotSignIn() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(cTitleScreenLogin),
      ),
      body: Text('body giris'),
    );
  }
}
