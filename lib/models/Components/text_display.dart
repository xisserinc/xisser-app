
import 'package:flutter/material.dart';

class TextClass extends StatelessWidget {
  final String usedText;
  TextClass(this.usedText);

  @override
  Widget build(BuildContext context) {
    return Text(
      usedText,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}