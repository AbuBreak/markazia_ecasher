import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String defaultLanguage = 'en';

  Locale currentLocale = Locale('en', '');
  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> setLanguage(String lang) async {
    defaultLanguage = lang;
    currentLocale = Locale(lang, '');
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', lang);
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('selected_language');
    if (lang != null) {
      defaultLanguage = lang;
      notifyListeners();
    }
  }

  Future<void> clearData() async {
    defaultLanguage = 'en';
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selected_language');
  }
}
