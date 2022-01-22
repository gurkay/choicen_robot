import 'package:flutter/material.dart';
import '../constants/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  TextFieldContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 1,
        vertical: 2,
      ),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.purple[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
