
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:robspace_mobile/features/events/data/event_repository.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  group('EventRepository Firestore tests', () {
    test('Firestore error diteruskan oleh repository', () async {
      final firestore = MockFirebaseFirestore();

      when(() => firestore.collection('events')).thenThrow(
        FirebaseException(
          plugin: 'cloud_firestore',
          code: 'unavailable',
          message: 'Firestore tidak tersedia.',
        ),
      );

      final repository = EventRepository(firestore: firestore);

      expect(
        () => repository.getEvents(),
        throwsA(isA<FirebaseException>()),
      );
    });
  });
}
