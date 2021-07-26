import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/DB/DBCart.dart';
import 'package:shop_app/components/DialogApp.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
class CheckoutCard extends StatefulWidget {
  List<Cart> carts;
  String typeUser;
  String idUser;
  CheckoutCard({
    @required this.carts,
    @required this.typeUser,
    @required this.idUser,
    Key key,

  }) : super(key: key);
  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Total:",
                  style : TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                  )
                ),
                FutureBuilder<double>(
                  future:DBCart.sommeCommandeByUser(widget.idUser),
                  builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                    if (!snapshot.hasData) {
                      return Text(
                        "--",
                        style : TextStyle(
                          color : kPrimaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w500
                        )
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        "--",
                        style : TextStyle(
                          color : kPrimaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w500
                        )
                      );
                    }
                    //remplirLists(snapshot);
                    return Text(
                      "${snapshot.data.toString()} DA",
                      style : TextStyle(
                        color : kPrimaryColor,
                          fontSize: 25,
                        fontWeight: FontWeight.w500
                      )
                    );
                  }
                ), 

              ],
            ),
            /*Text.rich(
              TextSpan(
                text: "Total:\n",
                children: [
                  
                  /*TextSpan(
                    text: "\$337.15",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),*/
                ],
              ),
            ),*/
            SizedBox(
              height: getProportionateScreenWidth(10),
            ),
            widget.typeUser == "AutreUser"?
            Center(
              child :  SizedBox(
                width: getProportionateScreenWidth(190),
                child: DefaultButton(
                  text: "Valider",
                  press: () {
                    setState(() {
                      DBCart.validerCommandes(widget.idUser,widget.carts);
                      DialogApp.afficherDialog2pop(context, "La commande a été validé");
                    });
                  },
                ),
              )
            ):Container(),
            SizedBox(
              height: getProportionateScreenWidth(10),
            ),
          ],
        ),
      ),
    );
  }
}
