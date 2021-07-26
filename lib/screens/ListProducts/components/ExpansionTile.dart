import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/AdminPanel/ListesProduits/components/ProductCard.dart';
import 'package:shop_app/screens/ListProducts/components/CommandeBar.dart';
import 'package:shop_app/size_config.dart';

class ExpansionTileProduct extends StatefulWidget {
  static Map<String,int> productQteCmd={};
  String marque;
  List<Product> produitMarque;
  ExpansionTileProduct(this.marque,this.produitMarque);
  @override
  _ExpansionTileProductState createState() => _ExpansionTileProductState();
}
class _ExpansionTileProductState extends State<ExpansionTileProduct> {
  @override
  void initState() {
    productQte();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          widget.marque,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: kPrimaryColor),
        ),
        collapsedBackgroundColor:  Color(0xFFDECB9C),
        collapsedTextColor: Colors.white,
        children: <Widget>[
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: widget.produitMarque.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children :[
                  ProductCard(widget.produitMarque[index]),
                  SizedBox(width: getProportionateScreenHeight(10)),
                  buttonCMD(index)
                ]
              );
            },
          ),
        ],
      ),
    );
  }
  void productQte(){//produit / Quantité demandée
    widget.produitMarque.forEach((element) {
      if(!ExpansionTileProduct.productQteCmd.containsKey(element.id))
      {ExpansionTileProduct.productQteCmd.putIfAbsent(element.id, () => 0);}
    });
  }
  Widget buttonCMD(int index){
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
      width: SizeConfig.screenWidth/10,
        child: Column(
          children: [
            IconButton(
              onPressed: (){
                setState(() {
                  ExpansionTileProduct.productQteCmd[widget.produitMarque[index].id]++;
                });
                ExpansionTileProduct.productQteCmd.forEach((key, value) {
                });
              }, 
              icon: FaIcon(FontAwesomeIcons.plus)
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            Text(
              ExpansionTileProduct.productQteCmd[widget.produitMarque[index].id].toString(),
              style : TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500
              )
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            IconButton(
              onPressed: (){
                setState(() {
                  if(ExpansionTileProduct.productQteCmd[widget.produitMarque[index].id]!=0)
                  ExpansionTileProduct.productQteCmd[widget.produitMarque[index].id]--;
                });
              }, 
              icon: FaIcon(FontAwesomeIcons.minus)
            ),
          ],
        )
      )
    );
  }
}