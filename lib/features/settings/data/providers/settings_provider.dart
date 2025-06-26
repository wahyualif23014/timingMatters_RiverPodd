// data/providers/settings_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/settings_model.dart';
import '../repositories/settings_repository.dart';

final settingsRepositoryProvider = Provider((ref) => SettingsRepository());

final settingsProvider = FutureProvider<SettingsModel?>((ref) async {
  final repo = ref.watch(settingsRepositoryProvider);
  return await repo.fetchSettings();
});

final updateSettingsProvider = Provider.family<Future<void>, SettingsModel>((ref, settings) async {
  final repo = ref.watch(settingsRepositoryProvider);
  await repo.updateSettings(settings);
});
