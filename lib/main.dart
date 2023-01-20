
import 'package:firstapp/Authentication/goole_sign_in.dart';
import 'package:firstapp/resources/route_manager.dart';
import 'package:firstapp/ui/screens/splash/splach_screen.dart';



import 'package:flutter/material.dart';

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
    child: GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
       home: const SplashScreen(),
      routes:routes,
      //  {
      //   'splash': (context) => SplashScreen(),
      //   'register': (context) => RegisterScreen(),
      //   'login': (context) => LoginScreen(),
      //   'home':(context) => HomePage(),
      //   'changepassword':(context)=>ChangePassword(),
      //   'categories':(context) => Categories(),
        
      //   'card':(context) => Cardgridview(),
        
      // },
    )
    );
  }


