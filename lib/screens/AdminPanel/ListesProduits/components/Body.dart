import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/DB/DBProduct.dart';
import 'package:shop_app/components/Loading.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/AdminPanel/ListesProduits/components/ListeViewProduits.dart';
import 'package:shop_app/size_config.dart';
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String dropdownValue;
  Query produits;
  List<String> marques=[];
  Query marqueQuery;
  List<Product> produitsList = [];
  @override
  Widget build(BuildContext context) {
    if(this.dropdownValue == null)
      produits = FirebaseFirestore.instance.collection('product');
    else
      produits = FirebaseFirestore.instance.collection('product').where("marque" , isEqualTo:dropdownValue );
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: StreamBuilder<QuerySnapshot>(
            stream: produits.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)  {
              // Check for errors
              if (!snapshot.hasData) {
                return Scaffold(
                  body: Loading()
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Loading(),
                );
              }
              // Once complete, show your application
              produitsList=[];
              snapshot.data.docs.forEach((element) {
                this.produitsList.add(Product.fromMap(element.data()));
              });
              if(this.dropdownValue == null){
                marques = [];
                snapshot.data.docs.forEach((element) {
                  if(!marques.contains(element['marque'])){
                    marques.add(element['marque']);
                  }
                });
              }
              return SingleChildScrollView(
                child : Column(
                  children: [
                    DropdownButton<String>(
                      value: dropdownValue,
                      hint: Text("Marque"),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: marques
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Container(
                      height: SizeConfig.screenHeight/1.3,
                      child : ListeViewProduits(this.produitsList)

                    )
                  ],
                )
              );
            }
          ),
        ),
      ),
    );
  }
}