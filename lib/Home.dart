import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shop_app/screens/AdminPanel/AdminMenu/AdminPanelScreen.dart';
import 'package:shop_app/screens/ListProducts/ListProductScreen.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab=0;
  List<Widget> _children;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tabs(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          rippleColor: kPrimaryColor,
          hoverColor: kSecondaryColor,
          gap: 0,
          activeColor: Colors.white,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: kPrimaryColor,
          // barBackgroundColor: _currentTab==3?ColorsConstants.primaryColor:ColorsConstants.SecondaryColor,
          tabs: [
            GButton(icon: FontAwesomeIcons.cartPlus,text: "  Commander",),
            GButton(icon: FontAwesomeIcons.shoppingCart ,text: "  Mes cmd",),
            GButton(icon: FontAwesomeIcons.userLock,text: "  Admin",),
            GButton(icon: FontAwesomeIcons.user,text: "  profil",),
          ],
          onTabChange: (index) {
            setState(() {
              _currentTab=index;
            });
          },
          selectedIndex: _currentTab,
        ),
      ),
    );
  }
  SafeArea Tabs() {
    _children = [
      ListProductsScreen(),
      CartScreen(FirebaseAuth.instance.currentUser.uid,"Your Cart"),
      AdminPannelScreen(),
      ProfileScreen(),
    ];
    return SafeArea(
      child: _children[_currentTab],
    );
  }
}