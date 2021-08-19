import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/AdminPanel/AddProduct/components/Body.dart';

class AddProductScreen extends StatefulWidget {
  Product product;
  AddProductScreen(this.product);
  static String routeName = "/AddProduct";
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un produit"),
      ),
      body: Body(widget.product),
    );
  }
}