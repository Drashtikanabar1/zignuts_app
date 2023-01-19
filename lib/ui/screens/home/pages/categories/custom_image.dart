import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../resources/colors_manager.dart';

class CustomImage extends StatelessWidget {
  final  String name;
   final String image;

   const CustomImage( {super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
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
            children: const [
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
}