import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth user;
  final FirebaseFirestore _database;

  AuthServices(this._database, this.user);

  User? getCurrentuser() {
    return user.currentUser;
  }

  Future<UserCredential> signIn(String email, password) async {
    try {
      final UserCredential userCredential = await user
          .signInWithEmailAndPassword(email: email, password: password);
      _database
          .collection("Users")
          .doc(
            userCredential.user!.uid,
          )
          .set(
        {
          "uid": userCredential.user!.uid,
          "email": email,
        },
      );
      return userCredential;
    } on FirebaseAuthException catch (ex) {
      throw Exception(ex.message);
    }
  }

  Future<void> signOut() async {
    await user.signOut();
  }

  Future<UserCredential> signUp(String email, password) async {
    try {
      final UserCredential userCredential = await user
          .createUserWithEmailAndPassword(email: email, password: password);
      _database
          .collection("Users")
          .doc(
            userCredential.user!.uid,
          )
          .set(
        {
          "uid": userCredential.user!.uid,
          "email": email,
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (ex) {
      throw Exception(ex.message);
    }
  }
}
