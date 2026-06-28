import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../controller/navigation_controller.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import '../widget/glass_card.dart';
import '../widget/glass_text_field.dart';
import '../widget/glass_section_title.dart';
import '../widget/glass_button.dart';
import '../../models/alarm_model.dart';
import '../../themes/app_colors.dart';

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final responsive = context.responsive;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.refresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(
              left: AppConstants.spacingM,
              right: AppConstants.spacingM,
              top: AppConstants.spacingL,
              bottom: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(context, controller, isDark),
                const SizedBox(height: AppConstants.spacingL),

                // Search Bar
                _buildSearchBar(controller),
                const SizedBox(height: AppConstants.spacingL),

                // Statistics Cards
                _buildStatistics(context, controller, responsive),
                const SizedBox(height: AppConstants.spacingXL),

                // Recent Alarms Section
                GlassSectionTitle(
                  title: 'Recent Alarms',
                  actionText: 'View All',
                  onActionPressed: () {
                    Get.find<NavigationController>().changeTab(2);
                  },
                ),
                const SizedBox(height: AppConstants.spacingM),

                // Recent Alarms List
                Obx(() => _buildRecentAlarms(context, controller)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildHeader(BuildContext context, HomeController controller, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.greeting,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
              ),
              const SizedBox(height: AppConstants.spacingXS),
              Text(
                AppConstants.dummyUserName.split(' ')[0],
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        GlassCard(
          padding: const EdgeInsets.all(AppConstants.spacingS),
          borderRadius: AppConstants.radiusL,
          onTap: () {},
          child: const Icon(
            Icons.notifications_outlined,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(HomeController controller) {
    return GlassTextField(
      hintText: 'Search alarms...',
      prefixIcon: Icons.search,
      onChanged: (value) => controller.searchAlarms(value),
    );
  }

  Widget _buildStatistics(
      BuildContext context, HomeController controller, Responsive responsive) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context: context,
            title: 'Total',
            value: controller.statistics.totalAlarms.toString(),
            icon: Icons.alarm,
            gradient: AppColors.buttonGradient,
          ),
        ),
        const SizedBox(width: AppConstants.spacingM),
        Expanded(
          child: _buildStatCard(
            context: context,
            title: 'Time',
            value: controller.statistics.timeAlarms.toString(),
            icon: Icons.access_time,
            gradient: const LinearGradient(
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
            ),
          ),
        ),
        const SizedBox(width: AppConstants.spacingM),
        Expanded(
          child: _buildStatCard(
            context: context,
            title: 'Location',
            value: controller.statistics.locationAlarms.toString(),
            icon: Icons.location_on,
            gradient: const LinearGradient(
              colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Gradient gradient,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingS),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
              boxShadow: [
                BoxShadow(
                  color: gradient.colors.first.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAlarms(BuildContext context, HomeController controller) {
    if (controller.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.recentAlarms.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.recentAlarms.length,
      itemBuilder: (context, index) {
        final alarm = controller.recentAlarms[index];
        return _buildAlarmCard(context, alarm, controller);
      },
    );
  }

  Widget _buildAlarmCard(
      BuildContext context, AlarmModel alarm, HomeController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isTimeAlarm = alarm.type == AlarmType.time;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
      padding: const EdgeInsets.all(AppConstants.spacingM),
      child: Row(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingM),
            decoration: BoxDecoration(
              gradient: isTimeAlarm
                  ? AppColors.buttonGradient
                  : const LinearGradient(
                      colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
                    ),
              borderRadius: BorderRadius.circular(AppConstants.radiusM),
            ),
            child: Icon(
              isTimeAlarm ? Icons.access_time : Icons.location_on,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppConstants.spacingM),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alarm.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppConstants.spacingXS),
                Text(
                  isTimeAlarm ? alarm.formattedTime : alarm.locationName ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                ),
              ],
            ),
          ),

          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingS,
              vertical: AppConstants.spacingXS,
            ),
            decoration: BoxDecoration(
              color: _getStatusColor(alarm.status).withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
              border: Border.all(
                color: _getStatusColor(alarm.status),
                width: 1,
              ),
            ),
            child: Text(
              alarm.statusLabel,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: _getStatusColor(alarm.status),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppConstants.spacingXL),
      child: Column(
        children: [
          Icon(
            Icons.alarm_off,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: AppConstants.spacingM),
          Text(
            'No alarms found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingS),
          Text(
            'Create your first alarm to get started',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return GlassButton(
      text: '',
      onPressed: () {
        Get.find<NavigationController>().changeTab(1);
      },
      width: 64,
      height: 64,
      borderRadius: 32,
      icon: Icons.add,
    );
  }

  Color _getStatusColor(AlarmStatus status) {
    switch (status) {
      case AlarmStatus.active:
        return AppColors.success;
      case AlarmStatus.inactive:
        return AppColors.warning;
      case AlarmStatus.completed:
        return AppColors.info;
      case AlarmStatus.missed:
        return AppColors.error;
    }
  }
}
