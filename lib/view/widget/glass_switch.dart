import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

// Glassmorphism Switch Widget
class GlassSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const GlassSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.lightPrimary,
      activeTrackColor: AppColors.lightPrimary.withOpacity(0.5),
      inactiveThumbColor: Colors.grey[400],
      inactiveTrackColor: Colors.grey[300],
    );
  }
}
