
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../domain/event.dart';

class EventRepository {
  final http.Client client;

  EventRepository({http.Client? client})
      : client = client ?? http.Client();

  Future<List<Event>> getEvents() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengambil data event. HTTP ${response.statusCode}',
      );
    }

    final dynamic decodedData = jsonDecode(response.body);

    if (decodedData is! List) {
      throw const FormatException(
        'Format data API tidak valid.',
      );
    }

    return decodedData.map<Event>((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException(
          'Format event tidak valid.',
        );
      }

      return Event.fromJson({
        'id': item['id'],
        'name': item['title'],
        'location': 'API Demo',
        'date': 'Data dari API',
        'description': item['body'],
      });
    }).toList();
  }
}
