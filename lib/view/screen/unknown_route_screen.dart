import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../themes/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/app_routes.dart';
import '../widget/glass_card.dart';
import '../widget/glass_button.dart';

// Unknown Route Screen (404 Page)
class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingXL),
              child: GlassCard(
                padding: const EdgeInsets.all(AppConstants.spacingXL),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Error Icon
                    Icon(
                      Icons.error_outline,
                      size: 80,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    const SizedBox(height: AppConstants.spacingL),

                    // Error Code
                    Text(
                      '404',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppConstants.spacingM),

                    // Error Message
                    Text(
                      'Page Not Found',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstants.spacingS),

                    // Description
                    Text(
                      'The page you are looking for does not exist or has been moved.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstants.spacingXL),

                    // Go Home Button
                    GlassButton(
                      text: 'Go to Home',
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.home);
                      },
                      width: double.infinity,
                      icon: Icons.home,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
