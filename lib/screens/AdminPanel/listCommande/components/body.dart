import 'package:flutter/material.dart';
import 'package:shop_app/screens/AdminPanel/listCommande/ListCommandeScreen.dart';
import 'package:shop_app/screens/AdminPanel/listCommande/components/ListViewCommandes.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children :[
        ListViewCommande()
      ]
    );
  }
}