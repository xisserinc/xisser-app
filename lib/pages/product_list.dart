
import 'package:fashionify/message/message.dart';
import 'package:fashionify/models/product.dart';
import 'package:fashionify/scoped-models/main.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:fashionify/API.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashionify/message/choose_user_page.dart';
import 'package:fashionify/models/product.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';

class ProductListPage extends StatefulWidget {
  final StreamChatClient client;
  final MainModel model;
  ProductListPage(this.model, this.client);

  @override
  State<StatefulWidget> createState() {
    return _ProductListPage();
  }
}

class _ProductListPage extends State<ProductListPage> {
//     final apiKey = '6au9jdk3bz45';//await secureStorage.read(key: kStreamApiKey);
//   final userId = 'xisser';
// //   final chatPersistentClient = StreamChatPersistenceClient(
// //   logLevel: Level.INFO,
// //   connectionMode: ConnectionMode.background,
// // );

//  var client;

//  var chatPersistentClient;
  @override
  initState() {
//     print("ohh njoo tufurahiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
//     print(widget.model.allProducts.length);
//     //widget.model.fetchProducts(onlyForUser: true);
//     //widget.model.fetchRequestProducts(onlyForUser: true);

    
//   WidgetsFlutterBinding.ensureInitialized();
//    chatPersistentClient = StreamChatPersistenceClient(
//   logLevel: Level.INFO,
//   connectionMode: ConnectionMode.background,
// );

//   client = StreamChatClient(
//     apiKey ?? kDefaultStreamApiKey,
//     logLevel: Level.INFO,
//   )..chatPersistenceClient = chatPersistentClient;
//     autoChatSync(/*widget.model.allProducts*/);
    super.initState();
  }

//   void autoChatSync(/*List<Product> products*/) async {
    
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    String imageUrl = prefs.getString("imageUrl").replaceAll("&", "eqqqe");
//    String id = prefs.getString("id");
//    String name = prefs.getString("name");
//    print("my detailssssssssssss");
//    print(imageUrl);
//    print(id);
//    print(name);

//    //final apiKey = '6au9jdk3bz45';//await secureStorage.read(key: kStreamApiKey);
//    //final userId = 'xisser';//await secureStorage.read(key: kStreamUserId);

//   //  client = StreamChatClient(
//   //   apiKey ?? kDefaultStreamApiKey,
//   //   logLevel: Level.INFO,
//   // )..chatPersistenceClient = chatPersistentClient;
    
//     //Map<String, String> details = {"id": id, "name": name, "role": "user","image":imageUrl};
//     var url;//.toString();
//      print("looking for more ********************************************************");
//   if (userId != null) {
//     print("looking for more ********************************************************");
//     print(imageUrl);
//     url = 'https://secure-eyrie-88104.herokuapp.com/api?Query={"id":"$id","name":"$name","role":"user","image":"$imageUrl"}';//
//      var data = await getData(url);
//      //{"id":"$id","name":"$name","role":"user","image":"$imageUrl"}
//           print(" data is  $data  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
//        var decodedData = jsonDecode(data);
//     //  print("looking for more #######################################################");
//       print(" decodede data is$decodedData  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
//      // var decodedData = jsonDecode(data);
//       //setState(() {
//      // queryText = decodedData['Query'];
//     // });
//      //final token = decodedData;//'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiU2Ftd2VsIn0.7nBUx0MNKP-NscvSGQ7Ags-ARnR6gmwMTIU_-u-uG6A';
//      final token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiSllhU1FEemdPUWE0ZW9KVUFFZWlIbnh0MTg0MiJ9.eIi3Y9E5yRaeLw5gJQuAFZmWWRa3ZOpBf360yxXjBDY';
//    print("my toooken is $token");
//    print(data);
//     await client.connectUser(
//       User(id: userId),
//       token,
//     );
//   }
//  }

  // List<String> wishlistProductIds( List<Product> products){
  //     List<String> wishlistDateIds =[];
  //    products.forEach((product) {
  //      wishlistDateIds.add(product.id);
  //    });
  // }

  // Widget _buildEditButton(BuildContext context, int index, MainModel model) {
  //  return //MyMessage(widget.client);

  //       IconButton(
  //         icon: Icon(
  //           Icons.message,
  //           color: Colors.deepOrange,
  //         ),
  //         onPressed: () {
  //           //   model.selectProduct(model.allProducts[index].id); //ni mungu tuuu
  //           // Navigator.of(context).push(
  //           //   MaterialPageRoute(
  //           //     builder: (BuildContext context) {
  //           //       return Container(
  //           //         color: Colors.grey,
  //           //       ); //5 challenge
  //           //     },
  //           //   ),
  //           // );
  //         },
  //       );
  //     }
    
      @override
      Widget build(BuildContext context) {
        print("*******************************************");
        print(widget.model.allProducts.length);
        return ScopedModelDescendant(//we have access to the model..
            builder: (
          BuildContext context,
          Widget child,
          MainModel model,
        ) {
         return MyMessage(widget.model,widget.client/*.allProducts*/);
          // return ListView.builder(
          //   addAutomaticKeepAlives: true,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Column(
          //       children: <Widget>[
          //         GestureDetector(
          //           onTap: () {
          //             //  model.selectProduct(model.allProducts[index].id); //ni mungu tuuu
          //             // Navigator.of(context).push(
          //             //   MaterialPageRoute(
          //             //     builder: (BuildContext context) {
          //             //       return Container(
          //             //         color: Colors.pink,
          //             //       ); //5 challenge
          //             //     },
          //             //   ),
          //             // );
          //           },
          //           child: Dismissible(
          //             key: Key(model.allProducts[index].title),
          //             onDismissed: (DismissDirection direction) {
          //               if (direction == DismissDirection.endToStart) {
          //                 //model.selectProduct(model.myProductId);
          //                 model.selectProduct(model.allProducts[index]
          //                     .id); //set index b4 excuting(reaso for null at each end of method)
          //                 //model
          //                 //.toggleProductFavoriteStatus(model.allProducts[index]
          //                 // .userId);
          //                 // model.selectProduct(model.allProducts[index]
          //                 //    .id); //b4 deleting u have to select the product index
          //                 model.deleteProduct(model.allProducts[index].userId);
          //               }
          //             },
          //             background:
          //                 Container(color: Colors.red), //background for swipping..
          //             child: ListTile(
          //                 leading: CircleAvatar(
          //                   backgroundImage:
          //                       NetworkImage(model.allProducts[index].image),
          //                 ),
          //                 title: Text(model.allProducts[index].title),
          //                 subtitle: Text(
          //                     'age : ${model.allProducts[index].price.toString()}'), //escaping character...
          //                 trailing: _buildEditButton(context, index, model)),
          //           ),
          //         ),
          //         Divider(),
          //       ],
          //     );
          //   },
          //   itemCount: model.allProducts.length,
          // );
         // return Container(color: Colors.greenAccent,);
        });
      }
    }
    
    