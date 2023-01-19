import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = Colors.green;
  static Color appbarColor =HexColor.fromHex("#FFFFFF");
  static Color black =HexColor.fromHex("#000000");
  static Color green =HexColor.fromHex("#1E8040");
  static Color lightgreen =HexColor.fromHex("#E5EDE7");
  static Color white =HexColor.fromHex("#FFFFFF");
  static Color grey =HexColor.fromHex("#B4B4B4");
  static Color lightblack =HexColor.fromHex("#333333");
  static Color cardcolour =HexColor.fromHex("#CAE7EB");
  static Color circleavtarcolour =HexColor.fromHex("#70A1A8");
  static Color lightgrey =HexColor.fromHex(" #E5E4D7");
  static Color lightGreenAccent =HexColor.fromHex("#E8FEBE");


 

  
  
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF' + hexColorString; // 8 Char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
