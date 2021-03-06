import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.id.toString(),
              child:CachedNetworkImage(
                imageUrl: widget.product.images[selectedImage],
                fit: BoxFit.fill,
                placeholder: (context, url) => CircularProgressIndicator(),
              ),
              //Image.file(widget.product.images[selectedImage]),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Center(
          child : Container(
            width: SizeConfig.screenWidth/1.2,
            height: getProportionateScreenWidth(48),
            child :Center(
              child :  ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.product.images.length,
                itemBuilder: (context, i) {
                  return Center(child : buildSmallProductPreview(i));
                }
              )
            )
          )
        ),
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child:CachedNetworkImage(
          imageUrl: widget.product.images[index],
          fit: BoxFit.fill,
          placeholder: (context, url) => CircularProgressIndicator(),
        ),
        // Image.file(widget.product.images[index]),
      ),
    );
  }
}
