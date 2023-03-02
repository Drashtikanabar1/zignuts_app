import 'package:carousel_slider/carousel_slider.dart';
import 'package:firstapp/resources/assets_manager.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../resources/colors_manager.dart';

class Gridview extends StatefulWidget {
  const Gridview({super.key});

  @override
  State<Gridview> createState() => _GridviewState();
}

class _GridviewState extends State<Gridview> {
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
   ScrollController _controller =ScrollController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
    
      width: 392,
      child: ListView.builder(
          controller: _controller,
          shrinkWrap: true,
          itemCount: categorieslist.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            if (index == 4) {
              return _ads();
            } else {
              return Padding(
                padding: EdgeInsets.only(top:Dimensions.height15),
                child: Column(children: [
                  _customgirdimage(categorieslist[index]),

                  _gridimageview(),
                ]),
              );
            }
          }),
    );
  }
  
   
Widget _customgirdimage(
    String name,
  ) {
    return
        SizedBox(
          height: 25,
          width:400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [ 
                
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(width: 280, child: Text(name,style: TextStyle(color: ColorManager.green,fontWeight: FontWeight.bold),)),
                    ),
               
                  Row(
                    children:  [
                       Icon(Icons.discount,color: ColorManager.green,),
                     const   SizedBox(
                        height: 18.33,
                        width: 18.33,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
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
      padding: const EdgeInsets.only(top: 3,bottom: 8),
        child: GridView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount:images .length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:150,
                
                crossAxisSpacing: 20,
               
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
    return SizedBox(
     
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
              padding: const EdgeInsets.only(left: 10,top: 3),
              child: Container(
               
               
               child :Text(name,style: const TextStyle(fontSize: 12),),
              ),
            ),
          )
        ],
      ),
    );
  }
    Widget _ads(){
    return SizedBox(
      height: 185,
      width: 375,
      child: CarouselSlider.builder(

        itemCount: images.length,
        options: CarouselOptions(viewportFraction: 1,autoPlay: true),
      itemBuilder:(BuildContext context, int itemIndex, int pageViewIndex) =>
    
       SizedBox(
        width: 392.72,
       child: Image.asset(images[itemIndex],fit: BoxFit.cover,)
       ),
    ),
);
    
  }
  
}


