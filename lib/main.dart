
import 'package:firstapp/Dashboard.dart';
import 'package:firstapp/auth_database.dart';
import 'package:firstapp/loginscreen.dart';
import 'package:firstapp/signupfile.dart';
import 'package:firstapp/splachscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        
      },
    );
  }
}

