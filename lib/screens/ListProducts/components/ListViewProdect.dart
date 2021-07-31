import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/DB/DBCart.dart';
import 'package:shop_app/DB/DBProduct.dart';
import 'package:shop_app/components/DialogApp.dart';
import 'package:shop_app/components/Loading.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/ListProducts/components/ExpansionTile.dart';
import 'package:shop_app/screens/details/components/top_rounded_container.dart';
import 'package:shop_app/size_config.dart';

class ExpansionTileDemo extends StatefulWidget {
  static Widget buttonAdd ;
  @override
  _ExpansionTileDemoState createState() => _ExpansionTileDemoState();
}
class _ExpansionTileDemoState extends State<ExpansionTileDemo> {
  Cart cart;
  List<Product> produitsList = [];
  List<String> marquesUniques = [];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Query  listProduits = FirebaseFirestore.instance.collection('product');
    return SafeArea(
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: StreamBuilder<QuerySnapshot>(
          stream: listProduits.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
            // Check for errors
            if (!snapshot.hasData) {
              return  Loading();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Loading();
            }
            remplirLists(snapshot);
            return Column(
              children: [
                listProduct(),
                addButton()
              ],
            );
          }
        ),
      ),
    );
  }
  Widget addButton(){
    ExpansionTileDemo.buttonAdd = DefaultButton(
      text: "Commander",
      press: () {
        bool ajout = false;
        ExpansionTileProduct.productQteCmd.forEach((key, value) async {
          if(value != 0){
            ajout = true;
            cart = new Cart(id: "",etatCommande: kEnAttente, productId: key, date: DateTime.now(), numOfItem: value, idUser: FirebaseAuth.instance.currentUser.uid);
            await DBCart.ajouterCommande(cart);
            //print("${key.toString()} ==> $value");
          }

        });                                 
        if(ajout == true){
          DialogApp.afficherDialog(context, "La commande a été ajouté");
        }
        else{
          DialogApp.afficherDialog(context, "Vous devez choisir des produits");
        }
        //DialogApp.afficherDialog2pop(context, "La commande a été ajouté");
        ajout = false;
      },
    );
    return ExpansionTileDemo.buttonAdd;
  }
  Widget listProduct(){
    return  Column(
      children: [
        Container(
          height: SizeConfig.screenHeight/1.4,
          child : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            child:ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: marquesUniques.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTileProduct(marquesUniques[index],produitsParMarque(produitsList,marquesUniques[index]));
              },
            )
          ),
        ),
      ],
    );
  }
  void remplirLists(AsyncSnapshot<QuerySnapshot> snapshot){
    produitsList=[];
    marquesUniques=[];
    snapshot.data.docs.forEach((element) {
      this.produitsList.add(Product.fromMap(element.data()));
    });
    snapshot.data.docs.forEach((element) {
      if(!marquesUniques.contains(element['marque'])){
        marquesUniques.add(element['marque']);
      }
    });
  }
  List<Product> produitsParMarque(List<Product> produitsL,String marque){
    List<Product> list = [];
    produitsL.forEach((element) {
      if(element.marque == marque){
        list.add(element);
      }
    });
    return list;
  }
}