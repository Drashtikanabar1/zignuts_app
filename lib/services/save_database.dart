
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/user_preferences/user_preferences.dart';
import 'package:firstapp/user_preferences/user_preferences.dart';

 


   
class StorageService {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
 FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;


  Auth _auth = Auth();

  Future<List<String>> saveCardImages(File? frontView, File? backView) async {
    final reference = await _firebaseStorage
        .ref("userloylticard")
        .child(await _auth.getUser()!.uid)
        .child(await UserPreferences.getLoginUserInfo().then((value) => value.id.toString()));

    final frontViewLink =
        await reference.child("front").putFile(frontView!).then((p0) {
      return p0.ref.getDownloadURL();
    });

    final backViewLink =
        await reference.child("back").putFile(backView!).then((p0) {
      return p0.ref.getDownloadURL();
    });
    List<String> list = [frontViewLink, backViewLink];
    return list;
  }
  
}