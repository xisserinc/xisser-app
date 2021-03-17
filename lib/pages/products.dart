import 'package:fashionify/pages/product_manager.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../scoped-models/main.dart';
import '../widgets/ui_elements/logout_list_tile.dart';
import 'product_list.dart';
import 'profile/profile.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;
  final StreamChatClient client;
  //int age;
  ProductsPage(this.model,this.client);
  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage>{
   List<Widget> _children;
   int _currentIndex = 0;
  @override
  initState(){//fetch retuns null
    widget.model.fetchProducts();
    //widget.model.fetchRequestProducts();
    super.initState();
        _children = [
      SelectedTabWidget(widget.model),
      ProductListPage(widget.model,widget.client),
      Profile(widget.model)
  ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if(index==0){
          widget.model.fetchProducts();
      }
      else if(index == 1){
         widget.model.fetchRequestProducts();
        //view those who have requsted my date
      //widget.model.fetchRequestProducts(onlyForUser: true);
      }
      else {
        //fetch my profile
        widget.model.fetchRequestProducts();
      }
  }
  
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Xisser'),
          ),
          // ListTile(
          //   leading: Icon(Icons.edit),
          //   title: Text(''),
          //   onTap: () {
          //     Navigator.pushReplacementNamed(context, '/admin');
          //   },
          // ),
          Divider(),
          LogoutListTile(),
        ],
      ),
    );
  }
//displaying a loading spinner

  // Widget _buildProductsList(){

  //   return ScopedModelDescendant/*<MainModel>*/(//ni mung tuuuuu

  //     builder: (BuildContext context, Widget child, MainModel model){

  //       Widget content = Center(child: Text('no products found!sam!!'),);
  //       if(model.displayedProducts.length>0 && !model.isLoading){//we have  products&not loading.. 
  //         content = Products();
  //       }else if(model.isLoading){
  //         content=Center(child: CircularProgressIndicator(),);
  //       } 
  //       return RefreshIndicator(onRefresh: model.fetchProducts,child: content,);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // actions: <Widget>[
        //   ScopedModelDescendant<MainModel>(
        //     builder: (BuildContext context, Widget child, MainModel model) {
        //       return IconButton(
        //         color: Colors.blue,
        //         icon: Icon(model.displayFavoritesOnly
        //             ? Icons.favorite
        //             : Icons.favorite_border),
        //         onPressed: () {
        //           model.toggleDisplayMode();//swing
        //         },
        //       );
        //     },
        //   )
        // ],
      ),
      body:  _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(


            backgroundColor: Colors.white,
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [


                BottomNavigationBarItem(
                  icon: new Icon(Icons.home),
                  title: Text("Home"),
                ),


                BottomNavigationBarItem(
                  icon: new Icon(Icons.notifications),
                  title: Text("Request"),
                ),


                BottomNavigationBarItem(
                  icon: new Icon(Icons.account_circle),
                  title: Text("Profile"),
                )


              ]),//Products(),
    );
  }
}
