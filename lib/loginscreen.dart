import 'package:firstapp/email.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

// ignore: camel_case_types
class _loginscreenState extends State<loginscreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: width * 0.030,top: height*0.20),
                  child: const Text(
                    "Welcome back",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.09,
              ),
               email(hinetext: "email"),
              SizedBox(height: height * 0.04),
               email(hinetext: "password"),
               loginbutton(height,width),
              Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "sign up",
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 30),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
    

  }
  Widget loginbutton(double width,double height){

   return  Container(
                     padding: EdgeInsets.only(left: width * 0.050,top: height*0.020),
                    child: Center(
                      child: ElevatedButton(
    
                          style: ButtonStyle(
                              fixedSize:
                                  MaterialStateProperty.all(Size(width*0.9,height*0.02))),
                          onPressed: () {},
                          child: Text(
                            "login ",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )),
                    ),
                  );
  }
}
