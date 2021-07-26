import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/User.dart';

import 'Product.dart';
import 'Product.dart';

class Cart {
  String productId;
  int numOfItem;
  String idUser;
  String id;
  String date ;
  String etatCommande ;


  Cart({@required this.id,@required this.productId,@required this.etatCommande,@required this.date, @required this.numOfItem,@required this.idUser,});
  
  Cart.fromMap(Map<String,dynamic> cart){
    productId=cart["productId"];
    numOfItem=cart["numOfItem"];
    etatCommande=cart["etatCommande"];
    idUser=cart["idUser"];
    id=cart["id"];
    date = cart["date"];
    //cart["date"];
  }
  Map<String,dynamic> toMap(){
    return{
      'id':this.id,
      'numOfItem':this.numOfItem,
      'idUser':this.idUser,
      'date': this.date,
      'etatCommande':this.etatCommande,
      'productId':this.productId,
    };
  }
}


// Demo data for our cart

/*List<Cart> demoCarts = [
  /*Cart(product: demoProducts[0], numOfItem: 2),
  Cart(product: demoProducts[1], numOfItem: 1),
  Cart(product: demoProducts[3], numOfItem: 1),*/
];*/
