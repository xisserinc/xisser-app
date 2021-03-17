import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'Contacts & Support',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(bottom: 10,top: 5),
          child: ListView(
            children: [
              UserSuport("Richard Bukuku (C.E.O)", "richardjb631@gmail.com",
                  "+225 629775590"),
              UserSuport('Samuel Lucas (Payments Support)', 'samuel@gmail.com',
                  '+255 783694560'),
              UserSuport("Dian Joseph (Legal Support)", "Dee123@gmail.com",
                  "+255 675604975"),
              UserSuport('Emmaculate (Marketing Support)', 'emmacute@gmail.com',
                  '+255 654594986'),
              UserSuport('Shabo Andrew (Operational Support)',
                  'shabdevops@gmail.com', '+255 620307506'),
            ],
          ),
        ),
      ),
    );
  }
}

class UserSuport extends StatelessWidget {
  var description, phoneNo, email;

  UserSuport(this.description, this.email, this.phoneNo);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
      padding: EdgeInsets.all(10),
      color: Colors.grey,
      child: Column(
        children: [
          Row(
            children: [
              TextClass6(description, 5, 1),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.phone),
                onPressed: null,
              ),
              TextClass6(phoneNo, 10, 2),
            ],
          ),
          Row(
            children: [
              IconButton(icon: Icon(Icons.email),color: Color(0xFFFFFFFF), onPressed: null),
              TextClass6(email, 10, 2)
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class TextClass6 extends StatelessWidget {
  var moreDescript;
  double number;
  var selectNo;
  TextClass6(this.moreDescript, this.number, this.selectNo);

  @override
  Widget build(BuildContext context) {
    if (selectNo == 1) {
      return Container(
        // margin: EdgeInsets.fromLTRB(number, 5, 0, 0),
        child: Text(
          moreDescript,
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      );
    } else {
      return Container(
        // margin: EdgeInsets.fromLTRB(number, 5, 0, 0),
        child: Text(
          moreDescript,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black38),
        ),
      );
    }
  }
}
