import 'package:firstapp/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Detailscard extends StatefulWidget {
  final String title;
  const Detailscard({super.key, required this.title});

  @override
  State<Detailscard> createState() => _DetailscardState();
}

class _DetailscardState extends State<Detailscard> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: w * 0.07,
        title: Text(
          "Card Details",
          style:
              TextStyle(color: ColorManager.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorManager.appbarColor,
        foregroundColor: ColorManager.black,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _customcard(widget.title),
          SizedBox(
            height: h * 0.03,
          ),
          _details(h, w,widget.title),
        ],
      )),
    );
  }

  Widget _customcard(String title) {
    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Container(
                  height: 220,
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.cardcolour,
                    border: Border.all(
                      width: 5,
                      color: ColorManager.cardcolour,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 111,
                          width: 111,
                          child: Center(
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: ColorManager.circleavtarcolour,
                              child: Text(
                                title.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                    fontSize: 41, color: ColorManager.white),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(title),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(top: 25, right: 25),
              child: Icon(
                Icons.more_vert,
              ),
            ))
      ],
    );
  }

  Widget _details(h, w,String title) {
    return Padding(
      padding: EdgeInsets.only(left:20,right: 20),
      child: Container(
      
        height: h,
        width: 392.77,
        child: Column(
          
          children: [
            Center(
              child: Container(
               width: w,
                
                child: Text("Lorem Ipsum"),
              ),
            ),
            Container(
              width: w,
              padding: EdgeInsets.only(top: 2),
              child:    Text("Member ID : JC65456465464"),
            ),
            Container(
              padding: EdgeInsets.only(top:22),
              child:  Row(
              children: [Icon(Icons.alarm_rounded), Text(title)],
              ),
           
            ),
           Container(
            padding: EdgeInsets.only(top: 2),
            child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."),)
           
          ],
        ),
      ),
    );
  }
}
