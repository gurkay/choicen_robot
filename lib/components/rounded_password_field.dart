import 'package:flutter/material.dart';

import '../components/text_field_container.dart';
import '../constants/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String? hintText;
  RoundedPasswordField({
    this.onChanged,
    this.hintText,
  });

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        cursorColor: cPrimaryLightColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: const Icon(
            Icons.lock,
            color: cPrimaryColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
