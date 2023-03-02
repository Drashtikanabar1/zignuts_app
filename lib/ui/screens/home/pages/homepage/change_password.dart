import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/coman_widget/buildinputdesign.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});
 static const String id = 'ChangePassword';
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final Auth _auth = Auth();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller = TextEditingController();
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
                "Your new password must be differnt from pervious used passwords",
              ),
            ),
          ]),
    );
  }

  Widget _loginFormWidget(double height, double w) {
    return Padding(
      padding: const EdgeInsets.only(left: 40,right: 30),
      child: SizedBox(
   
          height: height * 0.25,
          child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BuildInputBox(
                  hintext: "Password",
                  label: "Password",
                  controller: _passwordcontroller,
                  validate: passValidator,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                BuildInputBox(
                    hintext: "Confirm Password",
                    label: "Confirm Password",
                    controller: _confirmpasswordcontroller,
                    validate: (val) {
                      if (val!.isEmpty) return 'password is requried';
                      if (val != _passwordcontroller.text) {
                        return '"Both should match';
                      }
                      return null;
                    })
              ],
            ),
          )),
    );
  }

  Widget _sendlink(double height, double width) {
    return Center(
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorManager.primary)),
          child: const Text("Rest PassWord", style: TextStyle(color: Colors.white)),
          onPressed: () async {
            if (_loginFormKey.currentState!.validate()) {
              final user = await _auth
                  .chnagePassword(_confirmpasswordcontroller.text.toString());

              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("passwors is change")));
              Navigator.pushNamed(
                context,
     
            ChangePassword.id,
              );
            }
          }),
    );
  }
}
