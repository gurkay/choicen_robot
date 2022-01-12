import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final VoidCallback? press;
  final Color? color, textColor;
  RoundedButton({
    this.text,
    this.press,
    this.color,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: ElevatedButton(
          child: Text(
            text!,
            style: TextStyle(
              color: textColor,
            ),
          ),
          onPressed: press,
        ),
      ),
    );
  }
}
