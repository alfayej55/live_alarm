import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../helper/dummy_data.dart';

// Profile Controller
class ProfileController extends GetxController {
  // Observable data
  final _user = DummyData.dummyUser.obs;
  final _notificationsEnabled = true.obs;
  final _darkModeEnabled = false.obs;
  final _selectedLanguage = 'English'.obs;

  // Getters
  UserModel get user => _user.value;
  bool get notificationsEnabled => _notificationsEnabled.value;
  bool get darkModeEnabled => _darkModeEnabled.value;
  String get selectedLanguage => _selectedLanguage.value;

  // Language options
  final List<String> languageOptions = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Japanese',
  ];

  @override
  void onInit() {
    super.onInit();
    _notificationsEnabled.value = _user.value.notificationsEnabled;
    _darkModeEnabled.value = _user.value.darkModeEnabled;
    _selectedLanguage.value = _user.value.language;
  }

  // Toggle notifications
  void toggleNotifications(bool value) {
    _notificationsEnabled.value = value;
    _user.value = _user.value.copyWith(notificationsEnabled: value);
    Get.snackbar(
      'Notifications',
      value ? 'Notifications enabled' : 'Notifications disabled',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Toggle dark mode
  void toggleDarkMode(bool value) {
    _darkModeEnabled.value = value;
    _user.value = _user.value.copyWith(darkModeEnabled: value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
    Get.snackbar(
      'Theme',
      value ? 'Dark mode enabled' : 'Light mode enabled',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Select language
  void selectLanguage(String language) {
    _selectedLanguage.value = language;
    _user.value = _user.value.copyWith(language: language);
    Get.snackbar(
      'Language',
      'Language changed to $language',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Navigate to Privacy Policy
  void openPrivacyPolicy() {
    Get.snackbar(
      'Privacy Policy',
      'Privacy policy would open here',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Navigate to About
  void openAbout() {
    Get.snackbar(
      'About',
      'About page would open here',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Logout
  void logout() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        Get.snackbar(
          'Logged Out',
          'You have been logged out successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }
}
