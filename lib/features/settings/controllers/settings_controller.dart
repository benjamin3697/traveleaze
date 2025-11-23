import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  // Use GetStorage to store settings persistently
  final _storage = GetStorage();

  // --- Dark Mode ---
  // Reactive variable to hold the current theme mode
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    // Load the saved theme mode when the controller is initialized
    _loadThemeMode();
  }

  /// Load the theme from storage and apply it.
  void _loadThemeMode() {
    final savedTheme = _storage.read('themeMode');
    if (savedTheme == 'dark') {
      themeMode.value = ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
    } else if (savedTheme == 'light') {
      themeMode.value = ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
    } else {
      themeMode.value = ThemeMode.system;
      Get.changeThemeMode(ThemeMode.system);
    }
  }

  /// Toggle dark mode and save the preference.
  void toggleDarkMode(bool isDark) {
    if (isDark) {
      themeMode.value = ThemeMode.dark;
      Get.changeThemeMode(ThemeMode.dark);
      _storage.write('themeMode', 'dark');
    } else {
      themeMode.value = ThemeMode.light;
      Get.changeThemeMode(ThemeMode.light);
      _storage.write('themeMode', 'light');
    }
  }

  // --- Other Settings (can be added later) ---
  final RxBool pushNotifications = true.obs;
  final RxDouble fontSize = 1.0.obs;

  void togglePushNotifications(bool value) {
    pushNotifications.value = value;
    // You can also save this to storage: _storage.write('pushNotifications', value);
  }

  void changeFontSize(double value) {
    fontSize.value = value;
    // You can also save this to storage: _storage.write('fontSize', value);
  }
}
