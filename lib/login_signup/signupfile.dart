import 'package:colours/colours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Pages/Dashboard_pages/dashboard.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/login_signup/email.dart';

import 'package:firstapp/login_signup/loginscreen.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/resources/statics_manager.dart';

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
    RequiredValidator(errorText: StringManager.emailrequried),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        errorText: StringManager.emailvalid)
  ]);
  final passValidator = MultiValidator([
    RequiredValidator(errorText: StringManager.passwordrequried),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        errorText: StringManager.passwordlvalid)
  ]);
  final usernameValidator = MultiValidator([
    RequiredValidator(errorText:StringManager.confirmpasswordrequried ),
   MinLengthValidator(6,
            errorText: StringManager.userrequried),
  ]);
  





  List images = ["g.png", "t.png", "f.png"];
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
                    child: Text(
                      "New Account",
                      style:
                          TextStyle(fontSize: 30, color: ColorManager.primary),
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
            _loginFormWidget(height, width),
            _loginButton(height, width, context),
            SizedBox(
              height: height * 0.03, 
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
              email(hintext:StringManager.usernamelhintext, label:StringManager.usernamelable, controller: _usercontroller,validate: usernameValidator,),
              email(hintext:StringManager.emaillhintext, label:StringManager.emaillable, controller: _emailcontroller,validate: emailValidator,),
              email(hintext:StringManager.passwordlable, label:StringManager.passwordlable, controller: _passwordcontroller,validate: passValidator,),
              email(hintext:StringManager.confirmpassewordhintext, label:StringManager.confirmpasswordlable, controller: _confirmpasswordcontroller,validate:(val) {
               if (val!.isEmpty) return StringManager.confirmpasswordrequried;
              if (val != _passwordcontroller.text) return StringManager.confirmpasswordvalid;
            return null;
              }, ),

             
            ],
          ),
        ));
  }
  Widget _loginButton(double height, double width, BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () async {
        if (_loginFormKey.currentState!.validate()) {
          final user = await _auth.creatnewaccount(_emailcontroller.text,
              _passwordcontroller.text, _usercontroller.text.trim());

          if (user != null) {
            if (user == "sucess") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            } else {
              print(user.toString());
            }
          } else {
            print("123");
          }
        }
      },
      height: height * 0.06,
      minWidth: width * 0.8,
      color: ColorManager.primary,
      child: const Text(
        StringManager.signuupbutton,
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
                text: "Allready you account ? ",
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
              text:  TextSpan(
                  text: "Login In",
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ),
      ],
    );
  }

  Widget _google() {
    return Row(
        children: List<Widget>.generate(3, (index) {
      return CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(" assest/images/" + images[index]),
      );
    }));
  }
}
