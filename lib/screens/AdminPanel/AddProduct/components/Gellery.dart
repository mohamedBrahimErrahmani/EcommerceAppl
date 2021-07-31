import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/AdminPanel/AddProduct/components/AddProductForm.dart';
import 'package:shop_app/size_config.dart';

class Gallery extends StatefulWidget {
  List<dynamic> liensPhotos;
  Gallery({this.liensPhotos});
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
                
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: AddProductForm.images.length, //widget.liensPhotos==null? AddProductForm.images.length:widget.liensPhotos.length,//widget.photos.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: EdgeInsets.only(left : 5),
          child : Stack(
            alignment : AlignmentDirectional.topEnd,
            children: [
              Container(
                height: SizeConfig.screenWidth/3,
                width: SizeConfig.screenWidth/3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color:kPrimaryColor,
                  //image: DecorationImage(image: AssetImage(widget.photos[i]))
                ),
                child: AddProductForm.images[i].runtimeType == Asset?// widget.liensPhotos==null?
                AssetThumb(
                  asset:AddProductForm.images[i],// widget.photos[i],
                  width: 300,
                  height: 300,
                ):CachedNetworkImage(
                  imageUrl: AddProductForm.images[i],//widget.liensPhotos[i],
                  fit: BoxFit.fill,
                  placeholder: (context, url) => CircularProgressIndicator(),
                ),
                
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child : IconButton(
                  onPressed: (){
                    setState(() {
                      //widget.photos.removeAt(i);
                      AddProductForm.images.removeAt(i);
                      //print("length 1 = ${widget.photos.length}");
                      print("length 2 = ${AddProductForm.images.length}");
                      
                    });
                  }, 
                  icon: FaIcon(
                    FontAwesomeIcons.timesCircle,
                    color: Colors.red,
                    size: 40,
                  )
                )
              )
            ],
          )
        );
      },
    );
  }
}