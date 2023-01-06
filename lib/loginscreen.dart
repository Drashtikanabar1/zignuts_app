import 'package:colours/colours.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/dashboard.dart';
import 'package:firstapp/auth_database.dart';
import 'package:firstapp/reset.dart';

import 'package:firstapp/signupfile.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

// ignore: camel_case_types
class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

// ignore: camel_case_types
class _loginscreenState extends State<loginscreen> {
  final Auth _auth = Auth();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool showSpinner = false;

  //A function that validate user entered password

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is requried'),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        errorText: "please enter vaild email")
  ]);
  final passValidator = MultiValidator([
    RequiredValidator(errorText: 'password is requried'),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        errorText: "please enter vaild password")
  ]);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Row(children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    _welcome(height, width),
                    SizedBox(
                      height: height * 0.09,
                    ),
                    _loginFormWidget(height, width),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    _loginButton(height, width),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    _forgetpassword(height, width),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    _RegisterPageLink(width, height),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _welcome(double height, double width) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: Colours.lavender,
                offset: const Offset(
                  2.0,
                  3.0,
                )),
          ]),
      width: width,
      height: height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: width * 0.06),
            child: const Text(
              "Welcome!",
              style: TextStyle(fontSize: 30, color: Colors.pink),
            ),
          ),
          SizedBox(
            height: height * 0.016,
          ),
          Container(
            padding: EdgeInsets.only(
              left: width * 0.06,
            ),
            child: const Text(
              "Sign in and get started",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginFormWidget(double height, double width) {
    return Container(
        child: Form(
      key: _loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _emailTextfield(height, width),
          SizedBox(
            height: height * 0.03,
          ),
          _passwordTextfield(height, width),
        ],
      ),
    ));
  }

  Widget _emailTextfield(double height, double width) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 10,
          offset: Offset(
            1,
            1,
          ),
          color: Colors.grey.withOpacity(0.5),
        ),
      ]),
      width: width * 0.8,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _emailcontroller,
        autofocus: true,
        decoration: InputDecoration(
          label:const Text("Email"),
             floatingLabelStyle: TextStyle(color: Colors.pink),
          hintText: "Email",
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide:const BorderSide(
                color:Colours.pink,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
          fillColor: Colors.grey.shade100,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
        ),
        validator: emailValidator,
      ),
    );
  }

  Widget _passwordTextfield(double height, double width) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 10,
          offset: Offset(
            1,
            1,
          ),
          color: Colors.grey.withOpacity(0.5),
        ),
      ]),
      width: width * 0.8,
      child: TextFormField(
        autofocus: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _passwordcontroller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: BorderSide(
                color: Colors.white,
              )),
              focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: BorderSide(
                color:Colours.pink,
              )),
          label: const Text("Password"),
             floatingLabelStyle: TextStyle(color: Colors.pink),
          hintText: "Password",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
        ),
        validator: passValidator,
      ),
    );
  }

  Widget _loginButton(double height, double width) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () async {
        if (_loginFormKey.currentState!.validate()) {
          setState(() {
            showSpinner = true;
          });

          final user = await _auth
              .signInWithEmailAndPassword(_emailcontroller.text.toString(),
                  _passwordcontroller.text.toString())
              .whenComplete(() => print("login sucessfully"));
          if (user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("enter valid credential"),
              ),
            );
          }
        }
        setState(() {
          showSpinner = false;
        });
      },
      minWidth: width * 0.8,
      height: height * 0.06,
      color: Colors.pink,
      child: const Text(
        "Log in",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _forgetpassword(double height, double width) {
    return Container(
      padding: EdgeInsets.only(left: width * 0.4),
      child: TextButton(
          child: Text("Forgot password?",
              style: TextStyle(color: Colors.grey.shade700)),
          onPressed: () {{} Navigator.of(context).push(
            
              MaterialPageRoute(builder: (context) => ResetPage()),
            );}),
    );
  }

  Widget _RegisterPageLink(double width, height) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: width * 0.25),
            child: RichText(
              text: const TextSpan(
                  text: "Don\'t Have account?" ,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: width*0.02),
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const signuppage()),
              ),
              child: RichText(
                text: const TextSpan(
                    text: "Create",
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
