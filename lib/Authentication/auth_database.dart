import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_cropper/image_cropper.dart';



class Auth{

 FirebaseAuth _auth = FirebaseAuth.instance;

   User? getUser(){
    return _auth.currentUser;
   }

  Future <String?> creatnewaccount(String email, String password,String username) async {
    try{
    UserCredential? userCredential = await _auth.createUserWithEmailAndPassword( email :email, password: password);

     User? user= userCredential.user;
     await user?.updateDisplayName(username);
    if(user!= null){
      return "sucess";
    }else{
      return null;
    }
    
    
  }on FirebaseAuthException catch (e) {
            if (e.code == 'email-already-use-in') {
    return'No user found for that email.';
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
          } 
  catch(e){
    print(e.toString());
     
  }
    
  
     
  }
  

Future <User?> signInWithEmailAndPassword(String email, String password) async {
    try{
    UserCredential userCredential =await _auth.signInWithEmailAndPassword( email :email, password: password);

    User? user= userCredential.user;
    if(user!= null){
      return user;
    }
    
  }on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print("No user found for that email");
            } else if (e.code == 'wrong-password') {
               print("Wrong password provided for that user. ");
            }
          } 
  catch(e){
    print(e);
     
  }
}  

Future<String?> chnagePassword(String confirmpassword)async{
  try {
    await _auth .currentUser!.updatePassword(confirmpassword,);
    return "sucess";
  }on FirebaseAuthException catch (e) {
            if (e.code == 'network-request-failed') {
              print("no conecetion");
            }}catch (e) {
   
  }
}

   Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  sigOut(){
    _auth.signOut();
} 
}