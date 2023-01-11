import 'package:firstapp/resources/colors_manager.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class email extends StatefulWidget {
  
  final String hintext;
  final String label;
   final TextEditingController controller;
  final String? Function(String?)? validate;
  
 
  

   email({super.key,  required this.hintext, required this.label, required this.controller, this.validate, });
  

  @override
  State<email> createState() => _emailState();
}

class _emailState extends State<email> {
  
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 10,
          offset: const Offset(
            1,
            1,
          ),
          color: Colors.grey.withOpacity(0.5),
        ),
      ]),
      width: width * 0.8,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        autofocus: true,
        decoration: InputDecoration(
          label: Text(widget.label),
          floatingLabelStyle: TextStyle(color: ColorManager.primary),
          hintText: widget.hintext,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: const BorderSide(
                color: Colors.white,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
              borderSide: BorderSide(
                color: ColorManager.primary,
              )),
          fillColor: Colors.grey.shade100,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
        ),
        validator: widget.validate,
      ),
    );
  }
   
  }
