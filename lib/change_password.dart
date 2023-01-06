import 'package:colours/colours.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/auth_database.dart';
import 'package:firstapp/loginscreen.dart';
import 'package:firstapp/password.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
  
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final Auth _auth = Auth();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
    TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();
  final passValidator = MultiValidator([
    RequiredValidator(errorText: 'password is requried'),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        errorText: "please enter vaild password")
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
                height: h * 0.05,
              ),
              _loginFormWidget(h, w),
               SizedBox(
                height: h * 0.05,
              ),
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
                    text: "Create new Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02),
                child: const Text(
                    "Your new password must be differnt from pervious used passwords",),
                    
                    ),
          ]),
    );
  }

  Widget _loginFormWidget(double height, double w) {
    return Container(
        height: height * 0.25,
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _emailTextfield(w),
              SizedBox(height: height*0.03,),
              _passwordTextfield(w)
            ],
          ),
        ));
  }

  Widget _emailTextfield(double w) {
    return Padding(
      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
      child: TextFormField(
        decoration:  InputDecoration(hintText: "Password",label:const Text("Password"),
             floatingLabelStyle:const  TextStyle(color: Colors.pink),focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: BorderSide(
                color:Colours.pink,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.grey.shade100,
          filled: true,
          
          ),
        autofocus: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _passwordcontroller,
        validator: passValidator,
      ),
    );
  }
  Widget _passwordTextfield(double w) {
    return Padding(
      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
      child: TextFormField(
        decoration:  InputDecoration(hintText: "Password",label:const Text("Confirm Password"),
             floatingLabelStyle:const  TextStyle(color: Colors.pink),focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: BorderSide(
                color:Colours.pink,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: Colors.grey.shade100,
          filled: true,
          
          ),
        autofocus: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _confirmpasswordcontroller,
        validator: (val) {
            if (val!.isEmpty) return 'password is requried';
            if (val != _passwordcontroller.text) return '"Both should match';
            return null;
          }
      ),
    );
  }
  Widget _sendlink(double height, double width) {
    return Center(
      child: Container(
        
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink)),
            child: Text("Rest PassWord", style: TextStyle(color: Colors.white)),
            onPressed: () async {
              if (_loginFormKey.currentState!.validate()) {
          final user = await _auth.chnagePassword(_confirmpasswordcontroller.text.toString());

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("passwors is change")));
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangePassword()),
                );
         
        }
            }),
      ),
    );
  }
}

  