import 'package:choicen_robot/screens/welcome/screen_welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/already_have_an_account_check.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../components/rounded_password_field.dart';
import '../../models/user.dart';
import '../../screens/home/screen_home.dart';
import '../../screens/singup/screen_singup.dart';
import '../../services/response/response_user.dart';
import '../../constants/constants.dart';

class ScreenLogin extends StatefulWidget {
  static String routeName = '/screen_login';

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> implements CallBackUser {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String? _email, _password;
  ResponseUser? _responseUser;
  _ScreenLoginState() {
    _responseUser = ResponseUser(this);
  }

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _loginStatus = sharedPreferences.getString('email') == null
          ? LoginStatus.notSignIn
          : LoginStatus.signIn;
    });
  }

  setPref(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt('userId', user.userId);
      sharedPreferences.setString('userEmail', user.userEmail);
      sharedPreferences.setString('userPassword', user.userPassword);
    });
  }

  void _submit() {
    if (_email == null || _password == null) {
      _showSnackBar(context, 'Kullanıcı Adı ve Pasaport Boş Olamaz');
      return;
    }

    if (_loginStatus == LoginStatus.notSignIn) {
      _responseUser!.doRead(User(_email, _password));
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  singOut() async {
    setState(() {
      _loginStatus = LoginStatus.notSignIn;
    });
    Navigator.pushNamed(
      context,
      ScreenWelcome.routeName,
    );
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return loginStatusNotSignIn();
      case LoginStatus.signIn:
        return ScreenHome(
          signOut: singOut,
        );
    }
  }

  Scaffold loginStatusNotSignIn() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            hintText: 'Kullanıcı Adı Giriniz',
            onChanged: (value) {
              _email = value;
            },
          ),
          SizedBox(height: size.height * 0.03),
          RoundedPasswordField(
            hintText: 'Şifrenizi Giriniz',
            onChanged: (value) {
              _password = value;
            },
          ),
          SizedBox(height: size.height * 0.03),
          RoundedButton(
            text: 'Giris',
            press: _submit,
          ),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.pushNamed(
                context,
                ScreenSingup.routeName,
              );
            },
          )
        ],
      ),
    );
  }

  @override
  void onUserError(String error) {
    _showSnackBar(context, 'onLoginError ::: $error');
  }

  @override
  void onUserSuccess(User user) {
    print('screen_login::: ${user.userId}');
    setPref(user);
    setState(() {
      _loginStatus = LoginStatus.signIn;
    });
  }
}
