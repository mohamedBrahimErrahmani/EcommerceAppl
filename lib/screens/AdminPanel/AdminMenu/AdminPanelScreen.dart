import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/AdminPanel/AdminMenu/components/Body.dart';

class AdminPannelScreen extends StatelessWidget{

  static String routeName = "/AdminPannel";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin pannel"),
      ),
      body: Body(),
    );
  }
}