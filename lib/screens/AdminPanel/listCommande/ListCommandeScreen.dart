import 'package:flutter/material.dart';
import 'package:shop_app/screens/AdminPanel/listCommande/components/body.dart';

class ListeCommandesScreen extends StatefulWidget {
  static String routeName = "/ListeCommande";
  @override
  _ListeCommandesScreenState createState() => _ListeCommandesScreenState();
}

class _ListeCommandesScreenState extends State<ListeCommandesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des commandes"),
      ),
      body: Body(),
    );
  }
}