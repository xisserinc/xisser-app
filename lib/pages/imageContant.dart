import 'dart:ui';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageContainerClass extends StatelessWidget {
  String __assetPath1;

  ImageContainerClass(this.__assetPath1);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 337,
      height: 350,
      color: Colors.green[100],
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      constraints: BoxConstraints.expand(height: 270),
      child: Image.asset(
        __assetPath1,
        fit: BoxFit.cover,
      ),
    );
  }
}

// ignore: must_be_immutable
class SubImageContant extends StatelessWidget {
 
   String myDetails;
    SubImageContant(this.myDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 337,
      height: 50,
      padding: EdgeInsets.all(5),
      color: Colors.black38,
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Text(
        myDetails,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400,fontSize: 15),
      ),
    );
  }
}
