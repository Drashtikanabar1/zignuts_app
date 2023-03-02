


import 'package:firstapp/ui/screens/home/pages/changelanguage_screen.dart';
import 'package:firstapp/ui/screens/home/pages/homepage/change_password.dart';
import 'package:firstapp/ui/screens/home/pages/homepage/homepage.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/add_card.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/card_description.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/view_card.dart';
import 'package:firstapp/ui/screens/login/reset_screen.dart';
import 'package:firstapp/ui/screens/signup/signup_screen.dart';
import 'package:firstapp/ui/screens/splash/splach_screen.dart';
import 'package:flutter/material.dart';

import '../ui/screens/login/login_screen.dart';

final Map<String, WidgetBuilder> routes = {
  
  SplashScreen.id:(context) => const SplashScreen(),
  LoginScreen.id: (context) => const LoginScreen(),
  RegisterScreen.id:(context) => const RegisterScreen(),
  HomePage.id:(context) => const HomePage(),
  ResetPasswordScreen.id:(context) => const ResetPasswordScreen(),
  ChangePassword.id :(context) => const ChangePassword(),
  Cardgridview.id:(context) => const Cardgridview(),
  Addloylticard.id:(context) =>  Addloylticard(),
  Detailscard.id :(context) => Detailscard(),
  LanguageScreen.id:((context) => LanguageScreen()),

};