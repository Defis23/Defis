import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/event_repository.dart';
import '../../domain/event.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepository();
});

final eventProvider =
    AsyncNotifierProvider<EventNotifier, List<Event>>(EventNotifier.new);

class EventNotifier extends AsyncNotifier<List<Event>> {
  @override
  Future<List<Event>> build() async {
    final repository = ref.read(eventRepositoryProvider);
    return repository.getEvents();
  }

  Future<void> retry() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(eventRepositoryProvider);
      return repository.getEvents();
    });
  }
}