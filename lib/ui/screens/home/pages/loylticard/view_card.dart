

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/card_description.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/new_card.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Cardgridview extends StatefulWidget {
  const Cardgridview({super.key});

  @override
  State<Cardgridview> createState() => _CardgridviewState();
}

class _CardgridviewState extends State<Cardgridview> {
 final Auth  _auth = Auth();
  FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;
  Stream<DocumentSnapshot<Map<String, dynamic>>> LoyaltyCardsDisplay() {
    return _firebaseFirestore
        .collection("loylticrad")
        .doc(_auth.getUser()?.uid)
        .snapshots();
  }
  List list=["vender","drashti"];
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: w * 0.02),
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        leadingWidth: w * 0.07,
        title: Text(
          "New Card",
          style:
              TextStyle(color: ColorManager.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorManager.appbarColor,
        foregroundColor: ColorManager.black,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: w * 0.04),
            child: Icon(Icons.search, color: ColorManager.black),
          ),
          Padding(
            padding: EdgeInsets.only(right: w * 0.05),
            child: Icon(Icons.qr_code, color: ColorManager.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _cardgridview(h,w),
        ],
      )),
    );
  }

  Widget _cardgridview(h,w) {
    // return  Padding(
    //   padding:  EdgeInsets.only(left: 8,right: 20),
    //    child: StreamBuilder(
        
    //   stream:LoyaltyCardsDisplay(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       List _posts = snapshot.data!.get("loylticrad");
    //        return  
      return Container( 
           
            height: h,
            child: GridView.builder(
              itemCount: list.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0,),
              itemBuilder: (BuildContext context, int index) {
          
                if(index == list.length){
                   return _emptycard();
                } 
                return _customcard( list[index],context);
               
              },
            ),
      );
      
 
      
    
  }
 
  Widget _customcard(
    String title,
    context,
  ) {
    return Stack(
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => Detailscard(title: title))));
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: Container(
                    height: 110,
                    width: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.cardcolour,
                      border: Border.all(
                        width: 5,
                        color: ColorManager.cardcolour,
                      ),
                    ),
                    child: Container(
                        height: 55,
                        width: 55,
                        child: Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: ColorManager.circleavtarcolour,
                            child: Text(title.substring(0, 1).toUpperCase()),
                          ),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(title),
                )
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 25),
              child: Icon(
                Icons.more_vert,
              ),
            ))
      ],
    );
  }
  Widget _emptycard(){
    return  Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) => Newloylticard()),),);
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 22, left: 20),
                  child: DottedBorder(
                    color: ColorManager.grey, //color of dotted/dash line
                  strokeWidth: 3, //thickness of dash/dots
                  dashPattern: [3, 4],
                    child: Container(
                      height: 90,
                      width: 180,
                     child: Icon(Icons.add),
                     
                    
                    
                      
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        );
  }
}
