// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/ui/screens/home/pages/categories/categories_screen.dart';

import 'package:firstapp/ui/screens/home/pages/dashboard/change_password.dart';
import 'package:firstapp/ui/dialogs/dilogbox.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/resources/statics_manager.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth  _auth = Auth();
  int _currentindex=1;
  User? currentUser =null;

@override
  void initState() {
    currentUser =_auth.getUser();
    super.initState();
  }
  
  static List<Widget> _widgetList =[ 
    Center(child:Text(StringManager.listcontent)),
    Center(child:Text(StringManager.vendorcontent)),
    Center(child:Text(StringManager.homecontent)),
    Categories(),
     Center(child: Text(StringManager.morecontent)),


  ];

  void _onItemTapped(int index) {  
    setState(() {  
      _currentindex = index;  
    });  
  } 
  @override
  Widget build(BuildContext context) {
   
    return  Scaffold(
      // appBar: AppBar(
      //   title: Text(""),
      //   backgroundColor: Colors.green,
      // ),
       body: Center(
          child: _widgetList.elementAt(_currentindex),
        
       ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: const EdgeInsets.all(0),
      //     children: [
      //        DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Colors.green,
      //         ), //BoxDecoration
      //         child: UserAccountsDrawerHeader(
      //           decoration: BoxDecoration(color: Colors.green),
      //           accountName: Text(
      //             currentUser!.displayName ?? "not found",
      //             style: TextStyle(fontSize: 18),
      //           ),
      //           accountEmail: Text(currentUser!.email ?? "not found"),
      //           currentAccountPictureSize: Size.square(50),
      //           currentAccountPicture: CircleAvatar(
      //             backgroundColor: Color.fromARGB(255, 165, 255, 137),
      //             child: Text(
      //               currentUser!.displayName!.substring(0,1).toUpperCase(),
      //               style: TextStyle(fontSize: 30.0, color: Colors.blue),
      //             ), //Text
      //           ), //circleAvatar
      //         ), //UserAccountDrawerHeader
      //       ), //DrawerHeader
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text('Payment Method'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.book),
      //         title: const Text('Addressses '),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.workspace_premium),
      //         title: const Text('password '),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.video_label),
      //         title: const Text(' Household  '),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.edit),
      //         title: const Text(' change password'),
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const ChangePassword()),
      //           );
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.logout),
      //         title: const Text('LogOut'),
      //         onTap: () async{
                
      //          showDialog(context: context, builder: ((context) => Dilogbox().dialog(context)));
      //         } ,
              
      //       )
      //     ],
      //   ),
      // ), //Drawer
       bottomNavigationBar: BottomNavigationBar(  
        items:  <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
           icon: Icon(Icons.list),  
            label: "Lists",
              backgroundColor: ColorManager.primary,
        
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.person),  
            label: "vendors",
          
            backgroundColor: ColorManager.primary,
         
          ),  
          BottomNavigationBarItem(  
              icon: Icon(Icons.home),  
            label: "Home", 
           
              backgroundColor: ColorManager.primary,
          
          ), 
           BottomNavigationBarItem(  
            icon: Icon(Icons.category_outlined),  
            label: "categories",
              backgroundColor: ColorManager.primary,
          
          ), 
           BottomNavigationBarItem(  
            icon: Icon(Icons.more),  
            label: "More",
              backgroundColor: ColorManager.primary,
           
          ),  
        ],
           type: BottomNavigationBarType.shifting,  
        currentIndex: _currentindex,  
        selectedItemColor: Colors.black,  
        iconSize: 40,  
        onTap: _onItemTapped,  
        elevation: 5  
       ),  
    );
  }
}