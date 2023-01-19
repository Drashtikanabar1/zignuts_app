import 'package:carousel_slider/carousel_slider.dart';
import 'package:firstapp/resources/assets_manager.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/resources/statics_manager.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/ui/screens/home/pages/categories/custom_image.dart';
import 'package:firstapp/ui/screens/home/pages/categories/gridview.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isFavoriteCategory = true;
  bool islistview = true;
  late String _dropDownValue;
  ScrollController _controller = ScrollController();
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
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: Dimensions.width8),
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

            islistview
                ? _listWidget(h, w)
                : SingleChildScrollView(child: Gridview()),
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
            if (index == 4) {
              return _ads();
            } else {
              return Padding(
                padding: EdgeInsets.only(top: w * 0.02),
                child: ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    title: CustomImage(
                      name: categorieslist[index],
                      image: ImageAssets.fruits,
                    )),
              );
            }
          }),
    );
  }

  Widget _ads() {
    return Container(
      height: 185,
      width: 375,
      child: CarouselSlider.builder(
        itemCount: images.length,
        options: CarouselOptions(viewportFraction: 1, autoPlay: true),
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            Container(
                width: 392.72,
                child: Image.asset(
                  images[itemIndex],
                  fit: BoxFit.cover,
                )),
      ),
    );
  }
}
