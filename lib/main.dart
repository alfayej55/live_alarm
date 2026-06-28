import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'themes/app_theme.dart';
import 'utils/app_pages.dart';
import 'utils/app_routes.dart';
import 'utils/constants.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const GeoAlarmApp());
}

class GeoAlarmApp extends StatelessWidget {
  const GeoAlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // App Info
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      // Routing
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
      unknownRoute: AppPages.unknownRoute,

      // Default Transitions
      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),

      // Builder for edge-to-edge design
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                Theme.of(context).brightness == Brightness.dark
                    ? Brightness.light
                    : Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness:
                Theme.of(context).brightness == Brightness.dark
                    ? Brightness.light
                    : Brightness.dark,
          ),
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
