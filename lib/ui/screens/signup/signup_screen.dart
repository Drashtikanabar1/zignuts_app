  // ignore: use_build_context_synchronously

import 'package:colours/colours.dart';
import 'package:firstapp/authentication/auth_database.dart';
import 'package:firstapp/coman_widget/buildinputdesign.dart';
import 'package:firstapp/coman_widget/comoan_text.dart';
import 'package:firstapp/coman_widget/custom_button.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/resources/validatot_manager.dart';
import 'package:firstapp/ui/screens/home/pages/homepage/homepage.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/resources/string_manager.dart';
import 'package:flutter/material.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
 static const String id = 'RegisterScreen';
  @override
  State<RegisterScreen> createState() => _SignuppageState();
}

class _SignuppageState extends State<RegisterScreen> {
  final Auth _auth = Auth();
  List images = ["g.png", "t.png", "f.png"];
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller = TextEditingController();
  final TextEditingController _usercontroller = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colours.aliceBlue,
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            CommonText(
                title: StringManager.newaccount, subtitle: StringManager.signupsubtitle),
            _loginFormWidget(),
            _loginButton(context),
            SizedBox(
              height: Dimensions.height23,
            ),
            _registerPageLink(),
          ]),
        ),
      ),
    );
  }

  Widget _loginFormWidget() {
    return SizedBox(
        height: Dimensions.height391,
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BuildInputBox(
                hintext: StringManager.usernamelhintext,
                label: StringManager.usernamelable,
                controller: _usercontroller,
                validate: Validator.usernameValidator,
              ),
              BuildInputBox(
                hintext: StringManager.emaillhintext,
                label: StringManager.emaillable,
                controller: _emailcontroller,
                validate: Validator.emailValidator,
              ),
              BuildInputBox(
                hintext: StringManager.passwordlable,
                label: StringManager.passwordlable,
                controller: _passwordcontroller,
                validate: Validator.passValidator,
              ),
              BuildInputBox(
                hintext: StringManager.confirmpassewordhintext,
                label: StringManager.confirmpasswordlable,
                controller: _confirmpasswordcontroller,
                validate:(value) => Validator.confirmpassworrd(value!,_passwordcontroller.text), 
                
              ),
            ],
          ),
        ));
  }

  Widget _loginButton(BuildContext context) {
    return CustomButton(
      text: StringManager.signuupbutton,
      onPressed: () async {
        if (_loginFormKey.currentState!.validate()) {
          final user = await _auth.creatnewaccount(
            _emailcontroller.text,
            _passwordcontroller.text,
            _usercontroller.text.trim(),
          );
          if (user != null) {
            if (user == "sucess") {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(
                context,HomePage.id);
            } else {
              print(user.toString());
            }
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: Text(user.toString()),
              ),
            );
          }
        }
      },
    );
  }

  Widget _registerPageLink() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: Dimensions.width78),
          child: RichText(
            text: const TextSpan(
                text:StringManager.allreadyaccount ,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                )),
          ),
        ),
         GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(
            context,
            LoginScreen.id,
          ),
          child: RichText(
            text: TextSpan(
                text: StringManager.loginbutton,
                style: TextStyle(
                  color: ColorManager.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ],
    );
  }

}

