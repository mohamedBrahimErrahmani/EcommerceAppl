import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';

import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';
class DBProduct{
  static Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }
  /*static Future<List<String>> ajouterPhotoProduit(List<dynamic> images) async {
    List<String> links =  [];
    TaskSnapshot taskSnapshot;
    FirebaseStorage storage = FirebaseStorage.instance;
    int i=1;
    //product.images=[];
    print("lengthLinks = ${links.length}");
    images.forEach((element) async {
      Reference storageRef = storage.ref('photosProduits/${DateTime.now()}$i');
      ByteData byteData = await element.getByteData();
        taskSnapshot=await storageRef.putData(
          byteData.buffer.asUint8List()).then((value) async {
        String link =await value.ref.getDownloadURL();
        links.add(link);
        print("lengthLinks22 = ${links.length}");
        //ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text("تمت الإضافة"))));
        return value;
      });
      i++;
    });
    return links;
  }*/
  static Future<void> ajouterProduit(Product product,List<dynamic> images) async {

    DocumentReference productRef = FirebaseFirestore.instance.collection("product").doc();
    List<String> links =  [];
    TaskSnapshot taskSnapshot;
    FirebaseStorage storage = FirebaseStorage.instance;
    int i=1;
    product.images=[];
    product.id = productRef.id;
    images.forEach((element) async {
      Reference storageRef = storage.ref('photosProduits/${DateTime.now()}$i');
      ByteData byteData = await element.getByteData();
        taskSnapshot=await storageRef.putData(
          byteData.buffer.asUint8List()).then((value) async {
        String link =await value.ref.getDownloadURL();
        product.images.add(link);
        print("${images.length}==${product.images.length}");
        if(images.length==product.images.length){
          productRef.set(product.toMap())
          .then((value) { 
            print("Produit ajouté");
          });
        }
        //ScaffoldMessenger.of(context).showSnackBar((SnackBar(content: Text("تمت الإضافة"))));
        return value;
      });
      

      i++;
    });
  }
  /*static Future<Product> getProductById(String id) async {
    DocumentReference productRef = FirebaseFirestore.instance.collection("product").doc(id);
    Product product ;
    productRef.get().then((value) {
      product =Product.fromMap(value.data());
    });
    return product;
  }*/

  static Future<List<Product>> selectProduits(String marque) async {
    List<Product> listProduits=[];
    if(marque  == null){
      await FirebaseFirestore.instance.collection('product')
      .get().then((value) {
        List<DocumentSnapshot> _myDocCount = value.docs;
        _myDocCount.forEach((element) {
          listProduits.add(new Product.fromMap(element.data()));
          //print("idcentre = ${element['idCentre']},idUser = ${FirebaseAuth.instance.currentUser.uid}");
        });
        print("length = ${_myDocCount.length}");
      });
    }
    else{
      await FirebaseFirestore.instance.collection('product').where('marque', isEqualTo: marque)
      .get().then((value) {
        List<DocumentSnapshot> _myDocCount = value.docs;
        _myDocCount.forEach((element) {
          listProduits.add(new Product.fromMap(element.data()));
          //print("idcentre = ${element['idCentre']},idUser = ${FirebaseAuth.instance.currentUser.uid}");
        });
        print("length = ${_myDocCount.length}");
      });
    }
    return listProduits;
  }
  static Future<Product> getProductById(String id)async{
    DocumentSnapshot product =await FirebaseFirestore.instance.collection('product').doc(id).get();
    return Product.fromMap(product.data());
  }

  
  static Future<List<Product>> popularProducts() async {
    Map<String , int> nbrCmdProducts = {};
    List<Product> popularProducts=[];
    await FirebaseFirestore.instance.collection('Carts')
    .get().then((value) async {
      for(var element in value.docs){
        if(nbrCmdProducts.containsKey(element["productId"])){
          nbrCmdProducts[element["productId"]] = nbrCmdProducts[element["productId"]] +
          element["numOfItem"] ;
        }
        else{
          nbrCmdProducts.putIfAbsent(element["productId"], () => element["numOfItem"] );
        }
      }
      var list = nbrCmdProducts.values.toList();
      list.sort();
      if(list.length>0)
      popularProducts.add(await DBProduct.getProductById(nbrCmdProducts.keys.firstWhere((element) => nbrCmdProducts[element]== list[list.length-1])));
      if(list.length>1)
      popularProducts.add(await DBProduct.getProductById(nbrCmdProducts.keys.firstWhere((element) => nbrCmdProducts[element]== list[list.length-2])));
      if(list.length>2)
      popularProducts.add(await DBProduct.getProductById(nbrCmdProducts.keys.firstWhere((element) => nbrCmdProducts[element]== list[list.length-3])));
    
    });
    return popularProducts;


  }
  

}