import 'dart:ui';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

// Glassmorphism ListTile Widget
class GlassListTile extends StatelessWidget {
  final IconData? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const GlassListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: AppConstants.spacingM),
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
            child: ListTile(
              leading: leading != null
                  ? Icon(
                      leading,
                      size: 24,
                    )
                  : null,
              title: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : null,
              trailing: trailing,
              onTap: onTap,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingM,
                vertical: AppConstants.spacingS,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
