
import 'package:firstapp/Authentication/goole_sign_in.dart';
import 'package:firstapp/ui/screens/home/pages/categories/categories_screen.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/view_card.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/new_card.dart';
import 'package:firstapp/ui/screens/home/pages/dashboard/dashboard.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/ui/screens/home/pages/dashboard/change_password.dart';
import 'package:firstapp/ui/screens/login/login_screen.dart';


import 'package:firstapp/ui/screens/signup/signup_screen.dart';
import 'package:firstapp/ui/screens/splash/splach_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>ChangeNotifierProvider(create :(context)=>GoogleSignInProvider(),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
       initialRoute: 'card',
      routes: {
        'splash': (context) => SplashScreen(),
        'register': (context) => RegisterScreen(),
        'login': (context) => LoginScreen(),
        'home':(context) => HomePage(),
        'changepassword':(context)=>ChangePassword(),
        'categories':(context) => Categories(),
        'newcard':(context) => Newloylticard(),
        'card':(context) => Cardgridview(),
        
      },
    )
    );
  }


