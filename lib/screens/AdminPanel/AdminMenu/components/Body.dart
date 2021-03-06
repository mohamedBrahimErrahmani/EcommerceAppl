import 'package:flutter/material.dart';
import 'package:shop_app/screens/AdminPanel/AdminMenu/components/MenuGrid.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatelessWidget {
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
                Container(
                  height: SizeConfig.screenHeight * 0.9,
                  child: MenuGrid(),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}