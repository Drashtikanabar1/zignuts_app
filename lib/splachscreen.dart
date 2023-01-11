import 'dart:async';


import 'package:firstapp/login_signup/loginscreen.dart';
import 'package:firstapp/resources/assets_manager.dart';
import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
   
  
   @override
     void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
          ()=>Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          const loginscreen()
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