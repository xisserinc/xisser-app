import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:scoped_model/scoped_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; //MediaType()
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';
import '../models/auth.dart';
import '../models/product.dart';
import '../models/user.dart';
//import 'package:stream_chat_flutter/stream_chat_flutter.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  String _selProductId;
  String myProductId;
  bool selectMyProduct = false;
  User _authenticatedUser;
  bool _isLoading = false; //wen true it loads..

}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false; //if true show only the favorites
  //returning copy of the list
  List<Product> get allProducts {
    //helps you get the data of product
    return List.from(_products); //return a list made from products
  }

  //displaying the favourited products...
  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products
          .where((Product product) => product.isFavorite)
          .toList(); //displaying favourites
    }
    return List.from(_products.reversed); //displaying all
  }

  int get selectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  String get selectedProductId {
    return _selProductId;
  }

  setClient(String client){

  }

  Product get selectedProduct {
    if (selectedProductId == null) {
      return null;
    }

    return _products.firstWhere((Product product) {
      return product.id == _selProductId;
    });
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }


  Future<Map<String, dynamic>> uploadImage(File image,
      {String imagePath}) async {
    final mimeTypeData =
        lookupMimeType(image.path).split('/'); //image/jpg=>'image' & 'jpg'
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(
        /////problem/////////////////////////////////////////////////////////////////////////////////////////
        'https://us-central1-flutter-products-c24f0.cloudfunctions.net/storeImage')); //11111

    final file = await http.MultipartFile.fromPath("image", image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.files.add(file);
    if (imagePath != null) {
      imageUploadRequest.fields['imagePath'] = Uri.encodeComponent(imagePath);
    }
    imageUploadRequest.headers['Authorization'] =
        'Bearer ${_authenticatedUser.token}';
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('Something went wrong');
        print(json.decode(response.body));
        return null;
      }
      final responseData = json.decode(response.body);
      return responseData;
    } catch (error) {
      print(error);
      return null;
    }
  }

  //storing information in the data base
  Future<bool> addProduct(String title, String description, File image,
      double price, String gender) async {
    //async operations
    _isLoading = true; //before sending data
    notifyListeners();
    //upload image
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (gender != null) {
      prefs.setString('gender', gender);
    }
    final uploadData = await uploadImage(image);

    if (uploadData == null) {
      print('Upload failed!');
      return false;
    }

    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'price': price,
      'gender': gender,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
      'imagePath': uploadData['imagePath'],
      'imageUrl': uploadData['imageUrl'],
    };
    try {
      //sending products data to the server
      final http.Response response = await http.post(
          'https://flutter-products-c24f0.firebaseio.com/$gender.json?auth=${_authenticatedUser.token}',
          body: json.encode(productData)); //22222
      //handling accessibility before posting data..
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners(); //notifyChanges in spinner stopping rotating
        return false;
      }
      //fetching data
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'], //name:wet453h
          title: title,
          description: description,
          image: uploadData['imageUrl'], //////////////////////////////
          imagePath:
              uploadData['imagePath'], ///////////////////////////////////
          price: price,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
          //print("miujiza huwa inatokea sometimesssssssssssssssssssssssssssssssssssssss");
          prefs.setString("imageUrl", newProduct.image);
          prefs.setString("id", newProduct.userId);
          prefs.setString("name", newProduct.title);
          // print(newProduct.userId);
          // print(newProduct.id);
      _products.add(newProduct);
      _isLoading = false; //data is sent
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false; //data is sent
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct(
      String title, String description, File image, double price) async {
    _isLoading = true;
    notifyListeners();
    String imageUrl = selectedProduct.image;
    String imagePath = selectedProduct.imagePath;
    if (image != null) {
      final uploadData = await uploadImage(image);

      if (uploadData == null) {
        print('Upload failed!');
        return false;
      }
      imageUrl = uploadData['imageUrl'];
      imagePath = uploadData['imagePath'];
    }
    //data to be updated...
    Map<String, dynamic> updateData = {
      //data from user...
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'imagePath': imagePath,
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId
    };
    final String genderCat = await fetchGender();
    try {
      final http.Response response = await http.put(
          'https://flutter-products-c24f0.firebaseio.com/genderCat/${selectedProduct.id}.json?auth=${_authenticatedUser.token}', //updating my product data..
          body: json.encode(updateData)); //3333
      //here updating is done
      _isLoading = false;
      final Product updatedProduct = Product(
          id: selectedProduct.id, //taking id of the existing product...
          title: title,
          description: description,
          image: imageUrl,
          imagePath: imagePath,
          price: price,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId);
      //operating by using Id's
      _products[selectedProductIndex] = updatedProduct; //call by reference
      notifyListeners(); //to be sure of the change
      return true;
    } catch (error) {
      _isLoading = false; //data is sent
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProduct([String myProductId1]) async {
    _isLoading = true;
    _products.removeAt(selectedProductIndex);
    _selProductId = null; //no selected product...
    notifyListeners();
    String genderSel;
    final String genderCat = await fetchGender();
    // if (genderCat != null) {
    //   /*********
    //    * if data  is cleared we wii have to handle nit***********/
    // }
    genderCat == 'male' ? genderSel = 'female' : genderSel = 'male';
    return http
        .delete(
            'https://flutter-products-c24f0.firebaseio.com/$genderCat/$myProductId/wishlistUsers/$myProductId1.json?auth=${_authenticatedUser.token}')
        .then((http.Response response) {
      //4444
      //done deleting
      _isLoading = false;

      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false; //data is sent
      notifyListeners();
      return false;
    });
  }

  Future<String> fetchGender() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getString('gender');
    });
  }

  Future<Null> fetchProducts({onlyForUser = false}) async {
    _isLoading = false; //b4 getting data..
    _products = [];
    notifyListeners();
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    String genderSel;
    final String genderCat = await fetchGender();
    // if (genderCat != null) {
    //   /*********
    //    * if data  is cleared we wii have to handle nit***********/
    // }
    genderCat == 'male' ? genderSel = 'female' : genderSel = 'male';
    return http //token goes to access data with the request of data access
        .get(
            'https://flutter-products-c24f0.firebaseio.com/$genderSel.json?auth=${_authenticatedUser.token}')
        .then<Null>((http.Response response) {
      //5555
      //fetcing the data
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      //when there is no data
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['imageUrl'],
            imagePath: productData['imagePath'],
            price: productData['price'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            isFavorite: productData['wishlistUsers'] == null
                ? false
                : (productData['wishlistUsers'] as Map<String, dynamic>)
                    .containsKey(_authenticatedUser.id));

        fetchedProductList.add(product);
      });

      _products = onlyForUser
          ? fetchedProductList.where((Product product) {
              return product.userId == _authenticatedUser.id;
            }).toList()
          : fetchedProductList;

      _isLoading = false; //after getting data..
      notifyListeners();
      _selProductId = null;
      return;
    }).catchError((error) {
      _isLoading = false; //data is sent
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchRequestProducts({onlyForUser = false}) {
    _isLoading = true; //b4 getting data..
    _products = [];
    notifyListeners();

    return fetchGender().then((genderCat) {
      print(
          "$genderCat]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
      String genderSel;
      // if (genderCat != null) {
      //   /*********
      //    * if data  is cleared we wii have to handle nit***********/
      // }
      genderCat == 'male' ? genderSel = 'female' : genderSel = 'male';
      downloadFile(genderSel).then((value) {
        return http //token goes to access data with the request of data access
            .get(
                'https://flutter-products-c24f0.firebaseio.com/$genderCat.json?auth=${_authenticatedUser.token}')
            .then<Null>((http.Response response) {
          //5555
          //fetcing the data
          print("33333333333333333333333 ${_products.length}.");
          final List<Product> fetchedProductList = [];
          final List<Product> fetchedProductProfileList = [];
          final List<String> wishlistProductIdList = [];
          Map<String, dynamic> productListData = json.decode(response.body);
          print(productListData.length);
          if (onlyForUser == true) {
            print(value.length);
            productListData.addAll(value);
            print("===================================================");
            print(productListData.length);
          }
          //when there is no data

          if (productListData == null) {
            _isLoading = false;
            notifyListeners();
            return;
          }

          productListData.forEach((String productId, dynamic productData) {
            print("44444444444444444444444444444444 ${_products.length}.");
            final Product product = Product(
                id: productId,
                title: productData['title'],
                description: productData['description'],
                image: productData['imageUrl'],
                imagePath: productData['imagePath'],
                price: productData['price'],
                gender: productData['gender'],
                userEmail: productData['userEmail'],
                userId: productData['userId'],
                isFavorite: productData['wishlistUsers'] == null
                    ? false
                    : (productData['wishlistUsers'] as Map<String, dynamic>)
                        .containsKey(_authenticatedUser.id)); ////shortcut
            print("5555555555555555555555555 ${_products.length}.");
            fetchedProductList.add(product);
            print("666666666666666666666666666666 ${_products.length}.");
            if (product.userId == _authenticatedUser.id) {
              print("77777777777777777777777777777 ${_products.length}.");
              if (onlyForUser == false) {
                fetchedProductProfileList.add(product);
                print("breaaaaaaaaaaaaaaaaaaaaak");

                return;
              }
              print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
              myProductId = productId;

              if (productData['wishlistUsers'] != null) {
                (productData['wishlistUsers'] as Map<String, dynamic>)
                    .forEach((String productId, dynamic isFavourite) {
                  print("8888888888888888888888888888 ${_products.length}.");

                  //wishListIds
                  wishlistProductIdList.add(productId);
                });
              } else {
                print("9999999999999999999999 ${_products.length}.");
                return;
              }
            }
          });
          print("00000000000000000000000000000 ${_products.length}.");
          _products = [];
          print(
              "ggggggggggggggggggggggggggggggggggggggggggggggggggg${_products.length}.");

          _products = onlyForUser
              ? fetchedProductList.where((Product product) {
                  bool value = false;

                  wishlistProductIdList.forEach((productId) {
                    if (product.userId == productId) {
                      value = true;
                    }
                  });
                  return value;
                }).toList()
              : fetchedProductProfileList;
          print('${_products[0].userEmail}');
          print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ${_products.length}.");

          _isLoading = false; //after getting data..
          notifyListeners();
          _selProductId = null;
          return;
        }).catchError((error) {
          print("BBBBBBBBBBBBBBBBBBBBBBBBBBBB ${_products.length}.");
          _isLoading = false; //data is sent
          notifyListeners();
          //return false;***********************************************
          return;
        });
      });
    });
  }

  Future<Map<String, dynamic>> downloadFile(String gendercat) async {
    print("beginsssssssssssssssssssssssssssssssssssssssss");
    return http
        .get(
            'https://flutter-products-c24f0.firebaseio.com/$gendercat.json?auth=${_authenticatedUser.token}')
        .then<Map<String, dynamic>>((http.Response response) {
      final Map<String, dynamic> productListData = json.decode(response.body);
      //map of one category...ternary function
      if (productListData == null) {
        return productListData;
      }
      //return productListData;
      else {
        return productListData;
      }
    }).catchError(
      (onError) {},
    );
  }

  void toggleProductFavoriteStatus([String myProductId1]) async {
    final bool isCurrentlyFavorite =
        selectedProduct.isFavorite; //default status
    final bool newFavoriteStatus =
        !isCurrentlyFavorite; //new status is against previous status
    final Product updatedProduct = Product(
        //accessing the product...
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        imagePath: selectedProduct.imagePath, //////////////////////
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavorite: newFavoriteStatus);
    //replace product in list with this new product
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners(); //to be sure of the change

    http.Response response;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String genderCat = prefs.getString('gender');
    String genderSel;
    if (genderCat != null) {
      /*********
       * if data  is cleared we wii have to handle nit***********/
    }
    genderCat == 'male' ? genderSel = 'female' : genderSel = 'male';
    if (newFavoriteStatus) {
      response = await http.put(
          'https://flutter-products-c24f0.firebaseio.com/$genderSel/${selectedProduct.id}/wishlistUsers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}',
          body: json.encode(true)); //6666
    } else {
      response = await http.delete(
          'https://flutter-products-c24f0.firebaseio.com/$genderCat/$myProductId/wishlistUsers/$myProductId1.json?auth=${_authenticatedUser.token}');
    } //7777
    if (response.statusCode != 200 && response.statusCode != 201) {
      final Product updatedProduct = Product(
          //accessing the product...
          id: selectedProduct.id,
          title: selectedProduct.title,
          description: selectedProduct.description,
          price: selectedProduct.price,
          image: selectedProduct.image,
          imagePath: selectedProduct.imagePath,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId,
          isFavorite: !newFavoriteStatus);
      //replace product in list with this new product
      _products[selectedProductIndex] = updatedProduct;
      notifyListeners(); //to be sure of the change
    }
    _selProductId = null;
  }

  void selectProduct(String productId) {
    _selProductId = productId;
    if (productId != null) {
      notifyListeners();
    }
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject(); //11111
  PublishSubject<bool> _userSubjectAuthMode = PublishSubject();

  User get user {
    return _authenticatedUser;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  PublishSubject<bool> get userSubjectAuthMode {
    return _userSubjectAuthMode;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode authMode = AuthMode.Login ]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };
    http.Response response;
    if (authMode == AuthMode.Login) {
      _userSubjectAuthMode.add(false); //*************************
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDRaJrqoXB96KL8DU6Kw53im_NMRpzfFo4',
        body: json.encode(authData), //8888
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      _userSubjectAuthMode.add(true); //*************************
      response = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDRaJrqoXB96KL8DU6Kw53im_NMRpzfFo4',
        body: json.encode(authData), //999
        headers: {'Content-Type': 'application/json'},
      );
    }
    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong!';

    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication Succeeded!';
      //creating a new user for every token...
      _authenticatedUser = User(
          //a user with token,email,Id who can access the authentication
          id: responseData['localId'],
          email: email,
          token: responseData['idToken']);
      setAuthTimeout(int.parse(responseData['expiresIn']));
      print("USER SUBJECT IS BEING ADDADKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
      _userSubject.add(true);
      final DateTime now = DateTime.now(); //present
      final DateTime expiryTime = now.add(
          Duration(seconds: int.parse(responseData['expiresIn']))); //future
      //storing the token in the devicce...
      final SharedPreferences prefs =
          await SharedPreferences.getInstance(); //access to storage
      //storing token//email//id  to memory//they authenticateUser...
      prefs.setString('token', responseData['idToken']);
      prefs.setString('userEmail', email);
      prefs.setString('password', password);
      prefs.setString('userId', responseData['localId']);
      prefs.setString(
        'expiryTime',
        expiryTime.toIso8601String(),
      );
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found.';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email is taken.';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'The Password is invalid.';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }
//AIzaSyCfI6Js3WFvYJTdKeSt6V6oe9L4XC6Hsf0

  void autoAuthenticate() async {
    //access to the preferences(storage)
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //getting the token
     final String token = prefs.getString('token');
     final String userEmail = prefs.getString('userEmail');
     final String password = prefs.getString('password');
   
    await authenticate(userEmail, password);
    final String expiryTimeString = prefs.getString('expiryTime');
  
    if (token != null) {
      //token is present
      final DateTime now = DateTime.now(); //ssasahivi
      final parsedExpiryTime =
          DateTime.parse(expiryTimeString); //int dat ka format

      if (parsedExpiryTime.isBefore(now)) {
       
        //await authenticate(userEmail, password);
        _authenticatedUser = null;
        notifyListeners();
        return;
      }

     final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final int tokenLifeSpan = parsedExpiryTime.difference(now).inSeconds;
      //pass details to user
      _authenticatedUser = User(id: userId, email: userEmail, token: token);
      setAuthTimeout(tokenLifeSpan);
      notifyListeners();
    }
  }

  void logout() async {
    _authenticatedUser = null; //no auth user
    _authTimer.cancel(); //logout clear time
    _userSubject.add(false); //not authenticated
    _selProductId = null; ////////////////////////////////1
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.remove('token');
     prefs.remove('userEmail');
     prefs.remove('userId');
     prefs.remove('password');
  }

  void setAuthTimeout(int time) {
    print(",,,,,,,,,<<<<<<<$time");
    _authTimer = Timer(Duration(seconds: time), logout);
  }
  

}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
