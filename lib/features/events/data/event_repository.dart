
import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/event.dart';

class EventRepository {
  final FirebaseFirestore firestore;

  EventRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Event>> getEvents() async {
    final snapshot = await firestore.collection('events').get();

    return snapshot.docs.map((document) {
      final data = document.data();

      return Event.fromJson({
        'id': document.id,
        'name': data['name'],
        'location': data['location'],
        'date': data['date'],
        'description': data['description'],
      });
    }).toList();
  }
}
