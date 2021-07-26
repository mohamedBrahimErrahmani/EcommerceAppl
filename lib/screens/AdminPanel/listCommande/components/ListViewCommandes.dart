import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/DB/DBCart.dart';
import 'package:shop_app/DB/DBUser.dart';
import 'package:shop_app/components/Loading.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/ListProducts/components/ExpansionTile.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/size_config.dart';

class ListViewCommande extends StatefulWidget {

  @override
  _ListViewCommandeState createState() => _ListViewCommandeState();
}

class _ListViewCommandeState extends State<ListViewCommande> {
  List<Cart> listeCommandes=[];
  Map<String,int> idUserNbrCommandes={};
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: FutureBuilder<Map<String,int>>(
          future:DBCart.userNbrCommandes(),
          builder: (BuildContext context, AsyncSnapshot<Map<String,int>> snapshot) {
            if (!snapshot.hasData) {
              return  Loading();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Loading();
            }
            //remplirLists(snapshot);
            return listCommandes(snapshot);
          }
        ),
      ),
    );
  }
  Widget listCommandes(AsyncSnapshot<Map<String,int>> snapshot){
    return  Column(
      children: [
        Container(
          height: SizeConfig.screenHeight/1.3,
          child : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child:ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                String key = snapshot.data.keys.elementAt(index);
                return new Column(
                  children: <Widget>[
                    FutureBuilder<UserModel>(
                      future:DBUser.getUserById(key),
                      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot2) {
                        if (!snapshot2.hasData) {
                          return  Container();
                        }
                        if (snapshot2.connectionState == ConnectionState.waiting) {
                          return  Container();
                        }
                        return InkWell(
                          onTap: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context)=> CartScreen(key,"User Cart")
                              )
                            );
                          },
                          child : ListTile(
                            title: Text(
                              snapshot2.data.nom,
                              style : TextStyle(
                                fontWeight: FontWeight.w500
                              )
                            ),
                            subtitle:  Text("${snapshot.data[key]} commandes"),
                            trailing: FutureBuilder<double>(
                              future:DBCart.sommeCommandeByUser(key),
                              builder: (BuildContext context, AsyncSnapshot<double> snapshot3) {
                                if (!snapshot3.hasData) {
                                  return Text(
                                    "--",
                                    style : TextStyle(
                                      color : kPrimaryColor,
                                      fontWeight: FontWeight.w500
                                    )
                                  );
                                }
                                if (snapshot3.connectionState == ConnectionState.waiting) {
                                  return Text(
                                    "--",
                                    style : TextStyle(
                                      color : kPrimaryColor,
                                      fontWeight: FontWeight.w500
                                    )
                                  );
                                }
                                //remplirLists(snapshot);
                                return Text(
                                  "${snapshot3.data.toString()} DA",
                                  style : TextStyle(
                                    color : kPrimaryColor,
                                    fontWeight: FontWeight.w500
                                  )
                                );
                              }
                            ), 
                          )
                        );
                      }
                    ),
                    new Divider(
                      height: 2.0,
                    ),
                  ],
                );
              },
            )
          ),
        ),
      ],
    );
  }
}