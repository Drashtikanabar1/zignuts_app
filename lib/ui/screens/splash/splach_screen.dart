import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/resources/assets_manager.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/ui/screens/home/pages/dashboard/homepage.dart';
import 'package:firstapp/ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<SplashScreen> {
   
  
   @override
     void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
          (){
            //
          FirebaseAuth.instance.authStateChanges().listen((event) { if(event!=null){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
          }else{
          
            Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          const LoginScreen()
                                                         )
                                                                  );
                                                                  }


          }
          );
          }
    
          );
          
         
  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
     body: Center(
      child:Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top:Dimensions.splashpadding313,),),
              Image.asset(ImageAssets.splashLogo,
                  height:Dimensions.splashlogo160,
                  scale: 2.5,
                  // color: Color.fromARGB(255, 15, 147, 59),
                  opacity:
                      const AlwaysStoppedAnimation<double>(0.5)), //Image.asset
               // Image.asset
            ], //<Widget>[]
          ), 
     ),

     );
    
  }
}