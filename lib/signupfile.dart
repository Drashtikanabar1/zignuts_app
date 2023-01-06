import 'package:colours/colours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/dashboard.dart';
import 'package:firstapp/auth_database.dart';
import 'package:firstapp/email.dart';
import 'package:firstapp/loginscreen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  final Auth _auth = Auth();
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
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();
  TextEditingController _usercontroller = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colours.aliceBlue,
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
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
                      "New Account",
                      style: TextStyle(fontSize: 30, color: Colors.pink),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: width * 0.06,
                    ),
                    child: const Text(
                      "Sign up and get started",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            _loginFormWidget(height, width),
            SizedBox(
              height: height * 0.03,
            ),
            _loginButton(height, width, context),
            SizedBox(
              height: height * 0.04,
            ),
            _RegisterPageLink(width, height),
          ]),
        ),
      ),
    );
  }

  Widget _loginFormWidget(double height, double width) {
    return Container(
        height: height * 0.5,
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _usernameTextfield(height, width),
              
              _emailTextfield(height, width),
              _passwordTextfield(height, width),
            
              _conformpasswordTextfield(height, width),
            ],
          ),
        ));
  }
  Widget _usernameTextfield(double height, double width) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 10,
          offset: const Offset(
            1,
            1,
          ),
          color: Colors.grey.withOpacity(0.5),
        ),
      ]),
      width: width * 0.8,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _usercontroller,
        autofocus: true,
        decoration: InputDecoration(
          label: Text("username",),
             floatingLabelStyle: TextStyle(color: Colors.pink),
          hintText: "Enter your Name",
         
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
              focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: BorderSide(
                color:Colours.pink,
              )),
          fillColor: Colors.grey.shade100,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
        ),
        validator:  (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (value.trim().length < 4) {
                            return 'Username must be at least 4 characters in length';
                          };
                          },
      ),
    );
  }
  Widget _emailTextfield(double height, double width) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 10,
          offset: const Offset(
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
          label: Text("Email",),
             floatingLabelStyle: TextStyle(color: Colors.pink),
          hintText: "Email",
         
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
              focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: BorderSide(
                color:Colours.pink,
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
          offset: const Offset(
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
              borderSide: const BorderSide(
                color: Colors.white,
              )),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: const BorderSide(
                color: Colors.pink,
              )),    
             
          label: const Text("Password",),
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

  Widget _conformpasswordTextfield(double height, double width) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 10,
          offset: const Offset(
            1,
            1,
          ),
          color: Colors.grey.withOpacity(0.5),
        ),
      ]),
      width: width * 0.8,
      child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _confirmpasswordcontroller,
          autofocus: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                borderSide: const BorderSide(
                  color: Colors.white,
                )),
               focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                borderSide: const BorderSide(
                  color: Colors.pink,
                )),
            hintText: "confirm password",
            label: const Text("confirm Password",),
            floatingLabelStyle: TextStyle(color: Colors.pink),
            

            fillColor: Colors.grey.shade100,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
          ),
          validator: (val) {
            if (val!.isEmpty) return 'confirm password is requried';
            if (val != _passwordcontroller.text) return 'Not Match';
            return null;
          }),
    );
  }

  Widget _loginButton(double height, double width, BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () async {
        if (_loginFormKey.currentState!.validate()) {
          final user = await _auth
              .creatnewaccount(_emailcontroller.text.toString(),
                  _passwordcontroller.text.toString(),_usercontroller.text.toString());
             
          if (user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {
            print("123");
          }
        }
      },
      height: height * 0.06,
      minWidth: width * 0.8,
      color: Colors.pink,
      child: const Text(
        "sign up",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget _RegisterPageLink(double width, height) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: width * 0.2),
          child: RichText(
            text: const TextSpan(
                text: "Allready you account",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )),
          ),
        ),
        Container(
          child: GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const loginscreen()),
            ),
            child: RichText(
              text: const TextSpan(
                  text: "Login in",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
