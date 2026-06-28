// User Model
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final String language;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.notificationsEnabled = true,
    this.darkModeEnabled = false,
    this.language = 'English',
  });

  // Get initials
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, 2).toUpperCase();
  }

  // Copy with
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    String? language,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      language: language ?? this.language,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'notificationsEnabled': notificationsEnabled,
      'darkModeEnabled': darkModeEnabled,
      'language': language,
    };
  }

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      darkModeEnabled: json['darkModeEnabled'] ?? false,
      language: json['language'] ?? 'English',
    );
  }
}
