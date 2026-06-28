// GeoAlarm Widget Tests
//
// Basic tests for the GeoAlarm application.
// In a production app, you would add comprehensive tests for all features.

import 'package:flutter_test/flutter_test.dart';
import 'package:geoalarm/main.dart';

void main() {
  testWidgets('GeoAlarm app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GeoAlarmApp());

    // Wait for any async operations
    await tester.pumpAndSettle();

    // Verify that the app launches without errors
    // The splash screen should be displayed initially
    expect(find.byType(GeoAlarmApp), findsOneWidget);
  });
}
