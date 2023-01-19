import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/model/loylti_card.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/ui/dialogs/dilogbox.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/card_description.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/new_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../../authentication/auth_database.dart';
import '../../../../../../resources/colors_manager.dart';

class CustomCard extends StatefulWidget {
  LoyltiCard loyltiCard;
   final  String title;
   CustomCard({super.key, required this.title,required this.loyltiCard});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  final Auth _auth = Auth();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => Detailscard(title: widget.title))));
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20, left: Dimensions.width20),
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
                              widget.title.substring(0, 1).toUpperCase(),
                            ),
                          ),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20),
                  child: Text(widget.title),
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
                if (value == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Newloylticard(
                          editenable: true,
                          loyltiCard: widget.loyltiCard,
                        ),
                      ));
                } else if (value == 2) {
                  showDialog(
                      context: context,
                      builder: ((context) => Dilogbox.dialog(
                            content: "Do you want to exit the App",
                            context: context,
                            onYes: () {
                              final docUser = FirebaseFirestore.instance
                                  .collection("loylticrad")
                                  .doc(_auth.getUser()?.uid)
                                  .collection("userloylticard")
                                  .doc(widget.loyltiCard.id)
                                  .delete();
                              Navigator.of(context).pop();
                            },
                          )));
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
}