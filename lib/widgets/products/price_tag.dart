import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Text(
        '- $price Years',
        style: TextStyle(color: Colors.white70, fontSize: 22,
        fontWeight: FontWeight.normal),
      );
  }
}
