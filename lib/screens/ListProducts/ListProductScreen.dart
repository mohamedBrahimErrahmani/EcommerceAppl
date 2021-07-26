import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/ListProducts/components/Body.dart';
import 'package:shop_app/screens/ListProducts/components/ListViewProdect.dart';

class ListProductsScreen extends StatelessWidget {
  static String routeName = "/ListProductExpansionTile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("List product"),
      ),
      body: Body(),
      bottomNavigationBar: ExpansionTileDemo.buttonAdd
          
    );
  }
}