import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/model/loylti_card.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/card_description.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/new_card.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/utilies/custom_card.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/utilies/empty_card.dart';
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
  ScrollController _controller = ScrollController();
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
        leadingWidth: Dimensions.width27,
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
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.width8,
        right: Dimensions.width20,
      ),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("loylticrad")
              .doc(_auth.getUser()?.uid)
              .collection("userloylticard")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.length == 0) {
                return EmptyCard();
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
                        return EmptyCard();
                      } else {
                        DocumentSnapshot doc =
                            snapshot.data!.docs.elementAt(index);
                        doc.id;
                        return CustomCard(
                         loyltiCard: LoyltiCard(
                            backCardUrl: doc["backcardurl"],
                            cardName: doc["cardame"],
                            vendor: doc["vendor"],
                            frontCardUrl: doc["frontcardurl"],
                            name: doc["name"],
                            notes: doc["notes"],
                            websiteUrl: doc["websiteurl"],
                            id: doc.id,
                          ),
                          title:doc["name"],
                        );
                      }
                    },
                  ),
                );
              }
            } else {
              return (EmptyCard());
            }
          }),
    );
  }

 
}
