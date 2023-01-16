import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/model/loylti_card.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/card_description.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/new_card.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:flutter/material.dart';

class Cardgridview extends StatefulWidget {
  const Cardgridview({super.key});

  @override
  State<Cardgridview> createState() => _CardgridviewState();
}

class _CardgridviewState extends State<Cardgridview> {
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: w * 0.02),
          child: const Icon(
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
          _cardgridview(h, w),
        ],
      )),
    );
  }

  Widget _cardgridview(h, w) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 20),
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
                  height: h,
                  child: GridView.builder(
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
                        return _customcard(LoyltiCard(backCardUrl: doc["backcardurl"],cardName: doc["cardame"],frontCardUrl: doc["frontcardurl"],name: doc["name"],notes: doc["notes"],websiteUrl: doc["websiteurl"],id: doc.id));
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
  ) {
    return Stack(
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => Detailscard(title: loyltiCard.name!))));
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
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
                            child: Text(loyltiCard.name!.substring(0, 1).toUpperCase()),
                          ),
                        )),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(loyltiCard.name!),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Newloylticard(
                        loyltiCard: loyltiCard ,
                      ),));
                  // if value 2 show dialog
                } else if (value == 2) {
                  final docUser = FirebaseFirestore.instance
                      .collection("loylticrad")
                      .doc(_auth.getUser()?.uid)
                      .collection("userloylticard")
                      .doc(loyltiCard.id)
                      .delete();
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
              builder: ((context) =>  Newloylticard()),
            ),
          );
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 22, left: 20),
              child: DottedBorder(
                color: ColorManager.grey, //color of dotted/dash line
                strokeWidth: 3, //thickness of dash/dots
                dashPattern: [3, 4],
                child: Container(
                  height: 90,
                  width: 180,
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
