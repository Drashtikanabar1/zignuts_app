import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:firstapp/resources/assets_manager.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/resources/statics_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isFavoriteCategory = true;
  bool islistview = true;
  late String _dropDownValue;
  ScrollController _controller =ScrollController();

  var list = ["vendor 1", "vendor 2", "vendor 3", "vendor 4", "vendor 5"];
  List categorieslist = [
    "Home &kitchen",
    "Drinks",
    "Home &kitchen",
    "Drinks",
    "Home &kitchen",
    "Drinks",
    "Home & Kitchen"
  ];
  List<String> images = [
    ImageAssets.drink,
    ImageAssets.fruits,
     ImageAssets.drink,
    ImageAssets.fruits,
     ImageAssets.drink,
    ImageAssets.fruits,
  ];
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return  Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: w * 0.02),
            child: Icon(
              Icons.arrow_back,
            ),
          ),
          leadingWidth: w * 0.07,
          title: Text(
            StringManager.categoriappbar,
            style:
                TextStyle(color: ColorManager.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: ColorManager.appbarColor,
          foregroundColor: ColorManager.black,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: w * 0.04),
              child: Icon(Icons.search, color: ColorManager.black),
            ),
            Padding(
              padding: EdgeInsets.only(right: w * 0.05),
              child: Icon(Icons.qr_code, color: ColorManager.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _appbarview(h, w),
              _dropdown(h, w),
              
              islistview?_listWidget(h, w):
              SingleChildScrollView(child: _gridview(h,w)),
              //_imageview(h, w)
            ],
          ),
        ),
      );
    
  }

  Widget _appbarview(h, w) {
    return Padding(
      padding: EdgeInsets.only(top: h * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (isFavoriteCategory) {
                      isFavoriteCategory = false;
                    } else {
                      isFavoriteCategory = true;
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    color: isFavoriteCategory
                        ? ColorManager.green
                        : ColorManager.lightgreen,
                  ),
                  height: h * 0.05,
                  width: w * 0.3,
                  child: Center(
                      child: Text(
                    StringManager.yourfavourite,
                    style: TextStyle(
                        color: isFavoriteCategory
                            ? ColorManager.white
                            : ColorManager.green),
                  )),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (isFavoriteCategory) {
                      isFavoriteCategory = false;
                    } else {
                      isFavoriteCategory = true;
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                    color: isFavoriteCategory
                        ? ColorManager.lightgreen
                        : ColorManager.green,
                  ),
                  height: h * 0.05,
                  width: w * 0.3,
                  child: Center(
                      child: Text(
                    StringManager.allcategories,
                    style: TextStyle(
                        color: isFavoriteCategory
                            ? ColorManager.green
                            : ColorManager.white),
                  )),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (islistview) {
                  islistview = false;
                } else {
                  islistview = true;
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.5,
                      color:
                          islistview ? ColorManager.black : ColorManager.white),
                  color: islistview ? ColorManager.black : ColorManager.white),
              child: Icon(
                Icons.list,
                color: islistview ? ColorManager.white : ColorManager.grey,
              ),
            ),
          ),
          InkWell(
              onTap: () {
                setState(() {
                  if (islistview) {
                    islistview = false;
                  } else {
                    islistview = true;
                  }
                });
              },
              child: Container(
                  decoration: BoxDecoration(
                      color:
                          islistview ? ColorManager.white : ColorManager.black,
                      border: Border.all(
                          width: 1.5,
                          color: islistview
                              ? ColorManager.white
                              : ColorManager.black)),
                  child: Icon(
                    Icons.grid_view_rounded,
                    color: islistview ? ColorManager.grey : ColorManager.white,
                  )))
        ],
      ),
    );
  }

  Widget _dropdown(h, w) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: w * 0.03, top: h * 0.02),
        child: DropdownButton(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: ColorManager.green,
            ),
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text(
              "select vendor",
              style: TextStyle(color: ColorManager.green, fontSize: 18),
            ),
            onChanged: (newValue) {
              setState(() {
                _dropDownValue = newValue!;
              });
            }),
      ),
    );
  }

  Widget _imageview(h, w) {
    return Column(
      children: [
        Container(
          color: Colors.green,
          width: w,
          height: 23,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Home and kitchen"),
              Icon(Icons.discount_outlined),
              Icon(Icons.favorite_border_outlined),
            ],
          ),
        )
      ],
    );
  }

  Widget _listWidget(double h, double w) {
    return Container(
      
      child: ListView.builder(
        controller: _controller,
        shrinkWrap: true,
        itemCount: categorieslist.length,
        
        itemBuilder: (context, index) {
          if(index == 4){
           return _ads();
          }else return
           Container(
          
          child: Padding(
            padding:  EdgeInsets.only(top:w*0.02),
            child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                title: _customimage(
                  categorieslist[index],
                  ImageAssets.fruits,
                )),
          ),
        );
        }
        
       
      ),
    );
  }

  Widget _customimage(
    String name,
    String image,) {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius:const  BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                color: ColorManager.grey,
                offset: const Offset(
                  1.0,
                  1.0,
                )),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(name),
            )
          ]),
          Row(
            children: [
              Icon(Icons.discount_outlined),
              SizedBox(
                height: 18.33,
                width: 18.33,
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.favorite_border_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _ads(){
    return Container(
      height: 185,
      width: 375,
      child: CarouselSlider.builder(

        itemCount: images.length,
        options: CarouselOptions(viewportFraction: 1,autoPlay: true),
      itemBuilder:(BuildContext context, int itemIndex, int pageViewIndex) =>
    
       Container(
        width: 392.72,
       child: Image.asset(images[itemIndex],fit: BoxFit.cover,)
       ),
    ),
);
    
  }
  

  Widget _gridview(double h, double w) {
    return Container(
    
      width: 392,
      child: ListView.builder(
          controller: _controller,
          shrinkWrap: true,
          itemCount: categorieslist.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            if (index == 4) {
              return _ads();
            } else
              return Container(
                child: Padding(
                  padding: EdgeInsets.only(top: h * 0.02),
                  child: Column(children: [
                    _customgirdimage(categorieslist[index]),

                    _gridimageview(),
                  ]),
                ),
              );
          }),
    );
  }
   
Widget _customgirdimage(
    String name,
  ) {
    return
        Container(
          height: 25,
          width:400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [ 
                
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(width: 280, child: Text(name,style: TextStyle(color: ColorManager.green,fontWeight: FontWeight.bold),)),
                    ),
               
                  Row(
                    children:  [
                       Icon(Icons.discount,color: ColorManager.green,),
                     const   SizedBox(
                        height: 18.33,
                        width: 18.33,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.favorite,color: ColorManager.green,),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
  }
  Widget _gridimageview(

   
  ){
    return Container(
      height:125,
      
      width: 392,
      padding: EdgeInsets.only(top: 3,bottom: 8),
        child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:images .length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
              
                crossAxisSpacing: 5,
                ),
            itemBuilder: (context, index) {
              return GridTile(
                  child: Container(
                    
                     
                      alignment: Alignment.center,
                      child: _gridimage(categorieslist[index],images[index]),));
            },
          ),
        );
    
  }
   Widget _gridimage(
    String name,
    String image,
  ) {
    return Container(
     
      height: 120,
      width: 80,
      child: Column(
        children: [
          Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              width:80,
              height: 80,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                 Radius.circular(10)
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 10,top: 3),
              child: Container(
               
               
               child :Text(name,style: TextStyle(fontSize: 12),),
              ),
            ),
          )
        ],
      ),
    );
  }
}


