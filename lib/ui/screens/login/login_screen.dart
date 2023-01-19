import 'package:firstapp/coman_widget/buildinputdesign.dart';
import 'package:firstapp/coman_widget/comoan_text.dart';
import 'package:firstapp/coman_widget/custom_button.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/ui/screens/home/pages/dashboard/homepage.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/ui/screens/login/reset_screen.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/ui/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<LoginScreen> {
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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Row(children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    CommonText(
                        title: "Welcome!", subtitle: "Sign in and get started"),
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
                    _RegisterPageLink(),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _loginFormWidget() {
    return Container(
        child: Form(
      key: _loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BuildInputBox(
              hintext: "email",
              label: "Email",
              controller: _emailcontroller,
              validate: emailValidator),
          SizedBox(height: Dimensions.height23),
          BuildInputBox(
              hintext: "password",
              label: "password",
              controller: _passwordcontroller,
              validate: passValidator)
        ],
      ),
    ));
  }

  Widget _loginButton() {
    return showSpinner
        ? CircularProgressIndicator()
        : CustomButton(
            text: "log In",
            onPressed: () async {
              if (_loginFormKey.currentState!.validate()) {
                setState(() {
                  showSpinner = true;
                });
                final user = await _auth.signInWithEmailAndPassword(
                    _emailcontroller.text.toString(),
                    _passwordcontroller.text.toString());
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
          );
  }

  Widget _forgetpassword() {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width157),
      child: TextButton(
          child: Text("Forgot password?",
              style: TextStyle(color: Colors.grey.shade700)),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
            );
          }),
    );
  }

  Widget _RegisterPageLink() {
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(left: Dimensions.width98),
            child: RichText(
              text: const TextSpan(
                  text: "Don\'t Have account?",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 15,
                  )),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: Dimensions.width8),
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              ),
              child: RichText(
                text: TextSpan(
                    text: "Create",
                    style: TextStyle(
                      color: ColorManager.primary,
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
