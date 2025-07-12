import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await loadThemePreference();
  }

  Future<void> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode(prefs.getBool('isDarkMode') ?? false);
  }

  Future<void> toggleTheme() async {
    isDarkMode(!isDarkMode.value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode.value);
  }

  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
}