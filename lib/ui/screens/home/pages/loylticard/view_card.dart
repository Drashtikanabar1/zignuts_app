import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/model/loylti_card.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/card_description.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/new_card.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/user_preferences/user_preferences.dart';
import 'package:flutter/material.dart';

import '../../../../dialogs/dilogbox.dart';

class Cardgridview extends StatefulWidget {
  const Cardgridview({super.key});
  
  

  @override
  State<Cardgridview> createState() => _CardgridviewState();
}

class _CardgridviewState extends State<Cardgridview> {
  final Auth _auth = Auth();
 ScrollController _controller =ScrollController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: Dimensions.width8),
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        leadingWidth:Dimensions.width27,
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
            padding: EdgeInsets.only(right: Dimensions.width20),
            child: Icon(Icons.qr_code, color: ColorManager.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
          
       
          child: _cardgridview(),
      
      ), 
    );

  }

  Widget _cardgridview() {
    return  Padding(
        padding: EdgeInsets.only(left: Dimensions.width8,right: Dimensions.width20,),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("loylticrad")
                .doc(_auth.getUser()?.uid)
                .collection("userloylticard")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0) {
                  return _emptycard();
                } else {
                  return Container(
                    height: Dimensions.screenHeight,
                    child: GridView.builder(
                      controller: _controller,
                      itemCount: snapshot.data!.docs.length + 1,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == snapshot.data!.docs.length) {
                          return _emptycard();
                        } else {
                          DocumentSnapshot doc =
                              snapshot.data!.docs.elementAt(index);
                          doc.id;
                          return _customcard(
                             LoyltiCard(
                              backCardUrl: doc["backcardurl"],
                              cardName: doc["cardame"],
                              vendor: doc["vendor"],
                              frontCardUrl: doc["frontcardurl"],
                              name: doc["name"],
                              notes: doc["notes"],
                              websiteUrl: doc["websiteurl"],
                              id: doc.id,
                            ),
                            doc["name"],
                          );
                        }
                      },
                    ),
                  );
                }
              } else {
                return (_emptycard());
              }
            }),
      );
    
  }

  Widget _customcard(
 
    LoyltiCard loyltiCard,
    String title, 
  ) {
    return Stack(
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) =>
                          Detailscard(title: title))));
            },
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top:Dimensions.height20, left: Dimensions.width20),
                  child: Container(
                    height: Dimensions.height110,
                    width: Dimensions.width180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.cardcolour,
                      border: Border.all(
                        width: Dimensions.width5,
                        color: ColorManager.cardcolour,
                      ),
                    ),
                    child: Container(
                        height: Dimensions.height55,
                        width: Dimensions.width55,
                        child: Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: ColorManager.circleavtarcolour,
                            child: Text(
                                title.substring(0,1).toUpperCase(),),
                          ),
                        )),
                  ),
                ),
                Container(
                  padding:  EdgeInsets.only(top: Dimensions.height20),
                  child: Text(title),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: Dimensions.height20),
            child: PopupMenuButton(
              onSelected: (value) {
                // if value 1 show dialog
                if (value == 1) {
                  // final docuser = FirebaseFirestore.instance
                  //     .collection("loylticrad")
                  //     .doc(_auth.getUser()?.uid)
                  //     .collection("userlolticard")
                  //     .doc(loyltiCard.id)
                  //     .update();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Newloylticard(
                          editenable: true,
                          loyltiCard: loyltiCard,
                        ),
                      ));
                  // if value 2 show dialog
                } else if (value == 2) {

                  showDialog(context: context, builder: ((context) => Dilogbox.dialog(content: "Do you want to exit the App",context: context,
                  onYes:  () {
                     final docUser = FirebaseFirestore.instance
                      .collection("loylticrad")
                      .doc(_auth.getUser()?.uid)
                      .collection("userloylticard")
                      .doc(loyltiCard.id)
                      .delete();
                       Navigator.of(context).pop();
                  }
                  
                 
                 ,)));
                  
                }
              },
              itemBuilder: ((context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text("Edit"),
                    ),
                    PopupMenuItem(value: 2, child: Text("Delete")),
                  ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _emptycard() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => Newloylticard(
                    loyltiCard: LoyltiCard(
                        backCardUrl: "",
                        vendor: "",
                        cardName: "",
                        frontCardUrl: "",
                        name: "",
                        id: "",
                        notes: "",
                        websiteUrl: ""),
                  )),
            ),
          );
        },
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: Dimensions.height23, left:Dimensions.width20),
              child: DottedBorder(
                color: ColorManager.grey, //color of dotted/dash line
                strokeWidth: 3, //thickness of dash/dots
                dashPattern: [3, 4],
                child: Container(
                  height: Dimensions.height100,
                  width: Dimensions.width180,
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
