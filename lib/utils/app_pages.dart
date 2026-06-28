import 'package:get/get.dart';
import '../view/screen/splash_screen.dart';
import '../view/base/main_navigation.dart';
import '../view/screen/unknown_route_screen.dart';
import '../controller/home_controller.dart';
import '../controller/set_alarm_controller.dart';
import '../controller/history_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/navigation_controller.dart';
import 'app_routes.dart';

// App Pages Configuration
class AppPages {
  static final routes = [
    // Splash Screen
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    // Main Navigation (Home, Set Alarm, History, Profile)
    GetPage(
      name: AppRoutes.home,
      page: () => const MainNavigation(),
      bindings: [
        HomeBinding(),
        SetAlarmBinding(),
        HistoryBinding(),
        ProfileBinding(),
        NavigationBinding(),
      ],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),

    // Unknown Route
    GetPage(
      name: AppRoutes.unknown,
      page: () => const UnknownRouteScreen(),
      transition: Transition.fade,
    ),
  ];

  // Unknown route handler
  static GetPage unknownRoute = GetPage(
    name: AppRoutes.unknown,
    page: () => const UnknownRouteScreen(),
  );
}

// Bindings
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class SetAlarmBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SetAlarmController());
  }
}

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HistoryController());
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());
  }
}
