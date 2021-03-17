
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonClass extends StatefulWidget {

  var buttonText;
  ButtonClass(this.buttonText);

  @override
  _ButtonClassState createState() => _ButtonClassState(buttonText);
}

class _ButtonClassState extends State<ButtonClass> {
  var buttonText;
  _ButtonClassState(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 35,
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: RaisedButton(
        color: Colors.deepPurple,
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
        ),
        onPressed: () {
          setState(() {
            buttonText='Request Sent';
            // ignore: unnecessary_statements
          });

        },
      ),
    );
  }
}
