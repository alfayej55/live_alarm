import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/navigation_controller.dart';
import '../screen/home_screen.dart';
import '../screen/set_alarm_screen.dart';
import '../screen/history_screen.dart';
import '../screen/profile_screen.dart';
import '../widget/glass_bottom_navigation.dart';
import '../../themes/app_colors.dart';

// Main Navigation with Bottom Navigation Bar
class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavigationController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Screens
    final screens = [
      const HomeScreen(),
      const SetAlarmScreen(),
      const HistoryScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.darkGradient : AppColors.lightGradient,
        ),
        child: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: KeyedSubtree(
              key: ValueKey<int>(controller.currentIndex),
              child: screens[controller.currentIndex],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const GlassBottomNavigation(),
    );
  }
}
