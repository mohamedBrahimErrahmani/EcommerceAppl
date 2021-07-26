import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/screens/AdminPanel/AddProduct/AddProductScreen.dart';
import 'package:shop_app/screens/AdminPanel/AdminMenu/components/MenuGridCard.dart';
import 'package:shop_app/screens/AdminPanel/ListesProduits/ListesProduitsScreen.dart';
import 'package:shop_app/screens/AdminPanel/listCommande/ListCommandeScreen.dart';
import 'package:shop_app/screens/ListProducts/ListProductScreen.dart';
import 'package:shop_app/screens/ListProducts/components/ExpansionTile.dart';
import 'package:shop_app/size_config.dart';

class MenuGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      childAspectRatio: (SizeConfig.screenWidth *2 / SizeConfig.screenHeight),
      // Generate 100 widgets that display their index in the List.
      children: [
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, AddProductScreen.routeName);
            
          },
          child: MenuGridCard("Ajouter produit",FontAwesomeIcons.plus),

        ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, ListeProduitsScreen.routeName);
            
          },
          child: MenuGridCard("Listes produit",FontAwesomeIcons.list),

        ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, ListeCommandesScreen.routeName);
            
          },
          child: MenuGridCard("Liste des commandes",FontAwesomeIcons.listOl),

        ),
        InkWell(
          onTap: (){
            ExpansionTileProduct.productQteCmd={};
            Navigator.pushNamed(context, ListProductsScreen.routeName);
            
          },
          child: MenuGridCard("Expansion tile",FontAwesomeIcons.listOl),

        ),
        
        
      ]
    );
  }
}