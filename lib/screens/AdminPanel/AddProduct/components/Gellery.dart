import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

class Gallery extends StatefulWidget {
  List photos;
  Gallery(this.photos);
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.photos.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.only(left : 5),
          child : Container(
            height: SizeConfig.screenWidth/3,
            width: SizeConfig.screenWidth/3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:kPrimaryColor
              //image: DecorationImage(image: AssetImage(widget.photos[i]))
            ),
            child:  AssetThumb(
              asset: widget.photos[i],
              width: 300,
              height: 300,
            )
            
          )
        );
      },
    );
  }
}