import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

class AddPhotoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.screenWidth/100),
      child : 
        Container(
          height: SizeConfig.screenHeight * 0.13,
          width: SizeConfig.screenWidth ,
          decoration: BoxDecoration(
            color: Color(0xFFDECB9C),
            borderRadius: BorderRadius.circular(15)
          ),
          child: Center(
            child : Text(
              "Add photos",
              
            ),
          ),
        ),
    );
  }
}