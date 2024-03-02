import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final database = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getuserStream() {
    return database.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }
}
