import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckedBox extends StatefulWidget {
  String text;
  CheckedBox(text){
    // ignore: unnecessary_statements
    this.text;
  }
  @override
  _CheckedBoxState createState() => _CheckedBoxState();
}

class _CheckedBoxState extends State<CheckedBox> {
  bool firstBox = false;

  get text =>CheckedBox(text);
  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$text'),
          Checkbox(
              checkColor: Colors.blue,
              activeColor: Colors.white,
              value: this.firstBox, onChanged: (bool value){
                setState(() {
                  this.firstBox = value;
                });
          })
        ],
      );
  }
}
