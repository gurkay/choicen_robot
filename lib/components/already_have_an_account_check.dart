import 'package:flutter/material.dart';
import '../constants/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback? press;
  AlreadyHaveAnAccountCheck({
    this.login = true,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? 'Bir kaydiniz yok mu? ' : 'Kaydim var ',
          style: const TextStyle(color: cPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? 'Kayit olun ' : 'Giris yap',
            style: const TextStyle(
              color: cPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
