import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/resources/string_manager.dart';
import 'package:firstapp/ui/screens/home/pages/change_theme.dart';
import 'package:firstapp/ui/screens/home/pages/changelanguage_screen.dart';
import 'package:firstapp/ui/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import '../../../../authentication/auth_database.dart';
import '../../../dialogs/dilogbox.dart';
import 'homepage/change_password.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Auth  _auth = Auth();
 
  User? currentUser;
  @override
  void initState() {
    currentUser =_auth.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text(" "),
        backgroundColor: Colors.green,
      ),
      body:const Center(
          child: Text(
        StringManager.homecontent,
        style: TextStyle(fontSize: 20.0),
      )),
     drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
             DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.green),
                accountName: Text(
                  currentUser!.displayName ?? StringManager.notfond,
                  style: const TextStyle(fontSize: 18),
                ),
                accountEmail: Text(currentUser!.email ?? StringManager.notfond),
                currentAccountPictureSize: const Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    currentUser!.displayName!.substring(0,1).toUpperCase(),
                    style: const TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Payment Method'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Addressses '),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeTheme(),));
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text(StringManager.passwordhintext),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_label),
              title: const Text('Change Language'),
              onTap: () {
              Navigator.pushNamed(context, LanguageScreen.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(StringManager.changePassword),
              onTap: () {
                Navigator.pushNamed(
                  context,
                 ChangePassword.id,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () async{
                
             showDialog(context: context, builder: ((context) => Dilogbox.dialog(content: "Do you want to exit the App",context: context,onYes:  () async{
                  if(FirebaseAuth.instance.currentUser != null)
                   {
                     await _auth.sigOut();
                   }
                   
                     Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id,(route) => false,);
              
                },)));
              } ,
              
            )
          ],
        ),
      ),


    );
  }
}