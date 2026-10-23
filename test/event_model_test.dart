
import 'package:flutter_test/flutter_test.dart';
import 'package:robspace_mobile/features/events/domain/event.dart';

void main() {
  group('Event model tests', () {
    test('Model valid berhasil dibuat dari JSON', () {
      final event = Event.fromJson({
        'id': 1,
        'name': 'ROBBER',
        'location': 'PATS BSD',
        'date': '05 October 2026',
        'description': 'Nightlife event ROBSPACE.',
      });

      expect(event.id, '1');
      expect(event.name, 'ROBBER');
      expect(event.location, 'PATS BSD');
    });

    test('Model tidak valid menghasilkan FormatException', () {
      expect(
        () => Event.fromJson({
          'id': 1,
          'name': '',
          'location': 'PATS BSD',
          'date': '05 October 2026',
          'description': 'Nightlife event ROBSPACE.',
        }),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
