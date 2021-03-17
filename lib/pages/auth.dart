

import 'package:fashionify/pages/profile/Terms&Conditions.dart';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../models/auth.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

  //instatiate enum
  AuthMode _authMode = AuthMode.Login;

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        //begins********************
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      }, //ends******************
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        //begins**********
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
        return null;
      },
      //end********************
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'confirm Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        //begins
        if (_passwordTextController.text != value) {
          return 'Passwords do not match!';
        }
        return null;
      }, //ends...
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  Widget _buildLoginRegisterText(String loginOrRegister) {
    return Text(
      '$loginOrRegister',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontStyle: FontStyle.normal),
      //textAlign: TextAlign.end,
    );
  }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState.validate() ||  _authMode == AuthMode.Signup ? !_formData['acceptTerms']: false) {
      //*******ends */
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await authenticate(
        _formData['email'], _formData['password'], _authMode);

    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/');//'/products'**********
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('An Error Occured!'),
              content: Text(successInformation['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: _buildBackgroundImage(),
        // ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _buildLoginRegisterText(
                        '${_authMode == AuthMode.Login ? 'Log In' : 'Sign Up'}', ),
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _authMode == AuthMode.Signup
                        ? _buildPasswordConfirmTextField()
                        : Container(),
                    _authMode == AuthMode.Login
                        ? Container()
                        : _buildAcceptSwitch(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      // margin: EdgeInsets.only(right: 160, left: 0),
                      child: FlatButton(
                        child: Text(
                          ' ${_authMode == AuthMode.Login ? 'Don\'t have an account? Register Here' : ''}',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                          textAlign: TextAlign.left,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              _authMode = _authMode == AuthMode.Login
                                  ? AuthMode.Signup
                                  : AuthMode.Login;
                              //added*******
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ScopedModelDescendant(
                      builder: (
                        BuildContext context,
                        Widget child,
                        MainModel model,
                      ) {
                        return model.isLoading
                            ? CircularProgressIndicator()
                            : RaisedButton(
                                textColor: Colors.white,
                                child: Text(_authMode == AuthMode.Login
                                    ? 'LogIn'
                                    : 'Sign UP'),
                                onPressed: () {
                                  _submitForm(model.authenticate);
                                },
                              );

                        },

                    ),
                    Container(
                    alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        child: Text(
                          ' ${_authMode == AuthMode.Signup ? 'Terms & Conditions' : ''}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17, color: Colors.blue),
                          textAlign: TextAlign.left,),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> TermsClass()));
                        },
                      ),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}