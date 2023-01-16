
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/ui/screens/login/login_screen.dart';

import 'package:flutter/material.dart';




class Dilogbox{
   final Auth _auth = Auth();
   Widget  dialog (BuildContext context){
      
   return AlertDialog(
          
            title: Text('Are you sure?'),
            content : Text('Do you want to exit the App'),
            actions: <Widget>[
              TextButton(
                onPressed: () async{
                  if(FirebaseAuth.instance.currentUser != null)
                   {
                     await _auth.sigOut();
                   }
                   
                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => LoginScreen())), (route) => false);
              
                },
                child: Text('yes'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('No'),
              ),
            ],
   );
   
     


   }
}
