import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Dashboard.dart';


class Auth{

  final FirebaseAuth _auth =FirebaseAuth.instance;

  Future <User?> createUserWithEmailAndPassword( String email, String password) async {
    try{
    UserCredential userCredential =await _auth.createUserWithEmailAndPassword( email :email, password: password);

     User? user= userCredential.user;
    if(user!= null){
      return user;
    }
    
  }on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
          } 
  catch(e){
    print(e);
     
  }
    
  
     
  }
  

Future <User?> signInWithEmailAndPassword( String email, String password) async {
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
}  //sign in anon
  sigOut(){
    _auth.signOut();
} 
}