import 'dart:async';


import 'package:firstapp/loginscreen.dart';
import 'package:firstapp/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
   
  
   void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
          ()=>Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          loginscreen()
                                                         )
                                       )
         );
  }
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
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