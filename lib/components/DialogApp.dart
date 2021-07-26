import 'package:flutter/material.dart';

class DialogApp{
  static void afficherDialog(BuildContext context,String titre){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titre),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Center(child : Text('OK'),)
          ),
          
        ],
      ),
    );
  }
  static void afficherDialog2pop(BuildContext context,String titre){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titre),
        actions: <Widget>[
          TextButton(
            onPressed: () { 
              Navigator.pop(context, 'OK');
              Navigator.pop(context, 'OK');
              
            },
            child: const Center(child : Text('OK'),)
          ),
          
        ],
      ),
    );
  }
}