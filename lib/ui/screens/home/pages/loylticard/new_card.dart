import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Authentication/auth_database.dart';
import 'package:firstapp/model/loylti_card.dart';
import 'package:firstapp/services/save_database.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/custom_form.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/select_photo_option.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firstapp/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../resources/colors_manager.dart';

class Newloylticard extends StatefulWidget {
  const Newloylticard({super.key});

  @override
  State<Newloylticard> createState() => _NewloylticardState();
}

class _NewloylticardState extends State<Newloylticard> {
  File? _image;
  File? _image1;
  bool isFrnotSide = false;
  bool _isLoading =false;

  
   
   final TextEditingController _cardnocontroller = TextEditingController();
  TextEditingController _cardnamecontroller = TextEditingController();
   TextEditingController _websiteurlcontroller = TextEditingController();
  TextEditingController _notescontroller = TextEditingController();
  StorageService _storageService = StorageService();
    final cardnoValidator = MultiValidator([
    RequiredValidator(errorText: "card no is required"),
   
  ]);
  final nameValidator = MultiValidator([
    RequiredValidator(errorText: "name is requried"),
    
  ]);
  final websiteurlValidator = MultiValidator([
   RequiredValidator(errorText: "website url is requried"),
  
  ]);
   final notesValidator = MultiValidator([
   RequiredValidator(errorText:"notes is requried"),
  
  ]);

  final GlobalKey<FormState> _cardFormKey = GlobalKey<FormState>();
   final Auth _auth = Auth();

 


 void _submitForm() async {
 
    final isValid = _cardFormKey.currentState!.validate();
   
    
    if (isValid) {
      _cardFormKey.currentState!.save();
      try {
        if (_image == null || _image1==null) {
       return  print ('Please pick an image');
        } else {
          setState(() {
            _isLoading = true;
          });
         
          final url=await _storageService.saveCardImages(_image!,_image1!);
          await FirebaseFirestore.instance.collection('loylticrad').doc(_auth.getUser()?.uid).set({ "usercards" :FieldValue.arrayUnion([{ 'cardame' :_cardnamecontroller.text,
              'name' :_cardnamecontroller.text,
              'websiteurl':_websiteurlcontroller.text,
              'notes':_notescontroller.text,
              'frontcardurl':url[0],
              'backcardurl':url[1],}])
             
          });
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        } 
      } catch (error) {
       
         print('error occured : $error');
      } finally {
       if(mounted){
         setState(() {
          _isLoading = false;
        });
       }
      }
    }
  }
  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      if (isFrnotSide) {
        setState(() {
          _image = img;
          Navigator.of(context).pop();
        });
      } else {
        setState(() {
          _image1 = img;
          //Navigator.of(context).pop();
        });
      }
    } on PlatformException catch (e) {
      print('error is $e');
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(onTap: _pickImage),
            );
          }),
    );
  }

  
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
                  onPressed: () {
                    setState(() {
                      isFrnotSide = true;
                    });
                    _showSelectPhotoOptions(context);
                  },
                  child: Center(
                      child: _image == null
                          ? DottedBorder(
                              color:
                                  ColorManager.grey, //color of dotted/dash line
                              strokeWidth: 3, //thickness of dash/dots
                              dashPattern: [10, 6],
                              child: Container(
                                  height: 73,
                                  width: 124,
                                  child: Image.asset(
                                    ImageAssets.card,
                                    height: 80,
                                  )),
                            )
                          : Container(
                              height: 73,
                              width: 124,
                              child: Image.file((_image!), fit: BoxFit.cover),
                            )),
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
                  onPressed: () {
                    setState(() {
                      isFrnotSide = false;
                    });
                    _showSelectPhotoOptions(context);
                  },
                  child: _image1 == null
                      ? DottedBorder(
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
                        )
                      : Container(
                          height: 73,
                          width: 124,
                          child: Image.file((_image1!), fit: BoxFit.cover),
                        )),
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


  Widget _formdetails() {
    return Container(
      child: Form(
        key: _cardFormKey,
        child: Column(children: [
          CustomFormField(
            hintext: "Card Number",
            label: "Card Number",
            controller: _cardnocontroller,
            validate: cardnoValidator,
          ),
          SizedBox(
            height: 15,
          ),
          CustomFormField(
            hintext: "Program name",
            label: "Program name",
            controller: _cardnamecontroller,
            validate: nameValidator,
          ),
          SizedBox(
            height: 15,
          ),
          CustomFormField(
            hintext: "Website url",
            label: "Website Url",
            controller: _websiteurlcontroller,
            validate: websiteurlValidator,
          ),
          SizedBox(
            height: 15,
          ),
          _notes(),
        ]),
      ),
    );
  }

  Widget _notes() {
    final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.9,
      height: 80,
      child: TextFormField(
        controller: _notescontroller,
        validator: notesValidator,
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

  Widget _saveButton(h, w) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {

   _submitForm();

        
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

