import 'package:firstapp/coman_widget/buildinputdesign.dart';
import 'package:firstapp/coman_widget/comoan_text.dart';
import 'package:firstapp/coman_widget/custom_button.dart';
import 'package:firstapp/l10n/localization.dart';
import 'package:firstapp/resources/string_manager.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/resources/validatot_manager.dart';
import 'package:firstapp/ui/screens/home/pages/homepage/homepage.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/ui/screens/login/reset_screen.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/ui/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = 'LoginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final Auth _auth = Auth();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  bool showSpinner = false;

  //A function that validate user entered password

  
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Row(children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  CommonText(
                      title:AppLocalizations.of(context)!.welcome,
                        subtitle:AppLocalizations.of(context)!.loginsubtitle,
                       ),
                  SizedBox(
                    height: Dimensions.height70,
                  ),
                  _loginFormWidget(),
                  SizedBox(
                    height: Dimensions.height23,
                  ),
                  _loginButton(),
                  SizedBox(
                    height: Dimensions.height23,
                  ),
                  _forgetpassword(),
                  SizedBox(
                    height: Dimensions.height31,
                  ),
                  _registerPageLink(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _loginFormWidget() {
    return Form(
      key: _loginFormKey,
      child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      BuildInputBox(
           hintext:AppLocalizations.of(context)!.email,
          label:StringManager.emaillable,
          controller: _emailcontroller,
          validate:Validator.emailValidator),
      SizedBox(height: Dimensions.height23),
      BuildInputBox(
          hintext:AppLocalizations.of(context)!.password,
          label:StringManager.passwordlable,
          controller: _passwordcontroller,
          validate:Validator.passValidator)
    ],
      ),
    );
  }

  Widget _loginButton() {
    return showSpinner
        ? const CircularProgressIndicator()
        : CustomButton(
            text:AppLocalizations.of(context)!.login,
            onPressed: () async {
              if (_loginFormKey.currentState!.validate()) {
                setState(() {
                  showSpinner = true;
                });
                final user = await _auth.signInWithEmailAndPassword(
                    _emailcontroller.text.toString(),
                    _passwordcontroller.text.toString());
                if (user != null) {
                  Navigator.pushReplacementNamed(
                    context,
                   HomePage.id,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(StringManager.entervaildcredential),
                    ),
                  );
                }
              }
              setState(() {
                showSpinner = false;
              });
            },
          );
  }

  Widget _forgetpassword() {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width157),
      child: TextButton(
          child: Text(StringManager.Forgotpassword,
              style: TextStyle(color: Colors.grey.shade700)),
          onPressed: () {
            Navigator.pushNamed(
             context,ResetPasswordScreen.id,
            );
          }),
    );
  }

  Widget _registerPageLink() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: Dimensions.width98),
          child: RichText(
            text: const TextSpan(
                text: StringManager.donthaveaccount,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 15,
                )),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: Dimensions.width8),
          child: GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(
              context,
            RegisterScreen.id,
            ),
            child: RichText(
              text: TextSpan(
                  text: StringManager.create,
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
