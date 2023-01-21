import 'package:firstapp/controller/locale_provider.dart';
import 'package:firstapp/l10n/localization.dart';
import 'package:firstapp/model/language.dart';
import 'package:firstapp/resources/assets_manager.dart';
import 'package:firstapp/resources/style_manager.dart';
import 'package:firstapp/ui/screens/home/pages/homepage/homepage.dart';
import 'package:firstapp/user_preferences/global_variables.dart';
import 'package:firstapp/user_preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../resources/colors_manager.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  static const String id = 'LanguageScreen';

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<Language> languageList = [
    Language(
        name: 'English',
        langCode: 'en',
        image: ImageAssets.english,
        isChecked: true),
    Language(
        name: 'Arabic',
        langCode: 'ar',
        image:ImageAssets.arabic,
        isChecked: false)
  ];
  String lngCode = '';

  @override
  void initState() {
    UserPreferences.getLocaleLanguageCode().then((value) => {
          setState(() {
            for (var element in languageList) {
              if (element.langCode == value) {
                element.isChecked = true;
              } else {
                element.isChecked = false;
              }
            }
            lngCode = value;
          })
        });
    super.initState();
  }

  Container saveLanguageButton({required void Function()? onPressed}) {
    return Container(
      height: Dimensions.height46,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(8.0)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          AppLocalizations.of(context)!.saveLanguage,
          
        ),
      ),
    );
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSizedBoxSpacer(),
              getHeaderWithBackArrowAndTitle(
                  context, AppLocalizations.of(context)!.selectLanguage, () {
                Navigator.pop(context);
              }, lngCode),
              buildSizedBoxSpacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: languageList.length,
                  itemBuilder: (BuildContext context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: LanguageItem(
                      language: languageList[index],
                      onClick: () async {
                        setState(() {
                          for (var element in languageList) {
                            element.isChecked = false;
                          }
                         languageList[index].isChecked = true;
                          if (languageList[index].isChecked =
                              true) {
                            selectedIndex = index;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Consumer<LocaleProvider>(
                builder: (context, localeModel, child) =>
                    saveLanguageButton(onPressed: () {
                  setState(() {
                    localeModel.setLocale(Locale(
                        languageList[selectedIndex].langCode));
                    UserPreferences.setLocaleLanguageCode(
                        languageCode:
                            languageList[selectedIndex].langCode);
                  });
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomePage.id, (route) => false);
                }),
              ),
              buildSizedBoxSpacer()
            ],
          ),
        ),
      ),
    );
  }
  getHeaderWithBackArrowAndTitle(BuildContext context, String title,
      void Function() onBackClick, String lngCode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: onBackClick,
          child: SizedBox(
            height: Dimensions.height20,
            width: Dimensions.width20,
            child: SvgPicture.asset(
              lngCode == LanguageCode.languageCodeArabic
                  ? IconAssets.backMirrorArrowBlack
                  : IconAssets.backArrowBlack,
              fit: BoxFit.fitHeight,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: Dimensions.width3,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style:TextStyle(
              fontSize: 18, color: ColorManager.black),
        ),
      ],
    );
  }

}

class LanguageItem extends StatelessWidget {
  Language language;
  Function onClick;

  LanguageItem({Key? key, required this.language, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal:Dimensions.width27,
        ),
        height:Dimensions.height55,
        decoration: BoxDecoration(
          color: language.isChecked ? ColorManager.primary : Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: Dimensions.height15,
              width: Dimensions.width27,
              child: Image.asset(
                language.image,
                filterQuality: FilterQuality.high,
              ),
            ),
            buildSizedBoxSpacer(),
            Text(
              language.name,
              style:TextStyle(
                  color: language.isChecked ? ColorManager.white : Colors.black,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

SizedBox buildSizedBoxSpacer() {
  return SizedBox(
    height: Dimensions.height15,
    width: Dimensions.width15,
  );
  
}


