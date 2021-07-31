import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/AdminPanel/AddProduct/components/AddProductForm.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatelessWidget {
  Product product;
  Body(this.product);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                AddProductForm(this.product)
              ],
            ),
          ),
        ),
      ),
    );
  }
}