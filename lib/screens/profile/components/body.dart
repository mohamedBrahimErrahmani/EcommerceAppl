import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';

import 'package:shop_app/DB/DBUser.dart';
import 'package:shop_app/components/Loading.dart';
import 'package:shop_app/models/User.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  static UserModel user;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
        child:  FutureBuilder<UserModel>(
        future:DBUser.getUserById(FirebaseAuth.instance.currentUser.uid),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (!snapshot.hasData) {
            return Center(child : Loading());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child : Loading());
          }
          user = snapshot.data;
          return Column(
            children: [
              ProfilePic(),
              SizedBox(height: 20),
              ProfileMenu(
                text: "Historiques achats",
                icon: "assets/icons/User Icon.svg",
                press: () => {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context)=> CartScreen(FirebaseAuth.instance.currentUser.uid,"Your Cart","tout"),
      
                    )
                  )
                },
              ),
              ProfileMenu(
                text: "Notifications",
                icon: "assets/icons/Bell.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Settings",
                icon: "assets/icons/Settings.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Help Center",
                icon: "assets/icons/Question mark.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/icons/Log out.svg",
                press: () {
                  FirebaseAuth.instance.signOut();
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, SplashScreen.routeName);
                },
              ),
            ],
          );
        }
      ),
      
    );
  }
}
