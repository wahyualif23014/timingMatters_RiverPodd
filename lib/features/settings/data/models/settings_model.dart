import '../../domain/entities/settings_entity.dart';

class SettingsModel extends SettingsEntity {
  SettingsModel({
    required super.darkMode,
    required super.notificationsEnabled,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      darkMode: json['darkMode'],
      notificationsEnabled: json['notificationsEnabled'],
    );
  }

  Map<String, dynamic> toJson() => {
        'darkMode': darkMode,
        'notificationsEnabled': notificationsEnabled,
      };
}