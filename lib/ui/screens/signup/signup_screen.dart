import 'package:colours/colours.dart';
import 'package:firstapp/coman_widget/buildinputdesign.dart';
import 'package:firstapp/coman_widget/comoan_text.dart';
import 'package:firstapp/coman_widget/custom_button.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/ui/screens/home/pages/homepage/homepage.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _SignuppageState();
}

class _SignuppageState extends State<RegisterScreen> {
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
    RequiredValidator(errorText: StringManager.confirmpasswordrequried),
    MinLengthValidator(6, errorText: StringManager.userrequried),
  ]);

  List images = ["g.png", "t.png", "f.png"];
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();
  TextEditingController _usercontroller = TextEditingController();
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
            _RegisterPageLink(),
          ]),
        ),
      ),
    );
  }

  Widget _loginFormWidget() {
    return Container(
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
                validate: usernameValidator,
              ),
              BuildInputBox(
                hintext: StringManager.emaillhintext,
                label: StringManager.emaillable,
                controller: _emailcontroller,
                validate: emailValidator,
              ),
              BuildInputBox(
                hintext: StringManager.passwordlable,
                label: StringManager.passwordlable,
                controller: _passwordcontroller,
                validate: passValidator,
              ),
              BuildInputBox(
                hintext: StringManager.confirmpassewordhintext,
                label: StringManager.confirmpasswordlable,
                controller: _confirmpasswordcontroller,
                validate: (val) {
                  if (val!.isEmpty)
                    return StringManager.confirmpasswordrequried;
                  if (val != _passwordcontroller.text)
                    return StringManager.confirmpasswordvalid;
                  return null;
                },
              ),
            ],
          ),
        ));
  }

  Widget _loginButton(BuildContext context) {
    return CustomButton(
      text: StringManager.signuupbutton      ,
      onPressed: () async {
        if (_loginFormKey.currentState!.validate()) {
          final user = await _auth.creatnewaccount(
            _emailcontroller.text,
            _passwordcontroller.text,
            _usercontroller.text.trim(),
          );
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(StringManager.emailisalredylogin),
              ),
            );
          }
        }
      },
    );
  }

  Widget _RegisterPageLink() {
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
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
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
