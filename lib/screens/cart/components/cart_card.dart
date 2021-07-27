import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  Product product;
  CartCard({
    Key key,
    @required this.product,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left : getProportionateScreenWidth(5),
        right: getProportionateScreenWidth(30), 
      ),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(4)),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:ClipRRect(borderRadius: BorderRadius.circular(15.0),
                      child : CachedNetworkImage(
                        imageUrl: this.product.images[0],
                        fit: BoxFit.fill,
                        placeholder: (context, url) => CircularProgressIndicator(),
                      ),
                    )
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.product.title,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    maxLines: 2,
                  ),
                  SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: "${this.product.price} DA ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                      children: [
                        TextSpan(
                          text: " x${cart.numOfItem}",
                          style: Theme.of(context).textTheme.bodyText1
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${cart.date.toString().substring(0,10)}",
                style: Theme.of(context).textTheme.bodyText1
              ),
              SizedBox(height: 10),
              Text(
                "${cart.etatCommande}",
                style: TextStyle(
                  color: cart.etatCommande == kEnAttente? Colors.red:Colors.green
                ),
              )
            ],
          ),
          
          
          
        ],
      )
    );
  }
}