import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final user = FirebaseAuth.instance;
  Future<void> signIn(String email, password) async {
    try {
      await user.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      Exception(ex.message);
    }
  }

  Future<void> signOut() async {
    await user.signOut();
  }

  Future<void> signUp(String email, password) async {
    try {
      await user.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      Exception(ex.message);
    }
  }
}
