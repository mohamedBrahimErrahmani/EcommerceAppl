import 'package:flutter/material.dart';
import 'package:shop_app/screens/ListProducts/components/ListViewProdect.dart';
import 'package:shop_app/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ExpansionTileDemo();
    /*Column(
      children: [
        ExpansionTileDemo()
      ],
    );*/
  }
}
