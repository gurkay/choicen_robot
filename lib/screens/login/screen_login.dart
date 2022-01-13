import 'package:choicen_robot/components/already_have_an_account_check.dart';
import 'package:choicen_robot/components/rounded_button.dart';
import 'package:choicen_robot/components/rounded_input_field.dart';
import 'package:choicen_robot/components/rounded_password_field.dart';
import 'package:choicen_robot/models/user.dart';
import 'package:choicen_robot/screens/home/screen_home.dart';
import 'package:choicen_robot/screens/singup/screen_singup.dart';
import 'package:choicen_robot/services/response/response_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      sharedPreferences.setString('userEmail', user.userEmail);
      sharedPreferences.setString('userPassword', user.userPassword);
    });
  }

  void _submit() {
    if (_email == null || _password == null) {
      _showSnackBar(context, 'Email ve Pasaport Boş Olamaz');
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
        return ScreenHome();
    }
  }

  Scaffold loginStatusNotSignIn() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(cTitleScreenLogin),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: 'Mail Adresiniz',
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
        ),
      ),
    );
  }

  @override
  void onUserError(String error) {
    _showSnackBar(context, 'onLoginError ::: $error');
  }

  @override
  void onUserSuccess(User user) {
    setPref(user);
    setState(() {
      _loginStatus = LoginStatus.signIn;
    });
  }
}
