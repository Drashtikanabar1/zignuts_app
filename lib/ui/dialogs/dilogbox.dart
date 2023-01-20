
// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/resources/string_manager.dart';
import 'package:firstapp/ui/screens/login/login_screen.dart';

import 'package:flutter/material.dart';




class Dilogbox{
 
    static Widget  dialog ({required BuildContext context,required content, required Function() onYes}){
      
   return AlertDialog(
          
            title: Text(StringManager.Areusure),
            content : Text(content),
            actions: <Widget>[
              TextButton(
                onPressed:onYes,
                child: Text(StringManager.yes),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(StringManager.No),
              ),
            ],
   );
   
     


   }
}


