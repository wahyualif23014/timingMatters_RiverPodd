import 'package:firebase_database/firebase_database.dart';
import '../models/settings_model.dart';

class SettingsRepository {
  final _db = FirebaseDatabase.instance.ref();
  final String userId = 'user'; // kamu bisa sesuaikan dari auth nantinya

  Future<SettingsModel?> fetchSettings() async {
    final snapshot = await _db.child('settings/$userId').get();
    if (!snapshot.exists) return null;
    return SettingsModel.fromJson(
      Map<String, dynamic>.from(snapshot.value as Map),
    );
  }

  Future<void> updateSettings(SettingsModel settings) async {
    await _db.child('settings/$userId').set(settings.toJson());
  }
}
