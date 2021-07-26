// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shop_app/models/Product.dart';
// import 'package:shop_app/screens/AdminPanel/ListesProduits/components/ProductCard.dart';
// import 'package:shop_app/size_config.dart';

// class CommandeBar extends StatefulWidget {
//   Product product;
//   CommandeBar(this.product);
//   @override
//   _CommandeBarState createState() => _CommandeBarState();
// }

// class _CommandeBarState extends State<CommandeBar> {
//   String quantiteController ="0";
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children :[
//         ProductCard(widget.product),
//         SizedBox(width: getProportionateScreenHeight(10)),
//         buttonCMD()

//       ]
//     );
//   }
//   Widget buttonCMD(){
//     return Padding(
//       // padding: EdgeInsets.all(5),
//       child: Container(
//       width: SizeConfig.screenWidth/10,
//         child: Column(
//           children: [
//             IconButton(
//               onPressed: (){
//                 setState(() {
//                   int x =int.parse(quantiteController);
//                   x++;
//                   print(x);
//                   quantiteController=x.toString();
//                 });
//               }, 
//               icon: FaIcon(FontAwesomeIcons.plus)
//             ),
//             SizedBox(height: getProportionateScreenHeight(5)),
//             Text(
//               quantiteController,
//               style : TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w500
//               )
//             ),
//             SizedBox(height: getProportionateScreenHeight(5)),
//             IconButton(
//               onPressed: (){
//                 setState(() {
//                   int x =int.parse(quantiteController);
//                   if(x!=0){
//                     x--;
//                     print(x);
//                     quantiteController=x.toString();
//                   }
//                 });
//               }, 
//               icon: FaIcon(FontAwesomeIcons.minus)
//             ),
//           ],
//         )
//       )
//     );
    
//   }
// }