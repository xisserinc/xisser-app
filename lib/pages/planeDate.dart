import 'package:fashionify/models/Components/text_display.dart';
import 'package:fashionify/models/product.dart';
import 'package:fashionify/pages/profile/ContactClass.dart';
import 'package:fashionify/pages/profile/Terms&Conditions.dart';
import 'package:fashionify/pages/profile/button_class.dart';
import 'package:fashionify/scoped-models/main.dart';
import 'package:fashionify/widgets/ui_elements/logout_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'imageContant.dart';


class PlanDate extends StatefulWidget {
  final Product product;

  PlanDate(this.product);

  @override
  _PlanDateState createState() => _PlanDateState();
}

class _PlanDateState extends State<PlanDate> {
  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                onPressed: () {
                  model.selectProduct(widget.product
                      .id); //set index b4 executing(reason for null at each end of method)
                  model
                      .toggleProductFavoriteStatus(); //changing whole product status
                },
                color: Colors.red,
                   child: Container(
                   child: Text(widget.product.title != null
                       ? Text('Plan')
                       : ('Planned')),

                 ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Xisser',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                decoration: BoxDecoration(color: Colors.teal),
              ),
              ListTile(
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
                title: Text('About Us'),
              ),
              ListTile(
                trailing: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              ListTile(
                trailing: Icon(Icons.phone),
                title: Text('Contacts & Support'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactClass(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('terms & Conditions'),
                trailing: Icon(Icons.add_alert),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TermsClass(),
                    ),
                  );
                },
              ),
              LogoutListTile()
            ],
          ),
        ),
        body:Container(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
                child: TextClass("Plan A Date With Babra"),
              ),
              Container(
                width: double.infinity,
                height: 400,
                margin: EdgeInsets.fromLTRB(5, 0, 5, 15),
                child: ImageContainerClass("assets/images/g5.jpg"),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 247, bottom: 5),
                      child: TextClass("Suggest a Place"),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 120.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          PlacesClass(Colors.red),
                          PlacesClass(Colors.black12),
                          PlacesClass(Colors.teal),
                          PlacesClass(Colors.green)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: ButtonClass("Send Request"),
                    )
                  ],
                ),
              )
            ],
          ),
        )

      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class PlacesClass extends StatelessWidget {
  var colorInit;

  PlacesClass(this.colorInit);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      width: 150,
      color: colorInit,
    );
  }
}
