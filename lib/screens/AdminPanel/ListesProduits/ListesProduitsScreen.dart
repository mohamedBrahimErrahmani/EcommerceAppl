import 'package:flutter/material.dart';
import 'package:shop_app/screens/AdminPanel/ListesProduits/components/Body.dart';

class ListeProduitsScreen extends StatefulWidget {
  String routName;
  static String routeName = "/ListeProduct";
  @override
  _ListeProduitsScreenState createState() => _ListeProduitsScreenState();
}

class _ListeProduitsScreenState extends State<ListeProduitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des produits"),
      ),
      body: Body(),
    );
  }
}