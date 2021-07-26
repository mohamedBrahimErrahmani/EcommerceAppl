import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/size_config.dart';

class MenuGridCard extends StatelessWidget {
  String action;
  IconData icon;
  MenuGridCard(this.action,this.icon);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.screenWidth/100),
      child : Container(
        height: SizeConfig.screenHeight,
        color: kSecondaryColor.withOpacity(0.1),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
            Container(
              height: SizeConfig.screenHeight * 0.13,
              decoration: BoxDecoration(
                color: Color(0xFFDECB9C),
                shape: BoxShape.circle
              ),
              child: Center(
                child : FaIcon(
                  this.icon,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.04,
            ),
            Text(
              action,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )
            )
          ],
        ),
      )
    );
  }
}