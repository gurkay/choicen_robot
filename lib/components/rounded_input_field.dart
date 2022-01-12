import '../components/text_field_container.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData iconData;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final TextInputType keyboardType;

  RoundedInputField(
    this.hintText,
    this.iconData,
    this.onChanged,
    this.controller,
    this.keyboardType,
  );

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: cPrimaryLightColor,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          icon: Icon(
            iconData,
            color: cPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
