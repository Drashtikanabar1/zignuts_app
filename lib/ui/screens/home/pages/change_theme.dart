import 'package:firstapp/controller/model_theme.dart';
import 'package:firstapp/resources/colors_manager.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/ui/screens/home/pages/changelanguage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({super.key});

  @override
  State<ChangeTheme> createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  List list =[
    "Dark Theme"
    "light THeme"
  ];
  @override
  Widget build(BuildContext context) {
    return  Consumer<ModelTheme>(
        builder: (context, themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(themeNotifier.isDark ? "Dark Mode" : "Light Mode"),
          actions: [
            IconButton(
                icon: Icon(themeNotifier.isDark
                    ? Icons.nightlight_round
                    : Icons.wb_sunny),
                onPressed: () {
                  themeNotifier.isDark
                      ? themeNotifier.isDark = false
                      : themeNotifier.isDark = true;
                })
          ],
        ),
        body: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. \nLorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        }),
      );
        }
    );
    // return Scaffold(
    //    backgroundColor: ColorManager.white,
    //   body: SafeArea(
    //     child: Padding(
    //       padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
              
              
    //           Padding(
    //             padding: const EdgeInsets.only(bottom: 20.0),
    //             child: ListView.builder(
    //               shrinkWrap: true,
    //               physics: const ClampingScrollPhysics(),
    //               itemCount: list.length,
    //               itemBuilder: (BuildContext context, index) => Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: 8.0, vertical: 8.0),
    //                 child: LanguageItem(
    //                   language: list[index],
    //                   onClick: () {

    //                   } 
    //                 ),
    //               ),
    //             ),
    //           ),
    //           const Spacer(),
    //           Consumer<ModelTheme>(
    //             builder: (context, localeModel, child) =>
    //                 saveLanguageButton(onPressed: () {
    //               setState(() {
    //                 localeModel.setLocale(Locale(
    //                     languageList[selectedIndex].langCode));
    //                 UserPreferences.setLocaleLanguageCode(
    //                     languageCode:
    //                         languageList[selectedIndex].langCode);
    //               });
    //               Navigator.pushNamedAndRemoveUntil(
    //                   context, HomePage.id, (route) => false);
    //             }),
    //           ),
    //           buildSizedBoxSpacer()
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}