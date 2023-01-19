
import 'package:firstapp/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../resources/colors_manager.dart';

class listview extends StatefulWidget {
  const listview({super.key});

  @override
  State<listview> createState() => _listviewState();
}

class _listviewState extends State<listview> {
  List list=[
    "home","tesco"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Padding(
          padding: EdgeInsets.only(left: Dimensions.width8),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        leadingWidth:Dimensions.width23,
        title: Text(
          "New Card",
          style:
              TextStyle(color: ColorManager.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorManager.appbarColor,
        foregroundColor: ColorManager.black,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Dimensions.width15),
            child: Icon(Icons.search, color: ColorManager.black),
          ),
          Padding(
            padding: EdgeInsets.only(right:Dimensions.width15),
            child: Icon(Icons.qr_code, color: ColorManager.black),
          ),
        ],),
      body: Container(
        child: ListView.builder(
          itemCount:list.length,
          itemBuilder:(context, index) {
            return  customlist(list[index]);
          }
          ) ,
        
      ),
    );
  }

  Widget customlist( String title){
   
    return Padding(

              padding: EdgeInsets.only(left: 20,right: 20,top: 11),
              child: Container(
              decoration: BoxDecoration(border: Border.all(color: ColorManager.grey),borderRadius: BorderRadius.all(Radius.circular(20)),  ),
              width: 335,
              height: 90,
         
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                  padding: EdgeInsets.only(left: 20,bottom: 27),
                  child: Text(title),),
                  Container(
                    width: 71,
                    height: 90,
                    decoration: BoxDecoration(color:ColorManager.lightGreenAccent,borderRadius:BorderRadius.only(bottomRight:Radius.circular(20),topRight: Radius.circular(20))) ),
                   
                  
                ],
              ),
              ),
            );
  }
}