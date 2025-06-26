// data/providers/calendar_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/event_model.dart';
import '../repositories/calendar_repository.dart';

final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  return CalendarRepository();
});

final eventsProvider = FutureProvider<List<EventModel>>((ref) async {
  final repo = ref.watch(calendarRepositoryProvider);
  return repo.fetchEvents();
});

final addEventProvider = Provider.family<Future<void>, EventModel>((ref, model) async {
  final repo = ref.watch(calendarRepositoryProvider);
  await repo.addEvent(model);
});

final deleteEventProvider = Provider.family<Future<void>, String>((ref, id) async {
  final repo = ref.watch(calendarRepositoryProvider);
  await repo.deleteEvent(id);
});

final updateEventProvider = Provider.family<Future<void>, EventModel>((ref, model) async {
  final repo = ref.watch(calendarRepositoryProvider);
  await repo.updateEvent(model);
});
