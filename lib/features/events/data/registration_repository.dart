
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/app_logger.dart';

class RegistrationRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  RegistrationRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : firestore = firestore ?? FirebaseFirestore.instance,
        auth = auth ?? FirebaseAuth.instance;

  Future<void> register({
    required String eventId,
    required String eventName,
    required String name,
    required String email,
  }) async {
    AppLogger.info('Event registration process started.');

    final user = auth.currentUser;

    if (user == null) {
      throw StateError('Pengguna harus login untuk mendaftar event.');
    }

    try {
      await firestore.collection('rsvp').add({
        'eventId': eventId,
        'eventName': eventName,
        'userId': user.uid,
        'name': name.trim(),
        'email': email.trim(),
        'registeredAt': FieldValue.serverTimestamp(),
      });

      AppLogger.info('Event registration successful.');
    } on FirebaseException catch (e, stackTrace) {
      AppLogger.error(
        'Firebase registration failed.',
        error: e,
        stackTrace: stackTrace,
      );

      throw Exception(
        'Firebase error: ${e.code} - ${e.message}',
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Event registration failed.',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }
}
