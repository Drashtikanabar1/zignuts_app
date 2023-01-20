import 'package:firstapp/resources/colors_manager.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  
  final String hintext;
  final String label;
  final bool enabled;
  final  TextEditingController controller;
  final String? Function(String?)? validate;
  
 
  

   CustomFormField({super.key,  required this.hintext, required this.label, required this.controller, this.validate, required this.enabled, });
  

  @override
  State<CustomFormField> createState() => _emailState();
}



class _emailState extends State<CustomFormField> {
  
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    
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
// class Formsection extends StatefulWidget {
//   const Formsection({super.key});

//   @override
//   State<Formsection> createState() => _FormsectionState();
// }

// class _FormsectionState extends State<Formsection> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }



//   Widget selectvendor({
//     required List list,
//     required Function(dynamic) onChanged,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 15),
//       child: DropdownButtonFormField(
//         hint: Text("select vandor"),
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         validator: (value) {
//           if (value == "" || list.indexOf(value) == -1) {
//             return "Remaining to select vendor";
//           }
//         },
//         focusNode: FocusNode(descendantsAreTraversable: true),
//         style: TextStyle(color: ColorManager.grey, fontSize: 16),
//         decoration: InputDecoration(
//           floatingLabelStyle: TextStyle(color: ColorManager.black),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//           hintText: "Select vendor",
         
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(
//                 10,
//               ),
//               borderSide: BorderSide(
//                 color: ColorManager.grey,
//               )),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(
//                 10,
//               ),
//               borderSide: BorderSide(
//                 color: ColorManager.primary,
//               )),
//           fillColor: Colors.grey.shade100,
//           filled: true,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(
//               10,
//             ),
//           ),
//         ),
//         items: list.map<DropdownMenuItem>((value) {
//           return DropdownMenuItem(
//             value: value,
//             child: Text(
//               value,
//               style: TextStyle(color: Colors.black),
//             ),
//           );
//         }).toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }
// }
