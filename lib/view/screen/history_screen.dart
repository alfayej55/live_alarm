import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/history_controller.dart';
import '../../utils/constants.dart';
import '../widget/glass_card.dart';
import '../widget/glass_text_field.dart';
import '../../models/alarm_model.dart';
import '../../themes/app_colors.dart';

// History Screen
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HistoryController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              child: Column(
                children: [
                  Text(
                    'History',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppConstants.spacingM),

                  // Search Bar
                  GlassTextField(
                    hintText: 'Search history...',
                    prefixIcon: Icons.search,
                    onChanged: (value) => controller.searchAlarms(value),
                  ),
                  const SizedBox(height: AppConstants.spacingM),

                  // Filter Chips
                  _buildFilterChips(context, controller, isDark),
                ],
              ),
            ),

            // Alarm List
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.refresh();
                },
                child: Obx(() => _buildAlarmList(context, controller)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips(
      BuildContext context, HistoryController controller, bool isDark) {
    return SizedBox(
      height: 40,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.filterOptions.length,
          itemBuilder: (context, index) {
            final filter = controller.filterOptions[index];
            final isSelected = controller.selectedFilter == filter;

            return Container(
              margin: EdgeInsets.only(
                right: index < controller.filterOptions.length - 1
                    ? AppConstants.spacingS
                    : 0,
              ),
              child: InkWell(
                onTap: () => controller.selectFilter(filter),
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
                child: AnimatedContainer(
                  duration: AppConstants.animationDuration,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingM,
                    vertical: AppConstants.spacingS,
                  ),
                  decoration: BoxDecoration(
                    gradient:
                        isSelected ? AppColors.buttonGradient : null,
                    color: isSelected
                        ? null
                        : isDark
                            ? Colors.white.withOpacity(0.1)
                            : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(AppConstants.radiusL),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : isDark
                              ? Colors.white.withOpacity(0.2)
                              : Colors.white.withOpacity(0.5),
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.gradientPurple.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      filter,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAlarmList(BuildContext context, HistoryController controller) {
    if (controller.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.alarms.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        left: AppConstants.spacingM,
        right: AppConstants.spacingM,
        bottom: 100,
      ),
      itemCount: controller.alarms.length,
      itemBuilder: (context, index) {
        final alarm = controller.alarms[index];
        return _buildAlarmCard(context, alarm, controller);
      },
    );
  }

  Widget _buildAlarmCard(
      BuildContext context, AlarmModel alarm, HistoryController controller) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isTimeAlarm = alarm.type == AlarmType.time;

    return Dismissible(
      key: Key(alarm.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.red, Colors.redAccent],
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusXL),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppConstants.spacingL),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 32,
        ),
      ),
      onDismissed: (direction) {
        controller.deleteAlarm(alarm.id);
      },
      child: GlassCard(
        margin: const EdgeInsets.only(bottom: AppConstants.spacingM),
        padding: const EdgeInsets.all(AppConstants.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                        isTimeAlarm
                            ? alarm.formattedTime
                            : alarm.locationName ?? '',
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
            const SizedBox(height: AppConstants.spacingM),

            // Additional Info
            Row(
              children: [
                _buildInfoChip(
                  context: context,
                  icon: Icons.calendar_today,
                  label: alarm.formattedDate,
                  isDark: isDark,
                ),
                const SizedBox(width: AppConstants.spacingS),
                _buildInfoChip(
                  context: context,
                  icon: isTimeAlarm ? Icons.schedule : Icons.my_location,
                  label: alarm.typeLabel,
                  isDark: isDark,
                ),
                if (alarm.repeat) ...[
                  const SizedBox(width: AppConstants.spacingS),
                  _buildInfoChip(
                    context: context,
                    icon: Icons.repeat,
                    label: 'Repeat',
                    isDark: isDark,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingS,
        vertical: AppConstants.spacingXS,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppConstants.radiusS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
          const SizedBox(width: AppConstants.spacingXS),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXL),
        child: GlassCard(
          padding: const EdgeInsets.all(AppConstants.spacingXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.history_outlined,
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
                'Your alarm history will appear here',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
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
