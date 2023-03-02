
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/bloc/network_cubit.dart';
import 'package:firstapp/controller/random_provider.dart';
import 'package:firstapp/response/customer_randomuser.dart';
import 'package:firstapp/ui/screens/home/pages/articles/article_screen.dart';
import 'package:firstapp/ui/screens/home/pages/categories/categories_screen.dart';
import 'package:firstapp/ui/screens/home/pages/dashboard.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/ui/screens/home/pages/userdetails/list.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/view_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = 'HomePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 ModelCustomrRequest? user;
   bool isUser=false;
  void randomuser()async{
    isUser =true;
    ModelCustomrResponse result = await randomProvider!.getRandomuser();
    
     
    if(isUser){
setState(() {
       user = result.results?.first;
     });
    
    }
  }
   RandomProvider? randomProvider;
  final Auth _auth = Auth();
  int _currentindex = 1;

  User? currentUser;

  @override
  void initState() {
    currentUser = _auth.getUser();
    
    super.initState();
  }

   final List<Widget> _widgetList = [
    const Dashboard(),
    const ListScreen(),
    const ArticleScreen(),
    const Categories(),
    const Cardgridview(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     randomProvider = Provider.of<RandomProvider>(context);
    randomProvider!.networkCubit ??= BlocProvider.of<NetworkCubit>(context);
    if(!isUser){
randomuser();
    }
    

    return Scaffold(
    
      body: Container(child: _widgetList.elementAt(_currentindex)),
            bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: "Home",
              backgroundColor: ColorManager.primary,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.list),
              label: "List",
              backgroundColor: ColorManager.primary,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: "vendors",
              backgroundColor: ColorManager.primary,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.category_outlined),
              label: "categories",
              backgroundColor: ColorManager.primary,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.more),
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
