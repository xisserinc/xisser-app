// import "package:flutter/material.dart";

// class ProductManager extends StatelessWidget {
  
//   final  List<Map<String,dynamic>> products;

//   ProductManager(this.products);
  
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//        // Expanded(
//        // child:  ,
//        // )
//       ],
//     );
//   }
// }



import 'package:fashionify/scoped-models/main.dart';
import 'package:fashionify/widgets/products/products.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SelectedTabWidget extends StatelessWidget {
  final MainModel model;
  SelectedTabWidget(this.model);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant/*<MainModel>*/(//ni mung tuuuuu

      builder: (BuildContext context, Widget child, MainModel model){

        Widget content = Center(child: Text('fetching data...'),);
        if(model.displayedProducts.length>0 && !model.isLoading){//we have  products&not loading.. 
          content = Products();
        }else if(model.isLoading){
          content=Center(child: CircularProgressIndicator(),);
        } 
        return RefreshIndicator(onRefresh: model.fetchProducts,child: content,);
      },
    );
  }//ProductsPage(this.model);
  }

