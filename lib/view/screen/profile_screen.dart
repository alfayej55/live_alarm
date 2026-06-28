import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/profile_controller.dart';
import '../../utils/constants.dart';
import '../widget/glass_card.dart';
import '../widget/glass_list_tile.dart';
import '../widget/glass_switch.dart';
import '../widget/glass_button.dart';
import '../../themes/app_colors.dart';

// Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: AppConstants.spacingM,
            right: AppConstants.spacingM,
            top: AppConstants.spacingL,
            bottom: 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Text(
                'Profile',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppConstants.spacingXL),

              // Profile Card
              _buildProfileCard(context, controller, isDark),
              const SizedBox(height: AppConstants.spacingXL),

              // Settings Section
              _buildSettingsSection(context, controller),
              const SizedBox(height: AppConstants.spacingL),

              // Logout Button
              GlassButton(
                text: 'Logout',
                onPressed: () => controller.logout(),
                width: double.infinity,
                icon: Icons.logout,
                isOutlined: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(
      BuildContext context, ProfileController controller, bool isDark) {
    return Obx(
      () => GlassCard(
        padding: const EdgeInsets.all(AppConstants.spacingXL),
        child: Column(
          children: [
            // Avatar
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: AppColors.buttonGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gradientPurple.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  controller.user.initials,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
            const SizedBox(height: AppConstants.spacingM),

            // Name
            Text(
              controller.user.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingXS),

            // Email
            Text(
              controller.user.email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, ProfileController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingS),
          child: Text(
            'Settings',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingM),

        // Notifications
        Obx(
          () => GlassListTile(
            leading: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Enable push notifications',
            trailing: GlassSwitch(
              value: controller.notificationsEnabled,
              onChanged: (value) => controller.toggleNotifications(value),
            ),
          ),
        ),

        // Dark Mode
        Obx(
          () => GlassListTile(
            leading: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: 'Switch to dark theme',
            trailing: GlassSwitch(
              value: controller.darkModeEnabled,
              onChanged: (value) => controller.toggleDarkMode(value),
            ),
          ),
        ),

        // Language
        Obx(
          () => GlassListTile(
            leading: Icons.language,
            title: 'Language',
            subtitle: controller.selectedLanguage,
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguageDialog(context, controller),
          ),
        ),

        // Privacy Policy
        GlassListTile(
          leading: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          subtitle: 'View our privacy policy',
          trailing: const Icon(Icons.chevron_right),
          onTap: () => controller.openPrivacyPolicy(),
        ),

        // About
        GlassListTile(
          leading: Icons.info_outline,
          title: 'About',
          subtitle: 'App version ${AppConstants.appVersion}',
          trailing: const Icon(Icons.chevron_right),
          onTap: () => controller.openAbout(),
        ),
      ],
    );
  }

  void _showLanguageDialog(BuildContext context, ProfileController controller) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: GlassCard(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Language',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppConstants.spacingL),
              ...controller.languageOptions.map(
                (language) => Obx(
                  () => RadioListTile<String>(
                    title: Text(language),
                    value: language,
                    groupValue: controller.selectedLanguage,
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectLanguage(value);
                        Get.back();
                      }
                    },
                    activeColor: AppColors.lightPrimary,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
