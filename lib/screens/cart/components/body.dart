import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/DB/DBCart.dart';
import 'package:shop_app/DB/DBProduct.dart';
import 'package:shop_app/components/Loading.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  List<Cart> demoCarts;
  String typeUser;
  Body(this.demoCarts,this.typeUser);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
      child: ListView.builder(
        itemCount: widget.demoCarts.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(widget.demoCarts[index].productId),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(()  {
                if(widget.typeUser == "CurrentUser"){
                  DBCart.removeCart(widget.demoCarts[index].id);
                }
                widget.demoCarts.removeAt(index);
              });
            },
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("assets/icons/Trash.svg"),
                ],
              ),
            ),
            child: FutureBuilder<Product>(
              future:DBProduct.getProductById(widget.demoCarts[index].productId),
              builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                return CartCard(cart: widget.demoCarts[index],product : snapshot.data);
              }
            ),
            
          ),
        ),
      ),
    );
  }
}