import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_messenger/services/auth/auth_service.dart';
import 'package:minimal_messenger/services/chat/chat_services.dart';
import 'package:minimal_messenger/widgets/chat_bubble.dart';
import 'package:minimal_messenger/widgets/my_textfield.dart';

final ChatService chatServices = ChatService();
final AuthServices authService = AuthServices();

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.receiverEmail,
    required this.receiverId,
  });
  final String receiverEmail;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    void sendMessage() async {
      if (controller.text.isNotEmpty) {
        await chatServices.sendMessage(receiverId, controller.text);

        controller.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageList(
              receiverID: receiverId,
            ),
          ),
          UserInput(
            controller: controller,
            sendMessage: sendMessage,
          ),
        ],
      ),
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.receiverID});
  final String receiverID;

  @override
  Widget build(BuildContext context) {
    String senderID = authService.getCurrentuser()!.uid;
    return StreamBuilder(
      stream: chatServices.getMessage(receiverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading....");
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurentUser = data['senderID'] == authService.getCurrentuser()!.uid;

    var alignment =
        isCurentUser ? Alignment.centerRight : Alignment.centerRight;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            isCurrentUser: isCurentUser,
            message: data["message"],
          ),
        ],
      ),
    );
  }
}

class UserInput extends StatelessWidget {
  const UserInput(
      {super.key, required this.controller, required this.sendMessage});
  final TextEditingController controller;
  final void Function()? sendMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              hint: "Type a message",
              obsecure: false,
              controller: controller,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
