import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/navigation_controller.dart';
import '../../themes/app_colors.dart';
import '../../utils/constants.dart';

// Glassmorphism Bottom Navigation Widget
class GlassBottomNavigation extends StatelessWidget {
  const GlassBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavigationController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: AppConstants.bottomNavHeight + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.5)
                : Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ]
                    : [
                        Colors.white.withOpacity(0.7),
                        Colors.white.withOpacity(0.5),
                      ],
              ),
              border: Border(
                top: BorderSide(
                  color: isDark
                      ? Colors.white.withOpacity(0.2)
                      : Colors.white.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
            ),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context: context,
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                    label: 'Home',
                    index: 0,
                    isActive: controller.currentIndex == 0,
                    onTap: () => controller.changeTab(0),
                    isDark: isDark,
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Icons.alarm_add_outlined,
                    activeIcon: Icons.alarm_add,
                    label: 'Set Alarm',
                    index: 1,
                    isActive: controller.currentIndex == 1,
                    onTap: () => controller.changeTab(1),
                    isDark: isDark,
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Icons.history_outlined,
                    activeIcon: Icons.history,
                    label: 'History',
                    index: 2,
                    isActive: controller.currentIndex == 2,
                    onTap: () => controller.changeTab(2),
                    isDark: isDark,
                  ),
                  _buildNavItem(
                    context: context,
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: 'Profile',
                    index: 3,
                    isActive: controller.currentIndex == 3,
                    onTap: () => controller.changeTab(3),
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required bool isActive,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingS),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: AppConstants.animationDuration,
                padding: const EdgeInsets.all(AppConstants.spacingS),
                decoration: BoxDecoration(
                  gradient: isActive ? AppColors.buttonGradient : null,
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.gradientPurple.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  isActive ? activeIcon : icon,
                  size: 26,
                  color: isActive
                      ? Colors.white
                      : isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: AppConstants.spacingXS),
              AnimatedDefaultTextStyle(
                duration: AppConstants.animationDuration,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: isActive
                          ? (isDark ? AppColors.darkText : AppColors.lightText)
                          : isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
