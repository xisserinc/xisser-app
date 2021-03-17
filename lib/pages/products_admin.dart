import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import './product_list.dart';
import 'package:fashionify/scoped-models/main.dart';
import '../widgets/ui_elements/logout_list_tile.dart';

class ProductsAdminPage extends StatelessWidget {
  //final BuildContext contextMain;
  final MainModel model;
  final StreamChatClient client;
  ProductsAdminPage(this.model,this.client); //2

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('All Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/'); //'/products'
            },
          ),
          Divider(),
          LogoutListTile(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Products',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Container(color:Colors.tealAccent),
            Container(color: Colors.blue,)
            //ProductListPage(model,client),
          ],
        ),
      ),
    );
  }
}
