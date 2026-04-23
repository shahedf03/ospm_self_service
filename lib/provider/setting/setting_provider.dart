import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../helper/translations/localization.dart';


  class LanguageProvider extends ChangeNotifier {
  final GetStorage _storage = GetStorage();
  final LocalizationService _localizationService = LocalizationService();

  String _currentLang = 'English';

  LanguageProvider() {
    _loadLanguage();
  }

  String get currentLang => _currentLang;

  void toggleLanguage(String s) {
    if (_currentLang == 'English') {
      _currentLang = 'Arabic';
    } else {
      _currentLang = 'English';
    }

    _storage.write('lng', _currentLang);
    _localizationService.changeLocale(_currentLang);
    notifyListeners();
  }

  void _loadLanguage() {
    final storedLang = _storage.read('lng');
    if (storedLang != null) {
      _currentLang = storedLang;
      _localizationService.changeLocale(_currentLang);
    } else {
      _storage.write('lng', _currentLang);
    }
    notifyListeners();
  }
}
