

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization =  Firebase.initializeApp();
    return FutureBuilder(
      future:   _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot.error);
          return   MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.red,
              body: Container(
                  child: Center(child: Text(snapshot.error.toString()))),
            ),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: theme(),
            routes: routes,
            home:FirebaseAuth.instance.currentUser==null? SplashScreen():HomeScreen(),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.red,
            body: Container(
              color: Colors.blue,
              child:Text("hhhh")
            ),
          ),
        );
      },
    );
  }
}