import 'package:flutter/material.dart';
import 'package:shop_app/screens/historique_achat/components/body.dart';

class HistoriqueAchatScreen extends StatelessWidget {
  static String routeName = "/ListProductExpansionTile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text("Historique d'achats"),
      ),
      body: Body(),
      //bottomNavigationBar: ExpansionTileDemo.buttonAdd
          
    );
  }
}