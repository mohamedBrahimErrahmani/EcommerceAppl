import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/models/User.dart';

class DBLogin {
  static Future<UserModel> signUpUser(String email,String motDePasse) async {
    var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: motDePasse);
    
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    UserModel nouveauUtilisateur = new UserModel('','',email,'','');
    
    FirebaseFirestore.instance.collection('users').doc(result.user.uid).set
    (nouveauUtilisateur.toMap())
    .then((value) => print("User Added"))
    .catchError((error) => print("Failed to add user: $error"));

    return   nouveauUtilisateur;
  }

  static Future<String> signInUser(String email,String motDePasse) async {
    
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email, password: motDePasse);
      if (userCredential.user != null) {
        return "true";
      }
    } on FirebaseAuthException catch (e) {
        //
        //_loading=false;
        if (e.code == 'user-not-found') {
          return "email n'existe pas";
        } else if (e.code == 'wrong-password') {
          return "Mot de passe incorrect";
        } else {
          return e.code;
        }
    }
    
    
    
    /*CollectionReference users = FirebaseFirestore.instance.collection("users");
    UserModel nouveauUtilisateur = new UserModel('','',email,'','');
    
    FirebaseFirestore.instance.collection('users').doc(result.user.uid).set
    (nouveauUtilisateur.toMap())
    .then((value) => print("User Added"))
    .catchError((error) => print("Failed to add user: $error"));*/

    // return  await result.user;
  }
  
  
}