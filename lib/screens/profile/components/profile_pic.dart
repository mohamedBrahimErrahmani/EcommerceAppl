import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/DB/DBUser.dart';
import 'package:shop_app/components/Loading.dart';
import 'dart:io';

import 'package:shop_app/screens/profile/components/body.dart';


class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black,
                    blurRadius: 3)
              ],
              shape: BoxShape.circle
            ),
            child: Body.user.photoProfil !=""? ClipOval(
              child: CachedNetworkImage(
                imageUrl: Body.user.photoProfil,
                fit: BoxFit.fill,
                placeholder: (context, url) => Loading(),
              ),
            ):Image.asset("assets/images/ProfileImage.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () {
                  addImage();
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<PickedFile> addImage() async {
    final picker = ImagePicker();
    File _imageFile;
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    _imageFile = File(pickedFile==null?FlutterLogo().toStringShallow():pickedFile.path);
    DBUser.uploadPhoto(_imageFile,);
    return pickedFile;
  }
}
