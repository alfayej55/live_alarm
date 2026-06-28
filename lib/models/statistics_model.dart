// Statistics Model
class StatisticsModel {
  final int totalAlarms;
  final int timeAlarms;
  final int locationAlarms;
  final int activeAlarms;
  final int completedAlarms;
  final int missedAlarms;

  StatisticsModel({
    required this.totalAlarms,
    required this.timeAlarms,
    required this.locationAlarms,
    required this.activeAlarms,
    required this.completedAlarms,
    required this.missedAlarms,
  });

  // Copy with
  StatisticsModel copyWith({
    int? totalAlarms,
    int? timeAlarms,
    int? locationAlarms,
    int? activeAlarms,
    int? completedAlarms,
    int? missedAlarms,
  }) {
    return StatisticsModel(
      totalAlarms: totalAlarms ?? this.totalAlarms,
      timeAlarms: timeAlarms ?? this.timeAlarms,
      locationAlarms: locationAlarms ?? this.locationAlarms,
      activeAlarms: activeAlarms ?? this.activeAlarms,
      completedAlarms: completedAlarms ?? this.completedAlarms,
      missedAlarms: missedAlarms ?? this.missedAlarms,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'totalAlarms': totalAlarms,
      'timeAlarms': timeAlarms,
      'locationAlarms': locationAlarms,
      'activeAlarms': activeAlarms,
      'completedAlarms': completedAlarms,
      'missedAlarms': missedAlarms,
    };
  }

  // From JSON
  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      totalAlarms: json['totalAlarms'] ?? 0,
      timeAlarms: json['timeAlarms'] ?? 0,
      locationAlarms: json['locationAlarms'] ?? 0,
      activeAlarms: json['activeAlarms'] ?? 0,
      completedAlarms: json['completedAlarms'] ?? 0,
      missedAlarms: json['missedAlarms'] ?? 0,
    );
  }
}
