import '../models/alarm_model.dart';
import '../models/user_model.dart';
import '../models/statistics_model.dart';
import '../utils/constants.dart';

// Dummy Data Helper
class DummyData {
  // Dummy User
  static UserModel get dummyUser => UserModel(
        id: '1',
        name: AppConstants.dummyUserName,
        email: AppConstants.dummyUserEmail,
        notificationsEnabled: true,
        darkModeEnabled: false,
        language: 'English',
      );

  // Dummy Statistics
  static StatisticsModel get dummyStatistics => StatisticsModel(
        totalAlarms: 12,
        timeAlarms: 7,
        locationAlarms: 5,
        activeAlarms: 8,
        completedAlarms: 3,
        missedAlarms: 1,
      );

  // Dummy Alarms
  static List<AlarmModel> get dummyAlarms => [
        AlarmModel(
          id: '1',
          title: 'Morning Workout',
          type: AlarmType.time,
          status: AlarmStatus.active,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          scheduledTime: DateTime.now().add(const Duration(hours: 8)),
          repeat: true,
          repeatDays: [1, 3, 5], // Mon, Wed, Fri
          soundName: 'Default',
          vibrate: true,
          enabled: true,
        ),
        AlarmModel(
          id: '2',
          title: 'Reach Office',
          type: AlarmType.location,
          status: AlarmStatus.active,
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          locationName: 'Office - Downtown',
          latitude: 37.7749,
          longitude: -122.4194,
          radius: 500,
          soundName: 'Chime',
          vibrate: true,
          enabled: true,
        ),
        AlarmModel(
          id: '3',
          title: 'Team Meeting',
          type: AlarmType.time,
          status: AlarmStatus.active,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          scheduledTime: DateTime.now().add(const Duration(hours: 2)),
          repeat: false,
          soundName: 'Bell',
          vibrate: true,
          enabled: true,
        ),
        AlarmModel(
          id: '4',
          title: 'Grocery Store Reminder',
          type: AlarmType.location,
          status: AlarmStatus.active,
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          locationName: 'Whole Foods Market',
          latitude: 37.7849,
          longitude: -122.4094,
          radius: 300,
          soundName: 'Ding',
          vibrate: false,
          enabled: true,
        ),
        AlarmModel(
          id: '5',
          title: 'Lunch Break',
          type: AlarmType.time,
          status: AlarmStatus.completed,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          scheduledTime: DateTime.now().subtract(const Duration(hours: 2)),
          repeat: true,
          repeatDays: [1, 2, 3, 4, 5], // Weekdays
          soundName: 'Default',
          vibrate: true,
          enabled: true,
        ),
        AlarmModel(
          id: '6',
          title: 'Home Arrival',
          type: AlarmType.location,
          status: AlarmStatus.completed,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          locationName: 'Home',
          latitude: 37.7649,
          longitude: -122.4394,
          radius: 200,
          soundName: 'Chime',
          vibrate: true,
          enabled: false,
        ),
        AlarmModel(
          id: '7',
          title: 'Evening Yoga',
          type: AlarmType.time,
          status: AlarmStatus.active,
          createdAt: DateTime.now().subtract(const Duration(days: 4)),
          scheduledTime: DateTime.now().add(const Duration(hours: 6)),
          repeat: true,
          repeatDays: [2, 4, 6], // Tue, Thu, Sat
          soundName: 'Zen',
          vibrate: false,
          enabled: true,
        ),
        AlarmModel(
          id: '8',
          title: 'Pharmacy Pickup',
          type: AlarmType.location,
          status: AlarmStatus.inactive,
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
          locationName: 'CVS Pharmacy',
          latitude: 37.7549,
          longitude: -122.4294,
          radius: 250,
          soundName: 'Alert',
          vibrate: true,
          enabled: false,
        ),
        AlarmModel(
          id: '9',
          title: 'Bedtime Reminder',
          type: AlarmType.time,
          status: AlarmStatus.active,
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
          scheduledTime: DateTime.now().add(const Duration(hours: 12)),
          repeat: true,
          repeatDays: [1, 2, 3, 4, 5, 6, 7], // Every day
          soundName: 'Calm',
          vibrate: false,
          enabled: true,
        ),
        AlarmModel(
          id: '10',
          title: 'Gym Location',
          type: AlarmType.location,
          status: AlarmStatus.missed,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          locationName: '24 Hour Fitness',
          latitude: 37.7449,
          longitude: -122.4494,
          radius: 400,
          soundName: 'Beep',
          vibrate: true,
          enabled: true,
        ),
        AlarmModel(
          id: '11',
          title: 'Water Reminder',
          type: AlarmType.time,
          status: AlarmStatus.active,
          createdAt: DateTime.now(),
          scheduledTime: DateTime.now().add(const Duration(hours: 1)),
          repeat: true,
          repeatDays: [1, 2, 3, 4, 5, 6, 7],
          soundName: 'Drop',
          vibrate: false,
          enabled: true,
        ),
        AlarmModel(
          id: '12',
          title: 'Coffee Shop Arrival',
          type: AlarmType.location,
          status: AlarmStatus.active,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          locationName: 'Starbucks Reserve',
          latitude: 37.7949,
          longitude: -122.3994,
          radius: 150,
          soundName: 'Ding',
          vibrate: true,
          enabled: true,
        ),
      ];

  // Get active alarms only
  static List<AlarmModel> get activeAlarms =>
      dummyAlarms.where((alarm) => alarm.enabled).toList();

  // Get time alarms only
  static List<AlarmModel> get timeAlarms =>
      dummyAlarms.where((alarm) => alarm.type == AlarmType.time).toList();

  // Get location alarms only
  static List<AlarmModel> get locationAlarms =>
      dummyAlarms.where((alarm) => alarm.type == AlarmType.location).toList();

  // Get recent alarms (last 5)
  static List<AlarmModel> get recentAlarms {
    final sorted = List<AlarmModel>.from(dummyAlarms)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.take(5).toList();
  }
}
