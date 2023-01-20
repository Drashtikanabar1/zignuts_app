import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firstapp/model/loylti_card.dart';

import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/utils/select_photo_option.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';



import '../../../../../../resources/assets_manager.dart';
import '../../../../../../resources/style_manager.dart';

class TakeImage extends StatefulWidget {
  final String title;
  File? image;
  final String url;
  final Function() onPressed;
  final String defultimg;
   final bool enabled ;

  TakeImage({
    super.key,
    required this.image,
    required this.onPressed,
    required this.url,
    required this.defultimg,
    required this.title, required this.enabled,
  });

  @override
  State<TakeImage> createState() => _TakeImageState();
}

class _TakeImageState extends State<TakeImage> {
  bool isFrnotSide = false;
 
 
 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: Dimensions.width35),
          child: Column(
            children: [
              MaterialButton(
                onPressed: widget.enabled ? widget.onPressed : null,
                child: Center(
                    child: widget.url != ""
                        ? Container(
                            height: Dimensions.height73,
                            width: Dimensions.width124,
                            child: Image.network(
                              widget.url,
                              fit: BoxFit.cover,
                            ))
                        : widget.image == null
                            ? DottedBorder(
                                color: ColorManager
                                    .grey, //color of dotted/dash line
                                strokeWidth:
                                    Dimensions.width3, //thickness of dash/dots
                                dashPattern: [10, 6],
                                child: Container(
                                    height: Dimensions.height73,
                                    width: Dimensions.width124,
                                    child: Image.asset(
                                      widget.defultimg,
                                      height: Dimensions.height80,
                                    )),
                              )
                            : Container(
                                height: Dimensions.height73,
                                width: Dimensions.width124,
                                child: Image.file((widget.image!),
                                    fit: BoxFit.cover),
                              )),
              ),
              Padding(
                padding: EdgeInsets.only(top: Dimensions.height10),
                child: Container(
                    child: Row(
                  children:  [
                    Icon(Icons.add),
                    Text(widget.title),
                  ],
                )),
              ),
            ],
          ),
        ),
      
      ],
    );
  }
}



