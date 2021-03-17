import 'package:fashionify/widgets/Drawer/DrawerClass.dart';
import 'package:flutter/material.dart';

class TermsClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container( child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Terms & Conditions',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              color: Colors.blue,
            ),
            Container(
              color: Colors.blue,
            ),

          ],
        ),
      ),
    ),
    );
  }
}
