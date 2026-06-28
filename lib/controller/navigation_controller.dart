import 'package:get/get.dart';

// Navigation Controller for Bottom Navigation
class NavigationController extends GetxController {
  // Current tab index
  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;

  // Change tab
  void changeTab(int index) {
    _currentIndex.value = index;
  }

  // Reset to home tab
  void resetToHome() {
    _currentIndex.value = 0;
  }
}
