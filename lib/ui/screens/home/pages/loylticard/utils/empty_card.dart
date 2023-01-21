import 'package:dotted_border/dotted_border.dart';
import 'package:firstapp/model/loylti_card.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/add_card.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/utils/addLoyltiCard_aregument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../resources/colors_manager.dart';
import '../../../../../../resources/style_manager.dart';

class EmptyCard extends StatefulWidget {
  const EmptyCard({super.key});

  @override
  State<EmptyCard> createState() => _EmptyCardState();
}

class _EmptyCardState extends State<EmptyCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,Addloylticard.id,arguments:AddloylticardArguments(loyltiCard: LoyltiCard(
                        backCardUrl: "",
                        vendor: "",
                        cardName: "",
                        frontCardUrl: "",
                        name: "",
                        id: "",
                        notes: "",
                        websiteUrl: ""),
                    ) ,
            );
          
        },
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(top: Dimensions.height23, ),
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
