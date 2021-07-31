import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/DB/DBProduct.dart';
import 'package:shop_app/components/Loading.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/size_config.dart';

class ProductCard extends StatefulWidget {
  Product product;
  String clientAdmin;
  ProductCard(this.product,this.clientAdmin);
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: ProductDetailsArguments(product: widget.product,clientAdmin : widget.clientAdmin),
        );
      },
      child : Padding(
        padding: EdgeInsets.only(bottom: 10,left: 10,right: 10),
        child : Container(
          padding: EdgeInsets.all(10),
          height: SizeConfig.screenHeight/9,
          width: SizeConfig.screenWidth/1.6,
          decoration: BoxDecoration(
            border: Border.all(
              color: kPrimaryColor,
              width: 2
            ),
            borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            children: [
              Container(
                height : SizeConfig.screenHeight/13,
                width: SizeConfig.screenHeight/13,
                child : ClipRRect(borderRadius: BorderRadius.circular(15.0),
                  child : CachedNetworkImage(
                    imageUrl: widget.product.images[0],
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Loading(),
                  ),
                )
              ),
              SizedBox(width: getProportionateScreenHeight(10)),
              Flexible(
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.title ,
                            style: TextStyle(
                              color : Colors.black,
                              fontSize: 15
                            ),
                          )
                        ),
                        widget.product.promotion?
                        Expanded(
                          child:FaIcon(
                            FontAwesomeIcons.ad,
                            color: kPrimaryColor,
                          )
                        ):Container(),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(3)),
                    Expanded(
                      child: Text(
                        widget.product.description,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          fontSize: 8
                        ),
                      ),
                    )
                    
                  ],
                )
              ) 
            ],
          ),
        )
      )
    );
  }
}