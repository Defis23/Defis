
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:robspace_mobile/features/events/data/event_repository.dart';

void main() {
  group('EventRepository API tests', () {
    test('API sukses mengembalikan daftar event', () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode([
            {
              'userId': 1,
              'id': 1,
              'title': 'ROBBER',
              'body': 'Nightlife event ROBSPACE.',
            },
          ]),
          200,
        );
      });

      final repository = EventRepository(client: client);
      final events = await repository.getEvents();

      expect(events.length, 1);
      expect(events.first.name, 'ROBBER');
      expect(events.first.location, 'API Demo');

      client.close();
    });

    test('API sukses dengan data kosong', () async {
      final client = MockClient((request) async {
        return http.Response('[]', 200);
      });

      final repository = EventRepository(client: client);
      final events = await repository.getEvents();

      expect(events, isEmpty);

      client.close();
    });

    test('HTTP gagal menghasilkan exception', () async {
      final client = MockClient((request) async {
        return http.Response('Server error', 500);
      });

      final repository = EventRepository(client: client);

      expect(
        () => repository.getEvents(),
        throwsA(isA<Exception>()),
      );

      client.close();
    });

    test('JSON rusak menghasilkan FormatException', () async {
      final client = MockClient((request) async {
        return http.Response('{json rusak', 200);
      });

      final repository = EventRepository(client: client);

      expect(
        () => repository.getEvents(),
        throwsA(isA<FormatException>()),
      );

      client.close();
    });
  });
}
