import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class password extends StatefulWidget {
  final String hinetext;
  

  const password({super.key, required this.hinetext,  });
  

  @override
  State<password> createState() => _passwordState();
}

class _passwordState extends State<password> {
  
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
                  padding:
                      EdgeInsets.only(left: width * 0.030, top: height * 0.20),
                  child: const Text(
                    "Welcome back",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.09,
              ),
             
              loginbutton(height, width),
              forgetpassword(height, width),
              signupbutton(height, width),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginbutton(double width, double height) {
    return Container(
      padding: EdgeInsets.only(
          left: width * 0.030, top: height * 0.030, right: width * 0.03),
      child: Center(
        child: ElevatedButton(
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                    Size(width * 0.9, height * 0.02))),
            onPressed: () {},
            child: const Text(
              "login ",
              style: TextStyle(
                fontSize: 18,
              ),
            )),
      ),
    );
  }

  Widget forgetpassword(double height, double width) {
    return Container(
      padding: EdgeInsets.only(left: width * 0.6, top: height * 0.02),
      child: Text(
        "Forget passwored?",
        style: TextStyle(color: Colors.grey.shade500),
      ),
    );
  }

  Widget signupbutton(double height, double width) {
    return Container(
      padding: EdgeInsets.only(left: width * 0.05),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, 'register');
        },
        child: const Text(
          "sign up",
          style: TextStyle(decoration: TextDecoration.underline, fontSize: 30),
        ),
      ),
    );
  }
  
}
