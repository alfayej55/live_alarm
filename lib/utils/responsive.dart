import 'package:flutter/material.dart';

// Responsive utility class using MediaQuery
class Responsive {
  final BuildContext context;

  Responsive(this.context);

  // Screen dimensions
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // Device type
  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 900;
  bool get isDesktop => width >= 900;

  // Safe area
  EdgeInsets get padding => MediaQuery.of(context).padding;
  double get topPadding => MediaQuery.of(context).padding.top;
  double get bottomPadding => MediaQuery.of(context).padding.bottom;

  // Responsive spacing
  double sp(double size) => size * (width / 375);

  // Responsive font size
  double fs(double size) => size * (width / 375);

  // Responsive dimension
  double h(double size) => size * (height / 812);
  double w(double size) => size * (width / 375);
}

// Extension for easy access
extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);
}
