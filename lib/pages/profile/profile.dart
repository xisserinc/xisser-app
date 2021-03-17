import 'package:fashionify/pages/product_edit.dart';
import 'package:fashionify/scoped-models/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Profile extends StatefulWidget {
  final MainModel model;
  //final Product product;

  Profile(
    this.model,
    /*this.product*/
  );

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  _ProfileState();
  @override
  initState() {
    widget.model.fetchProducts(onlyForUser: true);
    //widget.model.fetchRequestProducts(onlyForUser: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (
      BuildContext context,
      Widget child,
      MainModel model,
    ) {
      Widget content = Center(
        child: CircularProgressIndicator(
          strokeWidth: 5,
        ),
      );
      if (model.allProducts.length > 0 && !model.isLoading) {
        //we have  products&not loading..
        content = Container(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  'Pictures',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: 160,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ProfilePictures(model.allProducts[0].image),
                    ProfilePictures(model.allProducts[0].image),
                    ProfilePictures(model.allProducts[0].image),
                    ProfilePictures(model.allProducts[0].image),
                    ProfilePictures(model.allProducts[0].image),
                    ProfilePictures(model.allProducts[0].image)
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, bottom: 30),
                child: Text(
                  'About You',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(
                        'Name: ${model.allProducts[0].title}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      alignment: Alignment.centerLeft,
                      //margin: EdgeInsets.only(left: 0),
                      child: Text(
                        'Gender:  ${model.allProducts[0].gender}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Age: ${model.allProducts[0].price}',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.only(top: 20, bottom: 10),
                      alignment: Alignment.centerLeft,
                      //color: Colors.black12,
                      child: Text(
                        '${model.allProducts[0].description}',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black38,
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 10, bottom: 30, top: 20),
              //   child: Text(
              //     'Likes',
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 25,
              //         color: Colors.black),
              //   ),
              // ),
              // Container(
              //   padding: EdgeInsets.only(top: 10, bottom: 10),
              //   margin: EdgeInsets.symmetric(horizontal: 15),
              //   height: 55,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       ProfileLikes('Movies'),
              //       ProfileLikes('Swimming'),
              //       ProfileLikes('ScubaDiving'),
              //       ProfileLikes('Beach Walks')
              //     ],
              //   ),
              // ),
              _buildEditButton(context, 1, widget.model),
            ],
          ),
        );
      } else if (model.isLoading) {
        content = Center(
          child: CircularProgressIndicator(),
        );
      }

      return RefreshIndicator(
        onRefresh: model.fetchRequestProducts,
        child: content,
      );
    });
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        child: Text(
          'Edit Profile',
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 17, color: Colors.white),
        ),
        onPressed: () {

          model.selectProduct(model.allProducts[0].id); //ni mungu tuuu
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductEditPage(); //5 challenge
              },
            ),
          );
        },
      ),
    );
  }
}

class ProfilePictures extends StatelessWidget {
  final String image;
  ProfilePictures(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0)),
        margin: EdgeInsets.only(left: 5, right: 5),
        width: 150,
        color: Colors.black12,
        child: FadeInImage(
          image: NetworkImage(image),
          placeholder: AssetImage('assets/xisser.jpg'),
          // height: MediaQuery.of(context).size.height * 0.7,
          // height: 450,
          fit: BoxFit.cover,
        ));
  }
}

class ProfileLikes extends StatelessWidget {
  final String like;

  ProfileLikes(this.like);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(left: 5, right: 5),
      height: 37,
      width: 99,
      child: Text(
        like,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34.0), color: Colors.indigo),
    );
  }
}
