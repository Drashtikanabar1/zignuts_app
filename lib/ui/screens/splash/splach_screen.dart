import 'dart:async';


import 'package:firstapp/resources/assets_manager.dart';
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
          ()=>Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          const LoginScreen()
                                                         )
                                       )
         );
  }
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    final width =MediaQuery.of(context).size.width;
    return Scaffold(
     body: Center(
      child:Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top:height*0.400,),),
              Image.asset(ImageAssets.splashLogo,
                  height: height*0.2,
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