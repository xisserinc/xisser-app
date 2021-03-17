import 'package:fashionify/models/Components/text_display.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/helpers/ensure_visible.dart';
import '../widgets/helpers/image.dart';
import '../models/product.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': null,
    'gender': null
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _titleTextController = TextEditingController();
  final _descriptionTextController = TextEditingController();
  String gender; // = "female";

  Widget _genderSelect(Product product) {
    return Column(
      children: [
        Center(
          child: Text(
            "Select Gender",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: Radio(
            value: "male",
            groupValue: gender,
            onChanged: (String value) {
              setState(() {
                this.gender = value;
                _formData['gender'] = value;
              });
            },
          ),
          title: Text("Male"),
        ),
        ListTile(
          leading: Radio(
            value: "female",
            groupValue: gender,
            onChanged: (String value) {
              setState(() {
                this.gender = value;
                _formData['gender'] = value;
              });
            },
          ),
          title: Text("Female"),
        )
      ],
    );
  }

  Widget _buildTitleTextField(Product product) {
    //title
    if (product == null && _titleTextController.text.trim() == '') {
      _titleTextController.text = '';
    } else if (product != null && _titleTextController.text.trim() == '') {
      _titleTextController.text = product.title;
    } else if (product != null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else if (product == null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else {
      _titleTextController.text = '';
    }
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(labelText: 'Full Name'),
        controller: _titleTextController,
        // initialValue: product == null ? '' : product.title,
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty /*|| value.length < 5*/) {
            return 'name should not be empty';
          }
          return null;
        },
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    if (product == null && _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = '';
    } else if (product != null &&
        _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = product.description;
    }
    if (product == null && _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = '';
    } else if (product != null &&
        _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = product.description;
    }
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        maxLines: 4,
        decoration: InputDecoration(labelText: 'Bio'), //description
        // initialValue: product == null ? '' : product.description,
        controller: _descriptionTextController,
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty /*|| value.length < 5*/) {
            return 'may you describe youself';
          }
          return null;
        },
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: 'Age'),
        initialValue: product == null ? '' : product.price.toString(),
        validator: (String value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return 'please, fill your age';
          }
          return null;
        },
        onSaved: (String value) {
          _formData['price'] = double.parse(value); //age
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton(
                child: Text('Start Dating Now'),
                textColor: Colors.white,
                onPressed: () => _submitForm(
                    model.addProduct,
                    model.updateProduct,
                    model.selectProduct,
                    model.selectedProductIndex),
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext contextbuild, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              children: <Widget>[
                SizedBox(height: 50.0),
                TextClass('Pictures'),
                SizedBox(height: 10.0),
                ImageInput(_setImage, product),
                SizedBox(
                  height: 10.0,
                ),
                TextClass('About You'),
                _buildTitleTextField(product),
                _buildDescriptionTextField(product),
                _buildPriceTextField(product),
                _genderSelect(product),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 75,
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    LikeSelection('Gaming'),
                    LikeSelection('Movies'),
                    LikeSelection('Football'),
                    LikeSelection('Swimming'),
                    LikeSelection('Chatting'),
                    LikeSelection('Drinking')
                  ]),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: _buildSubmitButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setImage(File image) {
    _formData['image'] = image;
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    print("FFFFFFFFFFFFFFFFFFOOORMMMM ${_formData['gender']}");
    if (!_formKey.currentState.validate() ||
        (_formData['image'] == null && selectedProductIndex == -1) ||
        _formData['gender'] == null) {
      print("something not selected");
      return;
    }
    _formKey.currentState.save();
    if (selectedProductIndex == -1) {
      addProduct(
              _titleTextController.text,
              _descriptionTextController.text,
              _formData['image'],
              _formData['price'],
              _formData['gender']) //location
          .then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/products')
              .then((_) => setSelectedProduct(null));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Okay'),
                    )
                  ],
                );
              });
        }
      });
    } else {
      updateProduct(
        _titleTextController.text,
        _descriptionTextController.text,
        _formData['image'],
        _formData['price'],
        /*_formData['location'],*/
      ).then((_) => Navigator.pushReplacementNamed(context, '/products')
          .then((_) => setSelectedProduct(null)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Profile'),
                ),
                body: pageContent,
              );
      },
    );
  }
}

class LikeSelection extends StatefulWidget {
  final String liketext;

  LikeSelection(this.liketext);

  @override
  LikeSelectionState createState() => LikeSelectionState(liketext);
}

class LikeSelectionState extends State<LikeSelection> {
  var likeText;

  LikeSelectionState(this.likeText);

  bool pressAttention = false;
  bool pressAttention1 = false;
  bool pressAttention2 = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20, right: 10, top: 20),
      child: RaisedButton(
        color: pressAttention2 ? Colors.green : Colors.grey,
        shape: StadiumBorder(),
        onPressed: () => setState(() => pressAttention2 = !pressAttention2),
        child: Text(likeText),
      ),
    );
  }
}
