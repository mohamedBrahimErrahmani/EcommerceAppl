import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/models/User.dart';

class DBLogin {
  static Future<String> signUpUser(String email,String motDePasse) async {
    String compteValide;
    var userCredential;
    try{
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: motDePasse);
      if (userCredential.user != null) {
        compteValide = "true";
        CollectionReference users = FirebaseFirestore.instance.collection("users");
        UserModel nouveauUtilisateur = new UserModel('','',email,'','');
        
        FirebaseFirestore.instance.collection('users').doc(userCredential.user.uid).set
        (nouveauUtilisateur.toMap());
      }
    }catch (error) {
      print(error.code);
      switch (error.code) {
        case "ERROR_OPERATION_NOT_ALLOWED":
          compteValide = "Anonymous accounts are not enabled";
          break;
        case "ERROR_WEAK_PASSWORD":
          compteValide = "Votre mot de passe est très court";
          break;
        case "ERROR_INVALID_EMAIL":
          compteValide = "Votre email invalid";
          break;
        case "email-already-in-use":
          compteValide =
              "L'email est déjà utilisé dans un autre compte";
          break;
        case "ERROR_INVALID_CREDENTIAL":
          compteValide = "Votre email est invalide";
          break;

        default:
          compteValide = "Erreur !!";
      }
    }
    return   compteValide;
  }

  static Future<String> signInUser(String email,String motDePasse) async {
    
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword( email: email, password: motDePasse);
      if (userCredential.user != null) {
        return "true";
      }
    } 
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "email n'existe pas";
      } else if (e.code == 'wrong-password') {
        return "Mot de passe incorrect";
      } else {
        return e.code;
      }
    }

  }
  
  
}