import 'package:flutter/material.dart';
import 'package:shop_app/DB/DBProduct.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/AdminPanel/ListesProduits/components/ProductCard.dart';

class ListeViewProduits extends StatefulWidget {
  List<Product> products;
  ListeViewProduits(this.products);
  @override
  _ListeViewProduitsState createState() => _ListeViewProduitsState();
}

class _ListeViewProduitsState extends State<ListeViewProduits> {
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
      itemBuilder: (context, i) {
        return ProductCard(widget.products[i]);
      }
    );
  }
}