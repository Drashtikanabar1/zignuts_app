import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';

class CustomButton extends StatefulWidget {
  final String text;
  Function() onPressed;
   CustomButton({super.key, required this.text, required this.onPressed, required });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
   final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: widget.onPressed,
      minWidth: Dimensions.width314,
      height: Dimensions.height46,
      color: ColorManager.primary,
      child:  Text(
        widget.text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}