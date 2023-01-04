import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class email extends StatefulWidget {
  
  final String hinetext;
  
 
  

   email({super.key, required this.hinetext,   });
  

  @override
  State<email> createState() => _emailState();
}

class _emailState extends State<email> {
  
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      
   padding: EdgeInsets.only(top: height *0.01,left: width*0.04,right:width*0.04),
    child: TextFormField(
      key: _loginFormKey,
       decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled: true,
         hintText: widget.hinetext,
       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10,),),
       ),
    ),
  );
   
  }
}