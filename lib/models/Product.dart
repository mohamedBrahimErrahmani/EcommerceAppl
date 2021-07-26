import 'package:flutter/material.dart';

class Product {
  String id;
  String marque;
  String title, description;
  List<dynamic> images;
  List<Color> colors=[];
  double rating, price;
  bool isFavourite, isPopular;

  Product({
    @required this.id,
    @required this.marque,
    @required this.images,
    this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    @required this.title,
    @required this.price,
    @required this.description,
  });
  Product.fromMap(Map<String,dynamic> product){
    id = product['id'];
    marque = product['marque'];
    title = product['title'];
    description = product['description'];
    images = product['images'];
    colors = product['colors'];
    rating = product['rating'];
    price = product['price'];
    isFavourite = product['isFavourite'];
    isPopular = product['isPopular'];
  }
  Map<String,dynamic> toMap(){
    return{
      'id':this.id,
      'marque':this.marque,
      'title':this.title,
      'description':this.description,
      'images':this.images,
      'colors':this.colors,
      'rating':this.rating,
      'price':this.price,
      'isFavourite':this.isFavourite,
      'isPopular':this.isPopular,
      
    };
  }
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: "1",
    marque: "mh",
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: "2",
    marque: "mh",
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: "3",
    marque: "mh",
    images: [
      "assets/images/glap.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: "4",
    marque: "mh",
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
