import '../domain/event.dart';

class EventRepository {
  Future<List<Event>> getEvents() async {
    await Future<void>.delayed(
      const Duration(seconds: 2),
    );

    return const [
      Event(
        id: '1',
        name: 'ROBBER',
        location: 'PATS BSD',
        date: '05 October 2026',
        description: 'Nightlife event ROBSPACE.',
      ),
    ];
  }
}