// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/ui/screens/home/pages/categories/categories_screen.dart';
import 'package:firstapp/ui/screens/home/pages/dashboard.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/resources/string_manager.dart';

import 'package:firstapp/ui/screens/home/pages/loylticard/view_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = 'HomePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth _auth = Auth();
  int _currentindex = 1;
  User? currentUser = null;

  @override
  void initState() {
    currentUser = _auth.getUser();
    super.initState();
  }

  static List<Widget> _widgetList = [
    Dashboard(),
    Center(child: Text(StringManager.listcontent)),
    Center(child: Text(StringManager.vendorcontent)),
    Categories(),
    Cardgridview(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Center(
        child: _widgetList.elementAt(_currentindex),
      ),

      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: ColorManager.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "List",
              backgroundColor: ColorManager.primary,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "vendors",
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
          elevation: 5),
    );
  }
}
