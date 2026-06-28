import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/set_alarm_controller.dart';
import '../../utils/constants.dart';
import '../widget/glass_card.dart';
import '../widget/glass_text_field.dart';
import '../widget/glass_button.dart';
import '../widget/glass_switch.dart';
import '../widget/glass_slider.dart';
import '../../themes/app_colors.dart';

// Set Alarm Screen
class SetAlarmScreen extends StatelessWidget {
  const SetAlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SetAlarmController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingM),
              child: Text(
                'Set Alarm',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            // Tab Bar
            _buildTabBar(context, controller, isDark),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  _buildTimeAlarmTab(context, controller),
                  _buildLocationAlarmTab(context, controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, SetAlarmController controller, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.spacingM),
      padding: const EdgeInsets.all(AppConstants.spacingXS),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(AppConstants.radiusL),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.15)
                    : Colors.white.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: TabBar(
              controller: controller.tabController,
              indicator: BoxDecoration(
                gradient: AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(AppConstants.radiusM),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
              labelStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
              tabs: const [
                Tab(
                  icon: Icon(Icons.access_time),
                  text: 'Time Alarm',
                ),
                Tab(
                  icon: Icon(Icons.location_on),
                  text: 'Location Alarm',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeAlarmTab(BuildContext context, SetAlarmController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppConstants.spacingM),

          // Alarm Title
          Text(
            'Alarm Title',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          GlassTextField(
            hintText: 'Enter alarm title',
            controller: controller.titleController,
            prefixIcon: Icons.edit_outlined,
            onChanged: (value) => controller.updateTitle(value),
          ),
          const SizedBox(height: AppConstants.spacingL),

          // Time Picker
          Text(
            'Select Time',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          Obx(
            () => GlassCard(
              onTap: () => controller.selectTime(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 24),
                      const SizedBox(width: AppConstants.spacingM),
                      Text(
                        controller.selectedTime.format(context),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingL),

          // Repeat
          Text(
            'Repeat',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          Obx(
            () => GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Repeat alarm',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  GlassSwitch(
                    value: controller.repeatEnabled,
                    onChanged: (value) => controller.toggleRepeat(value),
                  ),
                ],
              ),
            ),
          ),

          // Repeat Days
          Obx(
            () => controller.repeatEnabled
                ? Column(
                    children: [
                      const SizedBox(height: AppConstants.spacingM),
                      GlassCard(
                        child: Wrap(
                          spacing: AppConstants.spacingS,
                          runSpacing: AppConstants.spacingS,
                          children: List.generate(7, (index) {
                            final day = index + 1;
                            final isSelected = controller.selectedDays.contains(day);
                            return InkWell(
                              onTap: () => controller.toggleDay(day),
                              borderRadius:
                                  BorderRadius.circular(AppConstants.radiusS),
                              child: AnimatedContainer(
                                duration: AppConstants.animationDuration,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppConstants.spacingM,
                                  vertical: AppConstants.spacingS,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? AppColors.buttonGradient
                                      : null,
                                  color: isSelected
                                      ? null
                                      : Colors.grey.withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.circular(AppConstants.radiusS),
                                ),
                                child: Text(
                                  controller.dayLabels[index],
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: isSelected
                                            ? Colors.white
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.color,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                      ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
          const SizedBox(height: AppConstants.spacingL),

          // Alarm Sound
          Text(
            'Alarm Sound',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          Obx(
            () => GlassCard(
              child: Column(
                children: List.generate(
                  controller.soundOptions.length,
                  (index) {
                    final sound = controller.soundOptions[index];
                    final isSelected = controller.selectedSound == sound;
                    return Column(
                      children: [
                        InkWell(
                          onTap: () => controller.selectSound(sound),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppConstants.spacingS,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  sound,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.lightPrimary,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        if (index < controller.soundOptions.length - 1)
                          Divider(
                            color: Colors.grey.withOpacity(0.2),
                            height: 1,
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingXL),

          // Save Button
          GlassButton(
            text: 'Save Time Alarm',
            onPressed: () => controller.saveTimeAlarm(),
            width: double.infinity,
            icon: Icons.check,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildLocationAlarmTab(BuildContext context, SetAlarmController controller) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppConstants.spacingM),

          // Alarm Title
          Text(
            'Alarm Title',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          GlassTextField(
            hintText: 'Enter alarm title',
            controller: controller.titleController,
            prefixIcon: Icons.edit_outlined,
            onChanged: (value) => controller.updateTitle(value),
          ),
          const SizedBox(height: AppConstants.spacingL),

          // Select Location
          Text(
            'Select Location',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          GlassCard(
            onTap: () => controller.selectLocation(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 24),
                    const SizedBox(width: AppConstants.spacingM),
                    Obx(
                      () => Text(
                        controller.locationName.isEmpty
                            ? 'Choose location'
                            : controller.locationName,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingL),

          // Radius Slider
          Text(
            'Radius',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppConstants.spacingS),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trigger radius',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        '${controller.radius.toInt()} m',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightPrimary,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.spacingS),
                Obx(
                  () => GlassSlider(
                    value: controller.radius,
                    min: 100,
                    max: 2000,
                    divisions: 19,
                    onChanged: (value) => controller.updateRadius(value),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingXS),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '100m',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '2000m',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingL),

          // Location Preview Card
          Obx(
            () => controller.locationName.isNotEmpty
                ? GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location Preview',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: AppConstants.spacingM),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius:
                                BorderRadius.circular(AppConstants.radiusM),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.map_outlined,
                                  size: 48,
                                ),
                                const SizedBox(height: AppConstants.spacingS),
                                Text(
                                  'Map Preview',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingM),
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 12,
                              color: AppColors.lightPrimary,
                            ),
                            const SizedBox(width: AppConstants.spacingS),
                            Expanded(
                              child: Text(
                                controller.locationName,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
          const SizedBox(height: AppConstants.spacingXL),

          // Save Button
          GlassButton(
            text: 'Save Location Alarm',
            onPressed: () => controller.saveLocationAlarm(),
            width: double.infinity,
            icon: Icons.check,
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
