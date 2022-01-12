import 'package:choicen_robot/components/already_have_an_account_check.dart';
import 'package:choicen_robot/components/rounded_button.dart';
import 'package:choicen_robot/components/rounded_input_field.dart';
import 'package:choicen_robot/components/rounded_password_field.dart';
import 'package:choicen_robot/models/user.dart';
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

  @override
  void initState() {
    super.initState();
    getPref();
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
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return loginStatusNotSignIn();
      case LoginStatus.signIn:
        return Text('Giris');
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
                press: () {},
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
  }
}
