import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  static const String themeUpdateId = 'theme_updater';

  var themeMode = ThemeMode.system.obs;
  final String _themeKey = 'app_theme';

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
  }

  bool get isDarkMode {
    if (themeMode.value == ThemeMode.system) {
      return Get.isPlatformDarkMode;
    } else {
      return themeMode.value == ThemeMode.dark;
    }
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);

    if (savedTheme == 'dark') {
      themeMode.value = ThemeMode.dark;
    } else if (savedTheme == 'light') {
      themeMode.value = ThemeMode.light;
    } else {
      themeMode.value = ThemeMode.system;
    }
    Get.changeThemeMode(themeMode.value);
  }

  Future<void> _saveThemeToPrefs(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    String themeStr = mode == ThemeMode.dark ? 'dark' : 'light';
    await prefs.setString(_themeKey, themeStr);
  }

  void toggleTheme(bool isDark) {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
    _saveThemeToPrefs(themeMode.value);

    update([themeUpdateId]);
  }
}
