import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/DB/DBCart.dart';
import 'package:shop_app/components/Loading.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/size_config.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  String idUser,title;
  CartScreen(this.idUser,this.title);
  static String routeName = "/cart";
  List<Cart> demoCarts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
      child: FutureBuilder<List<Cart>>(
        future:DBCart.selectCommandesByUser(idUser),
        builder: (BuildContext context, AsyncSnapshot<List<Cart>> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(body :  Loading());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body :  Loading());
          }
          this.demoCarts = snapshot.data;
          return Scaffold(
            appBar: buildAppBar(context,this.title),
            body : Body(snapshot.data,title=="Your Cart"?"CurrentUser":"AutreUser"),
            
            bottomNavigationBar: CheckoutCard(carts : snapshot.data,typeUser : title=="Your Cart"?"CurrentUser":"AutreUser",idUser : idUser),
          );
        }
      ),
    );
    
  }

  AppBar buildAppBar(BuildContext context,String title) {
    return AppBar(
      title: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${demoCarts.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
