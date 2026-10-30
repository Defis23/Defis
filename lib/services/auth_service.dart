

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth? firebaseAuth;

  AuthService({this.firebaseAuth});

  FirebaseAuth get _auth => firebaseAuth ?? FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password) async {
    return _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
