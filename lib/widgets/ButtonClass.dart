import 'package:fashionify/models/product.dart';
import 'package:fashionify/pages/product.dart';
import 'package:fashionify/scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// ignore: must_be_immutable
class ButtonClass1 extends StatelessWidget {
  String buttonText;
  Product product;

  ButtonClass1(this.buttonText, this.product);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
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
            model.selectProduct(product.id);
            model.toggleProductFavoriteStatus();
            //    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductPage(product,3)));
            SnackBar snackbar = new SnackBar(content: Text('Request Sent'),
                );
                Scaffold.of(context).showSnackBar(snackbar);
          },
        ),
      );
    });
  }
}
