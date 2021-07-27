import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/DialogApp.dart';
import 'package:shop_app/models/User.dart';

class DBUser{
  static Future<void> ajouteruser(UserModel user,BuildContext context) async {
    var userA = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid);
      return userA
      .update({
        'nom': user.nom, 
        'email': user.email,
        'prenom':user.prenom,
        'telephone':user.telephone,
        'adresse':user.adresse,
        'id':userA.id,
        'photoProfil':user.photoProfil
        })
      .then((value) { 
        print("user ajouté");
        DialogApp.afficherDialog(context, "L'utilisateurs a été bien ajouter");
      }
      )
      .catchError((error) { print("Failed to add user: $error");
        DialogApp.afficherDialog(context, "Le user n'été pas ajouter");

      }
    );               
  }
  static Future<UserModel> getUserById(String id) async { 
    DocumentSnapshot user =await FirebaseFirestore.instance.collection('users').doc(id).get();
    return   UserModel.fromJson(user.data());
  }
  /*static Future<UserModel> getAllUserById(List<String> ids) async { 
    List<UserModel> users;
    ids.for
    var usersSnap =await FirebaseFirestore.instance.collection('users').doc(id).get();
    return   UserModel.fromJson(user.data());
  }*/
  static Future<void> uploadPhoto(File _imageFile,) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref('photoDeProfil/${Timestamp.now().millisecondsSinceEpoch}');//photos
    if(_imageFile != null){
      await storageRef.putFile(_imageFile);
      String photoAdress = await storageRef.getDownloadURL();
      //user.ImgProfilUrl=photoAdress;
      //user.images.add(photoAdress);
      var info =  FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).update(
        //user.toMap()
        {"photoProfil":photoAdress}
      );
    }
    else{
      print("null");
    }
  }

}