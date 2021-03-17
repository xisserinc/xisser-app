
import 'package:fashionify/pages/product_edit.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_persistence/stream_chat_persistence.dart';
import './pages/auth.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';
import 'message/choose_user_page.dart';
import 'scoped-models/main.dart';
import './models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashionify/API.dart';
import 'dart:convert';

final chatPersistentClient = StreamChatPersistenceClient(
  logLevel: Level.INFO,
  connectionMode: ConnectionMode.background,
);
void main() async {
     WidgetsFlutterBinding.ensureInitialized();
  // final secureStorage = FlutterSecureStorage();
   final apiKey = '6au9jdk3bz45';//await secureStorage.read(key: kStreamApiKey);
   //final userId = 'xisser';//await secureStorage.read(key: kStreamUserId);
  //    final apiKey = await secureStorage.read(key: kStreamApiKey);
  // final userId = await secureStorage.read(key: kStreamUserId);

  final client = StreamChatClient(
    apiKey ?? kDefaultStreamApiKey,
    logLevel: Level.INFO,
  )..chatPersistenceClient = chatPersistentClient;

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
   String imageUrl;
   String id;
   String name;
   if(prefs.getString("imageUrl") != null){
     imageUrl = prefs.getString("imageUrl").replaceAll("&", "eqqqe");
     id = prefs.getString("id");
     name = prefs.getString("name");

      if (apiKey != null) {
        
    var url;
     url = 'https://secure-eyrie-88104.herokuapp.com/api?Query={"id":"$id","name":"$name","role":"user","image":"$imageUrl"}';
     var data = await getData(url);
       var decodedData = jsonDecode(data);
     final token =decodedData;
    //final token ='eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiTGF0aWZhIn0.eJOIWUSvz_7Qx6Cl7Am2_hVqNl_Fv_Ps79O9AbyV4kY';
    //final token = await secureStorage.read(key: kStreamToken);
    await client.connectUser(
      User(id: id),
      // extraData: {
      //   'image':
      //       'https://getstream.io/random_png/?id=calm-disk-8&amp;name=Calm+disk',
      // },
      token,
    );
  }
     
   }
  
   print("my detailssssssssssss");
   print(imageUrl);
   print(id);
   print(name);

 
  runApp(MyApp(client));
}

class MyApp extends StatefulWidget {
  final StreamChatClient client;
  MyApp(this.client);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;
  bool _isSignup = true;
  @override
  void initState() {
    
    //Message(client);
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    _model.userSubjectAuthMode.listen((bool isSignup) {
      setState(() {
        _isSignup = isSignup;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext contextMain) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.orange,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepPurple),
        // home: AuthPage(),
        routes: {
          //AppRoutes.generateRoute,
          '/': (BuildContext context) =>//ProductsPage(_model,widget.client),
             ( !_isAuthenticated ?/*ProductEditPage()*/ AuthPage() : _isSignup?ProductEditPage(): ProductsPage(_model,widget.client)),
          // '/products': (BuildContext context) => ProductsPage(_model),
          '/admin': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductsAdminPage(_model,widget.client), //1
          '/Signup': (BuildContext context) =>ProductEditPage(),//added******
        },
        onGenerateRoute: (RouteSettings settings) {
          
          if (!_isAuthenticated) {
            return MaterialPageRoute<bool>(
                builder: (BuildContext context) => AuthPage());
          }
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final String productId =
                pathElements[2]; //final int index = int.parse(pathElements[2]);
            //model.selectProduct(productId);
            final Product product =
                _model.allProducts.firstWhere((Product product) {
              return product.id == productId;
            });
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : ProductPage(product),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : ProductsPage(_model,widget.client));
        },
      ),
    );
  }
}
