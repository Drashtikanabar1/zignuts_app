
import 'package:firstapp/Authentication/goole_sign_in.dart';
import 'package:firstapp/dashboard.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/change_password.dart';
import 'package:firstapp/loginscreen.dart';
import 'package:firstapp/signupfile.dart';
import 'package:firstapp/splachscreen.dart';
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
       initialRoute: 'splash',
      routes: {
        'splash': (context) => splashscreen(),
        'register': (context) => signuppage(),
        'login': (context) => loginscreen(),
        'home':(context) => HomePage(),
        'changepassword':(context)=>ChangePassword(),
        
      },
    )
    );
  }


