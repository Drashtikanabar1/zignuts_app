

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Dashboard.dart';
import 'package:firstapp/auth_database.dart';
import 'package:firstapp/email.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  final Auth _auth = Auth();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              Center(
                child: Container(
                  padding:
                      EdgeInsets.only(left: width * 0.030, top: height * 0.20),
                  child: const Text(
                    "Hello there",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.09,
              ),
              _loginFormWidget(height, width),
              _loginButton(height, width,context)
            ]),
          ),
        ),
      ),
    );
  }

  Widget _loginFormWidget(double height, double width) {
    return Container(
        height: height * 0.4,
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _emailTextfield(height, width),
              _passwordTextfield(height, width),
              _conformpasswordTextfield(height, width),
            ],
          ),    
        ));
  }

  Widget _emailTextfield(double height, double width) {
    return Container(
      width: width * 0.9,
      child: TextFormField(
        controller: _emailcontroller,
        decoration: InputDecoration(
          hintText: "Email",
          fillColor: Colors.grey.shade100,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
        validator: (value) {
          bool _result = value!.contains(
            RegExp(
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"),
          );
          return _result ? null : "please enter a valid email";
        },
      ),
    );
  }

  Widget _passwordTextfield(double height, double width) {
    return Container(
      width: width * 0.9,
      child: TextFormField(
        obscureText: true,
        controller: _passwordcontroller,
        decoration: InputDecoration(
          hintText: "password",
          fillColor: Colors.grey.shade100,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
        validator: (_value) =>
            _value!.length > 6 ? null : "please enter a valid password",
      ),
    );
  }

  Widget _conformpasswordTextfield(double height, double width) {
    return Container(
      width: width * 0.9,
      child: TextFormField(
          controller: _confirmpasswordcontroller,
          decoration: InputDecoration(
            hintText: "confirm password",
            fillColor: Colors.grey.shade100,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
          validator: (val) {
            if (val!.isEmpty) return 'Empty';
            if (val != _passwordcontroller.text) return 'Not Match';
            return null;
          }),
    );
  }

  Widget _loginButton(double height, double width,BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (_loginFormKey.currentState!.validate()) {
          try {
            final user = _auth.createUserWithEmailAndPassword(
                _emailcontroller.toString(), _passwordcontroller.toString());
            if (user != null) {
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()),);
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("please enter strong password"),
                ),
              );
            } else if (e.code == 'email-already-in-use') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("'The account already exists for that email.'"),
                ),
              );
            }
          } catch (e) {
            print (e);
          }
        }
      },
      height: height * 0.070,
      minWidth: width * 0.9,
      color: Colors.red,
      child: const Text(
        "sign up",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }
}
