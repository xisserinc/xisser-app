import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String image;
  final String imagePath;
  final String description;
  final double price;
  final bool isFavorite;
  final String userEmail;
  final String userId;
  final String gender;

  Product(
      {@required this.id,
      @required this.title,
      @required this.image,
      @required this.description,
      @required this.price,
      @required this.userEmail,
      @required this.userId,
      @required this.gender,
      @required this.imagePath,
      this.isFavorite = false //assume false if not selected
      });
}
