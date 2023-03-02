import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:flutter/material.dart';
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
                        ? SizedBox(
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
                                dashPattern: const [10, 6],
                                child: SizedBox(
                                    height: Dimensions.height70,
                                    width: Dimensions.width111,
                                    child: Image.asset(
                                      widget.defultimg,
                                      height: Dimensions.height80,
                                    )),
                              )
                            : SizedBox(
                                height: Dimensions.height73,
                                width: Dimensions.width124,
                                child: Image.file((widget.image!),
                                    fit: BoxFit.cover),
                              )),
              ),
              Padding(
                padding: EdgeInsets.only(top: Dimensions.height10),
                child: Row(
                  children:  [
                const Icon(Icons.add),
                Text(widget.title),
                  ],
                ),
              ),
            ],
          ),
        ),
      
      ],
    );
  }
}



