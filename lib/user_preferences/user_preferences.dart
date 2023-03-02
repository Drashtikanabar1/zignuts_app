


import 'package:firstapp/model/app_user.dart';
import 'package:firstapp/user_preferences/global_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String id = "id";
const String name = "name";
const String email = "email";
const String userTokenPref = "userToken";
const String isLoggedInPref = "isLoggedIn";
const String selectedLocaleLanguageCodePref = "selectedLocaleLanguageCode";

 const THEME_KEY = "theme_key";


class UserPreferences{
  static Future<String> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userTokenPref) ?? "";
  }
   static Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(id) ?? "";
  }

   static Future<String> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(email) ?? "";
  }
   static Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(name) ?? "";
  }
   static Future<bool> getUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInPref) ?? false;
  }
  //set
  static Future<void> setUserId({required String userId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, userId);
  }
  static Future<void> setUserName({required String name}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, name);
  }
  static Future<void> setUserEmail({required String email}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, email);
  }
   static Future<void> setUserLoggedIn({required bool hasLoggedIn}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedInPref, hasLoggedIn);
  }

   static Future<void> saveLoginUserInfo(Appuser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, user.id!);
    await prefs.setString(name, user.name!);
    await prefs.setString(email, user.email!);
  }
   static Future<void> setLocaleLanguageCode(
      {required String languageCode}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(selectedLocaleLanguageCodePref, languageCode);
    GlobalVariables.languageCode = languageCode;
  }
     static Future<String> getLocaleLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(selectedLocaleLanguageCodePref) ??
        LanguageCode.languageCodeEnglish;
  }
             
  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY) ?? false;
  }
    setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY) ?? false;
  }
    static Future<Appuser> getLoginUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uId =  prefs.getString(id);
    String? uName = prefs.getString(name);
    String? uEmail =  prefs.getString(email);
    Appuser user = Appuser(id:uId,name: uName,email:uEmail);
   
   
    return user;
    
  }
}
