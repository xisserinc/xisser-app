import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../../models/product.dart';
import './product_card.dart';
import 'package:fashionify/scoped-models/main.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
    Widget productCards;
    if (products.length > 0) {
      productCards = PageView.builder(
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        reverse: false,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(products[index]);
        },
      );

      //  ListView.builder(
      //   itemBuilder: (BuildContext context, int index) =>
      //       ProductCard(products[index]),
      //   itemCount: products.length,
      // );

    } else {
      productCards = Container();
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (
        //acquiring data from productModel using
        BuildContext context, //scope model package imported...
        Widget child, //whenever data changes all these code gets excuted..
        MainModel model,
      ) {
        return _buildProductList(
            model.displayedProducts); //products is a getter method...
      },
    );
  }
}
