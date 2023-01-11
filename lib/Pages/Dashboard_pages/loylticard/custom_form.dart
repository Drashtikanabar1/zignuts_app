import 'package:firstapp/resources/colors_manager.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  
  final String hintext;
  final String label;
   
  final String? Function(String?)? validate;
  
 
  

   CustomFormField({super.key,  required this.hintext, required this.label,this.validate, });
  

  @override
  State<CustomFormField> createState() => _emailState();
}

class _emailState extends State<CustomFormField> {
  
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      
      width: width * 0.9,
      height:50,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        
        autofocus: true,
        decoration: InputDecoration(
          label: Text(widget.label),
          floatingLabelStyle: TextStyle(color: ColorManager.primary),
          hintText: widget.hintext,
          enabledBorder: OutlineInputBorder(
          
              borderRadius: BorderRadius.circular(

                10,
              ),
              borderSide: BorderSide(
                color: ColorManager.grey,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
              borderSide: BorderSide(
                color: ColorManager.primary,
              )),
          fillColor: Colors.grey.shade100,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
        ),
        validator: widget.validate,
      ),
    );
  }
   
  }
