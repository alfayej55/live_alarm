import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

// Glassmorphism Slider Widget
class GlassSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final ValueChanged<double> onChanged;

  const GlassSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: AppColors.lightPrimary,
        inactiveTrackColor: AppColors.lightPrimary.withOpacity(0.3),
        thumbColor: AppColors.lightPrimary,
        overlayColor: AppColors.lightPrimary.withOpacity(0.2),
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        label: label ?? value.toStringAsFixed(0),
        onChanged: onChanged,
      ),
    );
  }
}
