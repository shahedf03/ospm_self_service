import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'en_us.dart';
import 'ar_ae.dart';

class LocalizationService extends Translations {
  static const local = Locale('en', 'US');
  static const fallBackLocale = Locale('en', 'US');

  static final languages = ['English', 'Arabic'];
  static final locales = [const Locale('en', 'US'), const Locale('ar', 'AE')];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'ar_AE': arAE,
      };

  void changeLocale(String lang) {
    final locale = getLocale(lang);
    final box = GetStorage();
    box.write('lng', lang);
    Get.updateLocale(locale!);
  }

  Locale? getLocale(String lang) {
    for (int i = 0; i < languages.length; i++) {
      if (lang == languages[i]) return locales[i];
    }

    return Get.locale;
  }

  Locale getCurrentLocale() {
    final box = GetStorage();
    Locale defaultLocale;

    if (box.read('lng') != null) {
      final locale = getLocale(box.read('lng'));

      defaultLocale = locale!;
    } else {
      defaultLocale = const Locale('ar', 'AE');
      box.write('lng', 'Arabic');
      // defaultLocale = const Locale('en', 'US');
    }

    return defaultLocale;
  }

  String getCurrentLang() {
    final box = GetStorage();

    return box.read('lng') ?? 'English';
  }
}
