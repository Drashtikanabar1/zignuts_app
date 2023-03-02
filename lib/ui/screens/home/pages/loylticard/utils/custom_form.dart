import 'package:firstapp/resources/colors_manager.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String hintext;
  final String label;
  final bool enabled;
  final  TextEditingController controller;
  final String? Function(String?)? validate;
   const CustomFormField({super.key,  required this.hintext, required this.label, required this.controller, this.validate, required this.enabled, });
  

  @override
  State<CustomFormField> createState() => _CustomFormField();
}

class _CustomFormField extends State<CustomFormField> {
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        autofocus: true,
        enabled:widget.enabled,
        decoration: InputDecoration(
          label: Text(widget.label),
          floatingLabelStyle: TextStyle(color: ColorManager.primary),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
