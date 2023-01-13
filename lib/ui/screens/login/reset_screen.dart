import 'package:colours/colours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/coman_widget/buildinputdesign.dart';


import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/ui/screens/login/login_screen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is requried'),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        errorText: "please enter vaild email")
  ]);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("Back"),
        elevation: 0.00,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.centerLeft, child: _titleWidget(h, w)),
              SizedBox(
                height: h * 0.015,
              ),
              _loginFormWidget(h, w),
              _sendlink(h, w),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleWidget(double h, double w) {
    return Container(
      width: w,
      padding: EdgeInsets.only(top: h * 0.03),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: w * 0.04),
              child: RichText(
                text: const TextSpan(
                    text: "Reset Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02),
                child: Text(
                    "Enter the email associted with your account and we'll send an email with instruction to reset your password",style: TextStyle(),),
                    
                    ),
          ]),
    );
  }

  Widget _loginFormWidget(double height, double w) {
    return Container(
        height: height * 0.2,
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BuildInputBox(hintext: "Email", label: "Email address", controller: _emailcontroller)

            ],
          ),
        ));
  }

  Widget _sendlink(double height, double width) {
    return Center(
      child: Container(
        
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ColorManager.primary)),
            child: Text("Rest PassWord", style: TextStyle(color: Colors.white)),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.sendPasswordResetEmail(
                    email: _emailcontroller.text.toString());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Password Reset Email Sent"),
                ));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("No user found for that email"),
                  ));
                }
              } catch (e) {}
            }),
      ),
    );
  }
}
