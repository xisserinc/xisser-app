import 'package:fashionify/pages/product.dart';
import 'package:fashionify/scoped-models/main.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import './price_tag.dart';
import './address_tag.dart';
import '../ui_elements/title_default.dart';
import '../../models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard(this.product);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: TitleDefault(widget.product.title),
          ),
          Flexible(
            child: SizedBox(
              width: 8.0,
            ),
          ),
          Flexible(child: PriceTag(widget.product.price.toString())),
        ],
      ),
    );
  }



  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(

              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 8.0),
                    child: Icon(widget.product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 8.0),
                    child: Text("Request", style: TextStyle(
                      color: Colors.white
                    ),),
                  )
                ],
              ),
              onPressed: () {
                model.selectProduct(widget.product
                    .id); //set index b4 executing(reason for null at each end of method)
                model.toggleProductFavoriteStatus();

                SnackBar snackbar = new SnackBar(content: Text('Request Sent'),
                );
                Scaffold.of(context).showSnackBar(snackbar);

                
              },
            ),
          ],
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Card(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(widget.product),//(widget.product,2),
                  ),
                
              );
            },
            child: FadeInImage(
              image: NetworkImage(widget.product.image),
              placeholder: AssetImage('assets/xisser.jpg'),
              height: 310.0,
              fit: BoxFit.cover,
            ),
          ),
          //_buildTitlePriceRow(),
          AddressTag('Date | Relax | Enjoy'),
          _buildActionButtons(context)
        ],
      ),
    )
 ,);
     }
}