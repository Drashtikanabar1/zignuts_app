import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Dashboard.dart';
import 'package:firstapp/auth_database.dart';
import 'package:firstapp/email.dart';
import 'package:firstapp/password.dart';
import 'package:firstapp/signupfile.dart';
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
  final Auth _auth = Auth();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool showSpinner = false;
  String? _email;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: width * 0.030, top: height * 0.20),
                    child: const Text(
                      "Welcome back",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.09,
                ),
                _loginFormWidget(height, width),
                _loginButton(height, width),
                _RegisterPageLink(width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginFormWidget(double height, double width) {
    return Container(
        height: height * 0.3,
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _emailTextfield(height, width),
              _passwordTextfield(height, width),
            ],
          ),
        ));
  }

  Widget _emailTextfield(double height, double width) {
    return Container(
      width: width * 0.9,
      child: TextFormField(
        controller: _emailcontroller,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Email",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
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
        autofocus: true,
        controller: _passwordcontroller,
        decoration: InputDecoration(
          hintText: "password",
          fillColor: Colors.grey.shade100,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
        ),
        validator: (_value) =>
            _value!.length > 6 ? null : "please enter a valid password",
      ),
    );
  }

  Widget _loginButton(double height, double width) {
    return MaterialButton(
      onPressed: () async {
        if (_loginFormKey.currentState!.validate()) {
          setState(() {
            showSpinner = true;
          });

          final user = await _auth.signInWithEmailAndPassword(
              _emailcontroller.toString(), _passwordcontroller.toString()).whenComplete(() => print("login sucessfully"));
          if (user == null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("enter valid credential"),
              ),
            );
          }
        }
        setState(() {
          showSpinner = false;
        });
      },
      height: height * 0.080,
      minWidth: width * 0.9,
      color: Colors.red,
      child: const Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget forgetpassword() {
    return Container(
      child: Text(
        "Forget passwored?",
        style: TextStyle(color: Colors.grey.shade500),
      ),
    );
  }

  Widget _RegisterPageLink(double width) {
    return Container(
      padding: EdgeInsets.only(top: width * 0.06),
      child: GestureDetector(
        onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => signuppage()),
        ),
        child: const Text(
          "Don't have an account",
          style: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w200),
        ),
      ),
    );
  }

 
}
