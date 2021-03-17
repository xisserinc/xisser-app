import 'package:flutter/material.dart';

class TitleDefault extends StatelessWidget {
  final String title;

  TitleDefault(this.title);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Text(
      title,
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: deviceWidth > 700 ? 28.0 : 28.0,
        fontWeight: FontWeight.normal,
        color: Colors.white70,
      ),
    );
  }
}
