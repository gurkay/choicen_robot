import 'package:choicen_robot/components/already_have_an_account_check.dart';
import 'package:choicen_robot/components/rounded_button.dart';
import 'package:choicen_robot/components/rounded_input_field.dart';
import 'package:choicen_robot/constants/constants.dart';
import 'package:choicen_robot/models/user.dart';
import 'package:choicen_robot/screens/login/screen_login.dart';
import 'package:choicen_robot/services/response/response_user.dart';
import 'package:flutter/material.dart';

class ScreenSingup extends StatefulWidget {
  static String routeName = '/screen_singup';

  @override
  State<ScreenSingup> createState() => _ScreenSingupState();
}

class _ScreenSingupState extends State<ScreenSingup> implements CallBackUser {
  User _user = new User('empty', 'empty');

  ResponseUser? _responseUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(cTitleScreenSingUp),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: 'Mail Adresiniz',
                onChanged: (value) {
                  _user.userEmail = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: 'Sifreniz',
                onChanged: (value) {
                  _user.userPassword = value;
                },
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: 'Kaydet',
                press: _save,
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pushNamed(
                    context,
                    ScreenLogin.routeName,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    await _responseUser!.doInsert(_user);
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void onUserError(String error) {
    _showSnackBar(context, 'onLoginError ::: $error');
  }

  @override
  void onUserSuccess(User user) {
    _showSnackBar(context, 'Kayit basarili');
  }
}
