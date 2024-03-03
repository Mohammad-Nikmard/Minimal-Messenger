import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minimal_messenger/data/model/message.dart';

class ChatService {
  final FirebaseFirestore database;
  final FirebaseAuth _auth;

  ChatService(this._auth, this.database);

  Stream<List<Map<String, dynamic>>> getuserStream() {
    return database.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timeStamp = Timestamp.now();

    Message newMessage = Message(
      message,
      receiverID,
      currentUserEmail,
      currentUserID,
      timeStamp,
    );

    List<String> ids = [currentUserID, receiverID];
    ids.sort();
    String chatRoomId = ids.join("_");

    await database
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("message")
        .add(
          newMessage.toMap(),
        );
  }

  Stream<QuerySnapshot> getMessage(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join("_");

    return database
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }
}
