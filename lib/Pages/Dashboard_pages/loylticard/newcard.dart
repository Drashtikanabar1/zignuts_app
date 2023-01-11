


import 'package:dotted_border/dotted_border.dart';
import 'package:firstapp/Pages/Dashboard_pages/loylticard/custom_form.dart';
import 'package:firstapp/email.dart';
import 'package:firstapp/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../resources/colors_manager.dart';

class Newloylticard extends StatefulWidget {
  const Newloylticard({super.key});

  @override
  State<Newloylticard> createState() => _NewloylticardState();
}

class _NewloylticardState extends State<Newloylticard> {


  
  TextEditingController _cardcontroller = TextEditingController();
  TextEditingController _progoramcontroller = TextEditingController();
  TextEditingController _websiteurlcontroller = TextEditingController();
  TextEditingController _notescontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        
        title: Text(
          "New Card",
          style:
              TextStyle(color: ColorManager.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorManager.appbarColor,
        foregroundColor: ColorManager.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _text(),
            SizedBox(
              height: h * 0.04,
            ),
            _takeimage(),
             SizedBox(
              height: h * 0.03,
            ),
            _formdetails(),
             SizedBox(
              height: h * 0.03,
            ),
            _saveButton(h, w),
          ],
        ),
      ),
    );
  }

  Widget _text() {
    return Padding(
      padding: EdgeInsets.only(top: 28, right: 35, left: 33),
      child: Container(
        child: Text(
          "Scan your card barcode or QR code and enter the following info as you prefer to link it to your card ",
          style: TextStyle(
              fontSize: 14, color: ColorManager.lightblack, height: 1.5),
        ),
      ),
    );
  }

  Widget _takeimage() {
    
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Container(
                child: MaterialButton(
                  onPressed: () {},
                  child: DottedBorder(
                    color: ColorManager.grey, //color of dotted/dash line
                    strokeWidth: 3, //thickness of dash/dots
                    dashPattern: [10, 6],

                    child: Container(
                        height: 73,
                        width: 124,
                        child: Image.asset(
                          ImageAssets.card,
                          height: 80,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                    child: Row(
                  children: [
                    Container(
                      child: Icon(Icons.add),
                    ),
                    Container(
                      child: Text("Card front"),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              child: MaterialButton(
                onPressed: () {},
                child: DottedBorder(
                  color: ColorManager.grey, //color of dotted/dash line
                  strokeWidth: 3, //thickness of dash/dots
                  dashPattern: [10, 6],

                  child: Container(
                      height: 73,
                      width: 124,
                      child: Image.asset(
                        ImageAssets.backcard,
                        height: 80,
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Container(
                  child: Row(
                children: [
                  Container(
                    child: Icon(Icons.add),
                  ),
                  Container(
                    child: Text("Card back"),
                  ),
                ],
              )),
            ),
          ],
        ),
      ],
    );
  }


    Widget _formdetails(){
      return Container(
       child: Column(children: [
        CustomFormField(hintext:"Card Number" , label: "Card Number", ),
       
        SizedBox(height: 15,),
        CustomFormField(hintext: "Program name", label: "Program name", ),
        SizedBox(height: 15,),
        CustomFormField(hintext: "Website url", label: "Website Url", ),
        SizedBox(height: 15,),


       _notes(),
       ]),
      );
    }
Widget _notes(){
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      
      width: width * 0.9,
      height:80,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: 3,
        autofocus: true,
        decoration: InputDecoration(
          
          label: Text("Notes"),
          floatingLabelStyle: TextStyle(color: ColorManager.primary),
          hintText: "Notes",
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
       
      ),
    );
}
    Widget _saveButton(h,w){
      return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: (){

      },
      minWidth: w * 0.9,
      height: 50,
      color: ColorManager.primary,
      child: const Text(
        "save ",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
    }
}
