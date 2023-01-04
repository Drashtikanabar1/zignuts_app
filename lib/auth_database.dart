import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Dashboard.dart';


class Auth{

  final FirebaseAuth _auth =FirebaseAuth.instance;

  Future <User?> createUserWithEmailAndPassword( String email, String password) async {
    try{
    UserCredential userCredential =await _auth.createUserWithEmailAndPassword( email :email, password: password);

    return userCredential.user;
    
  }catch(e){
     
  }
}  

Future <User?> signInWithEmailAndPassword( String email, String password) async {
    try{
    UserCredential userCredential =await _auth.signInWithEmailAndPassword( email :email, password: password);

    return userCredential.user;
    
  }catch(e){
     
  }
}  //sign in anon
  sigOut(){
    _auth.signOut();
} 
}