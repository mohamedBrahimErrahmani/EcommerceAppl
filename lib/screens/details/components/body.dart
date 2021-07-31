import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/AdminPanel/AddProduct/AddProductScreen.dart';
import 'package:shop_app/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;
  final String clientAdmin;
  const Body({Key key, @required this.product,@required this.clientAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                clientAdmin : clientAdmin,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    //ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                        ),
                        child: clientAdmin == "admin"?  DefaultButton(
                          text: "Modifier",
                          press: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context)=>AddProductScreen(this.product)
                              )
                            );
                          },
                        ):Center(
                          child : Text(
                            "Prix : " + this.product.price.toString() + " DA",
                            style: TextStyle(
                              color : kPrimaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
