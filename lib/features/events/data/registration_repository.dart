
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    final user = auth.currentUser;

    if (user == null) {
      throw StateError('Pengguna harus login untuk mendaftar event.');
    }

    await firestore.collection('registrations').add({
      'eventId': eventId,
      'eventName': eventName,
      'userId': user.uid,
      'name': name.trim(),
      'email': email.trim(),
      'registeredAt': FieldValue.serverTimestamp(),
    });
  }
}
