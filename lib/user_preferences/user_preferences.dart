


import 'package:firstapp/model/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String id = "id";
const String name = "name";
const String email = "email";

const String isLoggedInPref = "isLoggedIn";


class UserPreferences{
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
  static Future<void> setUserEmail({required String Email}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, Email);
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

    static Future<Appuser> getLoginUserInfo(Appuser user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uId = await prefs.getString(id);
    String? uName = await prefs.getString(name);
    String? uEmail = await prefs.getString(email);
    Appuser user = Appuser();
    user.id = uId;
    user.name = uName;
    user.email = uEmail;
    return user;
  }
}
