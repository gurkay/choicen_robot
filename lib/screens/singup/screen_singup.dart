import 'package:flutter/material.dart';

import '../../components/already_have_an_account_check.dart';
import '../../components/rounded_button.dart';
import '../../components/rounded_input_field.dart';
import '../../constants/constants.dart';
import '../../models/user.dart';
import '../../screens/login/screen_login.dart';
import '../../services/response/response_user.dart';

class ScreenSingup extends StatefulWidget {
  static String routeName = '/screen_singup';

  @override
  State<ScreenSingup> createState() => _ScreenSingupState();
}

class _ScreenSingupState extends State<ScreenSingup> implements CallBackUser {
  String? _userEmail, _userPassword;

  ResponseUser? _responseUser;

  _ScreenSingupState() {
    _responseUser = new ResponseUser(this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            hintText: 'Kullanıcı Adınız',
            onChanged: (value) {
              _userEmail = value;
            },
          ),
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            hintText: 'Sifreniz',
            onChanged: (value) {
              _userPassword = value;
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
    );
  }

  void _save() async {
    await _responseUser!.doInsert(User(_userEmail, _userPassword));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void onUserError(String error) {
    _showSnackBar(context, 'onSingupError ::: $error');
    print('onSingUpError ::: onUserError ::: $error');
  }

  @override
  void onUserSuccess(User user) {
    print('screen_singup:::onUserSuccess:::userId: ${user.userId}');
    _showSnackBar(context, 'Kayit basarili');
  }
}
