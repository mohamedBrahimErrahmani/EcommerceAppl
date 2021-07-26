import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class Loading extends StatefulWidget {

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(
          kPrimaryColor
        ),
      ),
    );
  }
}