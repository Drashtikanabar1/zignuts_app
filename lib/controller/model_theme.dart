import 'package:firstapp/user_preferences/user_preferences.dart';
import 'package:flutter/material.dart';

class ModelTheme extends ChangeNotifier{
  late bool _isDark;
  late UserPreferences _preferences;
  bool get isDark => _isDark;
 
  ModelTheme() {
    _isDark = false;
    _preferences = UserPreferences();
    getPreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}