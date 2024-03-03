import 'package:flutter/material.dart';
import 'package:minimal_messenger/DI/service_locator.dart';
import 'package:minimal_messenger/theme/dark_mode.dart';
import 'package:minimal_messenger/theme/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  static SharedPreferences _preferences = locator.get();
  static final String themeKey = "theme";

  static void saveTheme(bool onDark) async {
    _preferences.setBool(themeKey, onDark);
  }

  static bool readTheme() {
    return _preferences.getBool(themeKey) ?? false;
  }

  static ThemeData themeapply(bool currentTheme) {
    if (currentTheme) {
      return darkMode;
    } else {
      return lightMode;
    }
  }
}
