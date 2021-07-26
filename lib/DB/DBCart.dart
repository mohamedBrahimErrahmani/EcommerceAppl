import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_app/DB/DBProduct.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';

class DBCart{
  static Future<void> ajouterCommande(Cart cart) async {

    DocumentReference productRef = FirebaseFirestore.instance.collection("Carts").doc();
    cart.id=productRef.id;
    productRef.set(cart.toMap())
    .then((value) { 
      print("Commande ajouté");
    });
  }
  static Future<List<Cart>> selectCommandes() async {
    List<Cart> listCart=[];
    await FirebaseFirestore.instance.collection('Carts')
    .get().then((value) {
      List<DocumentSnapshot> _myDocCount = value.docs;
      _myDocCount.forEach((element) {
        listCart.add(new Cart.fromMap(element.data()));
        //print("idcentre = ${element['idCentre']},idUser = ${FirebaseAuth.instance.currentUser.uid}");
      });
      print("length = ${_myDocCount.length}");
    });
    return listCart;
  }

  static Future<void> validerCommandes(String idUser,List<Cart> carts) async {
    
    for(var cart in carts){
      await FirebaseFirestore.instance.collection('Carts').doc(cart.id)
      .update(
        {
          "etatCommande" : "effectué"
        }
      );

    }
  }
  static Future<Map<String,int>> userNbrCommandes() async {
    Map<String,int> userNbrCmd = {};
    await FirebaseFirestore.instance.collection('Carts').where("etatCommande", isEqualTo:"enAttente" ).get().then((value) {
      value.docs.forEach((element) {
        if(userNbrCmd.containsKey(element['idUser'])){
          userNbrCmd[element['idUser']]++;
        }
        else{
          userNbrCmd.putIfAbsent(element['idUser'], () => 1);
        }
      });
    });
    return userNbrCmd;
  }

  static Future<double> sommeCommandeByUser(String idUser) async {
    double prixGlobal=0,prixUnitaire;
    await FirebaseFirestore.instance.collection('Carts').where("etatCommande", isEqualTo:"enAttente" ).where("idUser",isEqualTo: idUser) .get().
    then((value)  async {
      for(var element in value.docs) {
        Product product = await DBProduct.getProductById(element['productId']);
        prixUnitaire =  product.price * element['numOfItem'];
        prixGlobal = prixGlobal + prixUnitaire;
        print("prixGlobalAvant = $prixGlobal");
      }
    });
    print("prixGlobalAprès = $prixGlobal");
    return prixGlobal;
  }
  static Future<void> removeCart(String id) async {
    FirebaseFirestore.instance.collection('Carts').doc(id).delete();
  }
  static Future<List<Cart>> selectCommandesByUser(String id) async {
    List<Cart> listCart=[];
    await FirebaseFirestore.instance.collection('Carts').where("idUser",isEqualTo: id).where("etatCommande" , isEqualTo: "enAttente")
    .get().then((value) {
      List<DocumentSnapshot> _myDocCount = value.docs;
      _myDocCount.forEach((element) {
        listCart.add(new Cart.fromMap(element.data()));
        //print("idcentre = ${element['idCentre']},idUser = ${FirebaseAuth.instance.currentUser.uid}");
      });
      print("length = ${_myDocCount.length}");
    });
    return listCart;
  }
  
  
}