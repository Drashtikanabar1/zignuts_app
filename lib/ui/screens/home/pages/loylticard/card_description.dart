import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/utils/addLoyltiCard_aregument.dart';
import 'package:flutter/material.dart';


class Detailscard extends StatefulWidget {
  
  const Detailscard({super.key, });
static const String id = 'Detailscard';
  @override
  State<Detailscard> createState() => _DetailscardState();
}

class _DetailscardState extends State<Detailscard> {
  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)!.settings.arguments as AddloylticardArguments;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: Dimensions.width27,
        title: Text(
          "Card Details",
          style:
              TextStyle(color: ColorManager.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorManager.appbarColor,
        foregroundColor: ColorManager.black,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _customcard(args),
          SizedBox(
            height:Dimensions.height23,
          ),
          _details(args),
        ],
      )),
    );
  }

  Widget _customcard(args) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20),
              child: Container(
                height: Dimensions.height220,
                width: Dimensions.width350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.cardcolour,
                  border: Border.all(
                    width: Dimensions.width5,
                    color: ColorManager.cardcolour,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height110,
                        width: Dimensions.width111,
                        child: Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: ColorManager.circleavtarcolour,
                            child: Text(
                             args.loyltiCard.name.substring(0,1).toUpperCase(),
                              style: TextStyle(
                                  fontSize: 41, color: ColorManager.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: Dimensions.height20),
                        child: Text(args.loyltiCard.name),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: Dimensions.height25, right: Dimensions.width25),
              child: const Icon(
                Icons.more_vert,
              ),
            ))
      ],
    );
  }

  Widget _details(args) {
    return Padding(
      padding: EdgeInsets.only(left:Dimensions.width20,right:Dimensions.width20),
      child: SizedBox(
      height:Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        child: Column(
          children: [
            Center(
              child: SizedBox(
               width: Dimensions.screenWidth,
                  child: const Text("Lorem Ipsum"),
              ),
            ),
            Container(
              width: Dimensions.screenWidth,
              padding: EdgeInsets.only(top: Dimensions.height2),
              child:    const Text("Member ID : JC65456465464"),
            ),
            Container(
              padding: EdgeInsets.only(top:Dimensions.height23),
              child:  Row(
              children: [const Icon(Icons.alarm_rounded), Text(args.loyltiCard.name)],
              ),
           
            ),
           Container(
            padding: EdgeInsets.only(top: Dimensions.height2),
            child: const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),) 
          ],
        ),
      ),
    );
  }
}
