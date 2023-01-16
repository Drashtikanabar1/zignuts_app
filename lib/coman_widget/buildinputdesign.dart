import 'package:firstapp/resources/colors_manager.dart';

import 'package:flutter/material.dart';

class BuildInputBox extends StatefulWidget {
  
  final String hintext;
  final String label;
   final TextEditingController controller;
  final String? Function(String?)? validate;
  
 
  

   const BuildInputBox({super.key,  required this.hintext, required this.label, required this.controller, this.validate, });
  

  @override
  State<BuildInputBox> createState() => BuildInputBoxState();
}

class BuildInputBoxState extends State<BuildInputBox> {
  
  @override
  Widget build(BuildContext context) {
  
 
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
