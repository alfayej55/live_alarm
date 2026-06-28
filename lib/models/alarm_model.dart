import 'package:intl/intl.dart';

// Alarm Type Enum
enum AlarmType {
  time,
  location,
}

// Alarm Status Enum
enum AlarmStatus {
  active,
  inactive,
  completed,
  missed,
}

// Alarm Model
class AlarmModel {
  final String id;
  final String title;
  final AlarmType type;
  final AlarmStatus status;
  final DateTime createdAt;
  final DateTime? scheduledTime;
  final String? locationName;
  final double? latitude;
  final double? longitude;
  final double? radius;
  final bool repeat;
  final List<int>? repeatDays; // 1-7 (Monday-Sunday)
  final String? soundName;
  final bool vibrate;
  final bool enabled;

  AlarmModel({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    required this.createdAt,
    this.scheduledTime,
    this.locationName,
    this.latitude,
    this.longitude,
    this.radius,
    this.repeat = false,
    this.repeatDays,
    this.soundName,
    this.vibrate = true,
    this.enabled = true,
  });

  // Format time
  String get formattedTime {
    if (scheduledTime == null) return '';
    return DateFormat('hh:mm a').format(scheduledTime!);
  }

  // Format date
  String get formattedDate {
    return DateFormat('MMM dd, yyyy').format(createdAt);
  }

  // Get type label
  String get typeLabel {
    return type == AlarmType.time ? 'Time Alarm' : 'Location Alarm';
  }

  // Get status label
  String get statusLabel {
    switch (status) {
      case AlarmStatus.active:
        return 'Active';
      case AlarmStatus.inactive:
        return 'Inactive';
      case AlarmStatus.completed:
        return 'Completed';
      case AlarmStatus.missed:
        return 'Missed';
    }
  }

  // Copy with
  AlarmModel copyWith({
    String? id,
    String? title,
    AlarmType? type,
    AlarmStatus? status,
    DateTime? createdAt,
    DateTime? scheduledTime,
    String? locationName,
    double? latitude,
    double? longitude,
    double? radius,
    bool? repeat,
    List<int>? repeatDays,
    String? soundName,
    bool? vibrate,
    bool? enabled,
  }) {
    return AlarmModel(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      locationName: locationName ?? this.locationName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
      repeat: repeat ?? this.repeat,
      repeatDays: repeatDays ?? this.repeatDays,
      soundName: soundName ?? this.soundName,
      vibrate: vibrate ?? this.vibrate,
      enabled: enabled ?? this.enabled,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type.toString(),
      'status': status.toString(),
      'createdAt': createdAt.toIso8601String(),
      'scheduledTime': scheduledTime?.toIso8601String(),
      'locationName': locationName,
      'latitude': latitude,
      'longitude': longitude,
      'radius': radius,
      'repeat': repeat,
      'repeatDays': repeatDays,
      'soundName': soundName,
      'vibrate': vibrate,
      'enabled': enabled,
    };
  }

  // From JSON
  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'],
      title: json['title'],
      type: AlarmType.values.firstWhere(
        (e) => e.toString() == json['type'],
      ),
      status: AlarmStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      createdAt: DateTime.parse(json['createdAt']),
      scheduledTime: json['scheduledTime'] != null
          ? DateTime.parse(json['scheduledTime'])
          : null,
      locationName: json['locationName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      radius: json['radius'],
      repeat: json['repeat'] ?? false,
      repeatDays: json['repeatDays'] != null
          ? List<int>.from(json['repeatDays'])
          : null,
      soundName: json['soundName'],
      vibrate: json['vibrate'] ?? true,
      enabled: json['enabled'] ?? true,
    );
  }
}
