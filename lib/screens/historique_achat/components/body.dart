import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/DB/DBCart.dart';
import 'package:shop_app/DB/DBProduct.dart';
import 'package:shop_app/components/Loading.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/AdminPanel/ListesProduits/components/ProductCard.dart';
import 'package:shop_app/screens/cart/components/cart_card.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String,List< Cart>>>(
      future:DBProduct.commandeParDate(),
      builder: (BuildContext context, AsyncSnapshot<Map<String,List< Cart>>> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          //itemCount: widget.demoCarts.length,
          itemCount : snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 10),
              child : ExpansionTile(
                title: Text(
                  snapshot.data.keys.elementAt(index).substring(0,10),
                  style: TextStyle(
                    fontSize: 16.0, 
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000e1c)
                  ),
                ),
                collapsedBackgroundColor:  Color(0xFFF5F6F9),
                collapsedTextColor: Colors.white,
                backgroundColor: Color(0xFFF5F6F9),
                children: <Widget>[
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    //itemCount: widget.demoCarts.length,
                    itemCount : snapshot.data[snapshot.data.keys.elementAt(index)].length,
                    itemBuilder: (BuildContext context, int index2) {
                      return FutureBuilder(//snapshot.data.keys.elementAt(index)
                        future:DBProduct.getProductById( snapshot.data[snapshot.data.keys.elementAt(index)][index2].productId),
                        builder: (BuildContext context, AsyncSnapshot<Product> snapshot2) {
                          if (!snapshot2.hasData) {
                            return Container();
                          }
                          if (snapshot2.connectionState == ConnectionState.waiting) {
                            return Loading();
                          }
                          return CartCard(cart: snapshot.data[snapshot.data.keys.elementAt(index)][index2],
                            product : snapshot2.data
                          );
                    
                        }
                      );
                    },
                  ),
                ],
              )
            );
          }
        );
      }
    );
    /*Padding(
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
                if(widget.typeUser == "CurrentUser"){
                  return ExpansionTile(
                    title: Text(
                      widget.demoCarts[index].date.toString(),
                      style: TextStyle(
                        fontSize: 16.0, 
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF000e1c)
                      ),
                    ),
                    collapsedBackgroundColor:  Color(0xFFF5F6F9),
                    collapsedTextColor: Colors.white,
                    backgroundColor: Color(0xFFF5F6F9),
                    children: <Widget>[
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        //itemCount: widget.demoCarts.length,
                        itemCount : dateParCommande(widget.demoCarts[index].date.toString()).length,
                        itemBuilder: (BuildContext context, int index) {
                          //return CartCard(cart: widget.demoCarts[index],product : snapshot.data);
                          return FutureBuilder<Product>(
                            future:DBProduct.getProductById(widget.demoCarts[index].productId),
                            builder: (BuildContext context, AsyncSnapshot<Product> snapshot2) {
                              if (!snapshot2.hasData) {
                                return Container();
                              }
                              if (snapshot2.connectionState == ConnectionState.waiting) {
                                return Container();
                              }
                              return CartCard(cart: dateParCommande(widget.demoCarts[index].date.toString())[index],product : snapshot2.data);
                            }
                            
                          );
                          
                        },
                      ),
                    ],
                  );
                }
                else{
                  return CartCard(cart: widget.demoCarts[index],product : snapshot.data);
                }
              }
            ),
          ),
        ),
      ),
    );*/
  }
  /*List<Cart> dateParCommande(String date)  {
    List<Cart> dateByCart = [];
    for(var element in widget.demoCarts){
      if(element.date.toString() == date){
        dateByCart.add(element);
      }
    }
    return dateByCart;
  }*/
}