import 'package:colours/colours.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../resources/colors_manager.dart';

class CommonText extends StatelessWidget {
  final String title;
  final String subtitle;
   CommonText({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: Colours.lavender,
                offset: const Offset(
                  2.0,
                  3.0,
                )),
          ]),
      width: Dimensions.screenWidth,
      height: Dimensions.height156,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: Dimensions.width23),
            child: Text(
             title,
              style: TextStyle(fontSize: 30, color: ColorManager.primary),
            ),
          ),
          SizedBox(
            height: Dimensions.height12,
          ),
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width23,
            ),
            child:  Text(
              subtitle,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}