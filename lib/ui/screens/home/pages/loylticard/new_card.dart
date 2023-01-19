import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firstapp/authentication/auth_database.dart';
import 'package:firstapp/model/loylti_card.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/services/save_database.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/utilies/custom_form.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/utilies/form_section.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/utilies/select_photo_option.dart';
import 'package:firstapp/resources/assets_manager.dart';
import 'package:firstapp/ui/screens/home/pages/loylticard/view_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../resources/colors_manager.dart';

class Newloylticard extends StatefulWidget {
  LoyltiCard loyltiCard;
 bool? editenable;
  Newloylticard({super.key, required this.loyltiCard,  this.editenable});

  @override
  State<Newloylticard> createState() => _NewloylticardState();
}

class _NewloylticardState extends State<Newloylticard> {
  File? _image;
  File? _image1;
  bool isFrnotSide = false;
  bool _isLoading = false;
  bool _isenable = true;

  var selectedVendor = "";
  List vendorList = [
    "Vendor 1",
    "Vendor 2",
    "Vendor 3",
    "Vendor 4",
    "Vendor 5",
  ];

  final TextEditingController _cardnocontroller = TextEditingController();
  final TextEditingController _cardnamecontroller = TextEditingController();
  final TextEditingController _websiteurlcontroller = TextEditingController();
  final TextEditingController _notescontroller = TextEditingController();
  final StorageService _storageService = StorageService();
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
    RequiredValidator(errorText: "notes is requried"),
  ]);

  final GlobalKey<FormState> _cardFormKey = GlobalKey<FormState>();
  final Auth _auth = Auth();
  


  void _submitForm() async {
    final isValid = _cardFormKey.currentState!.validate();

    if (isValid) {
      _cardFormKey.currentState!.save();
      try {
       
          if(widget.editenable != null){
            if(_image !=null && _image1 !=null){
              setState(() {
            _isLoading = true;
            _isenable = false;
          });
              final url = await _storageService.saveCardImages(_image!, _image1!);
              setState(() {
                widget.loyltiCard.frontCardUrl=url[0];
                widget.loyltiCard.backCardUrl=url[1];
              });
              }
            

          await FirebaseFirestore.instance
              .collection('loylticrad')
              .doc(_auth.getUser()?.uid)
              .collection("userloylticard")
              .doc(widget.loyltiCard.id)
              .update({
            'cardame': _cardnocontroller.text,
            'name': _cardnamecontroller.text,
            'vendor': selectedVendor,
            'websiteurl': _websiteurlcontroller.text,
            'notes': _notescontroller.text,
            'frontcardurl': widget.loyltiCard.frontCardUrl,
            'backcardurl': widget.loyltiCard.backCardUrl,
          });
      Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Cardgridview()),
          );
       }else{
         if(_image!=null && _image1 !=null){
          setState(() {
            _isLoading = true;
            _isenable = false;
          });
          final url = await _storageService.saveCardImages(_image!, _image1!);

          await FirebaseFirestore.instance
              .collection('loylticrad')
              .doc(_auth.getUser()?.uid)
              .collection("userloylticard")
              .doc()
              .set({
            'cardame': _cardnocontroller.text,
            'name': _cardnamecontroller.text,
            'vendor': selectedVendor,
            'websiteurl': _websiteurlcontroller.text,
            'notes': _notescontroller.text,
            'frontcardurl': url[0],
            'backcardurl': url[1],
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Cardgridview()),
          );
         }
          else{
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please pick image ")));
         }
       }
      } catch (error) {
        print('error occured : $error');
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _isenable = true;
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
      img = await _auth.cropImage(imageFile: img);
      
      if (isFrnotSide) {
        setState(() {
          _image = img;
          Navigator.of(context).pop();
        });
      } else {
        setState(() {
          _image1 = img;
         
        });
      }
    } on PlatformException catch (e) {
      print('error is $e');
      Navigator.of(context).pop();
    }
  }


  void _showSelectPhotoOptions(BuildContext context,) {
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
  void initState() {
    setState(() {
      _cardnocontroller.text = widget.loyltiCard.cardName!;
      _cardnamecontroller.text = widget.loyltiCard.name!;
      _websiteurlcontroller.text = widget.loyltiCard.websiteUrl!;
      _notescontroller.text = widget.loyltiCard.notes!;
      selectedVendor=widget.loyltiCard.vendor!;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              height: Dimensions.height31,
            ),
            _takeimage(),
            // ShowImage(loyltiCard: widget.loyltiCard, enabled:_isenable,image:_image,image1: _image1,),
            SizedBox(
              height: Dimensions.height23,
            ),
            _formdetails(),
            SizedBox(
              height: Dimensions.height23,
            ),
            _saveButton(),
          ],
        ),
      ),
    );
  }

  Widget _text() {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.height28,
          right: Dimensions.width35,
          left: Dimensions.width33),
      child: Text(
        "Scan your card barcode or QR code and enter the following info as you prefer to link it to your card ",
        style: TextStyle(
            fontSize: 14,
            color: ColorManager.lightblack,
            height: Dimensions.height2),
      ),
    );
  }

  Widget _takeimage() {
    return Row(
        children: [
           TakeImage(
            image: _image,
            onPressed:() {
                     widget.loyltiCard.frontCardUrl= "" ;
                      setState(() {
                        isFrnotSide = true;
                      });
                      _showSelectPhotoOptions(context);
                    } ,
                    title: "Card front",
                    enabled: _isenable,
                    url: widget.loyltiCard.frontCardUrl!,
                    defultimg: ImageAssets.card,
                    ),
             TakeImage(
                 image: _image1,
                   onPressed:() {

                      widget.loyltiCard.backCardUrl= "" ;
                      setState(() {
                        isFrnotSide =false;
                      });
                      _showSelectPhotoOptions(context);
                    } ,
                    title: "Card back",
                    enabled: _isenable,
                    url: widget.loyltiCard.backCardUrl!,
                    defultimg: ImageAssets.backcard,
                    ),   
          
        ],
      );
    
  }

  Widget _formdetails() {
    return Padding(
      padding:
          EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      child: Column(
        children: [
          Container(
            child: Form(
              key: _cardFormKey,
              child: Column(children: [
                CustomFormField(
                  enabled: _isenable,
                  hintext: "Card Number",
                  label: "Card Number",
                  controller: _cardnocontroller,
                  validate: cardnoValidator,
                ),
                selectvendor(
                  list: vendorList,
                  onChanged: (Value) {
                    setState(() {
                      selectedVendor = Value;
                    });
                  },
                ),
                CustomFormField(
                  enabled: _isenable,
                  hintext: "Program name",
                  label: "Program name",
                  controller: _cardnamecontroller,
                  validate: nameValidator,
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                CustomFormField(
                  enabled: _isenable,
                  hintext: "Website url",
                  label: "Website Url",
                  controller: _websiteurlcontroller,
                  validate: websiteurlValidator,
                ),
                SizedBox(
                  height: Dimensions.height15,
                ),
                _notes(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notes() {
    

    return Container(
      child: TextFormField(
        controller: _notescontroller,
        validator: notesValidator,
        enabled: _isenable,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: 2,
        autofocus: true,
        decoration: InputDecoration(
          label: const Text("Notes"),
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

  Widget _saveButton() {
    return _isLoading
        ? CircularProgressIndicator(
            color: ColorManager.green,
          )
        : MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              _submitForm();
            },
            minWidth: Dimensions.width353,
            height: Dimensions.height50,
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

  Widget selectvendor({
    required List list,
    required Function(dynamic) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: DropdownButtonFormField(
        hint: Text("select vandor"),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == "" || list.indexOf(value) == -1) {
            return "Remaining to select vendor";
          }
        },
        focusNode: FocusNode(descendantsAreTraversable: true),
        style: TextStyle(color: ColorManager.grey, fontSize: 16),
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(color: ColorManager.black),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          hintText: "Select vendor",
          enabled: _isenable,
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
        items: list.map<DropdownMenuItem>((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
