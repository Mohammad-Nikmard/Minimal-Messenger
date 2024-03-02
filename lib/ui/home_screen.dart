import 'package:flutter/material.dart';
import 'package:minimal_messenger/services/auth/auth_service.dart';
import 'package:minimal_messenger/services/chat/chat_services.dart';
import 'package:minimal_messenger/ui/chat_screen.dart';
import 'package:minimal_messenger/widgets/my_drawer.dart';
import 'package:minimal_messenger/widgets/usertile.dart';

final ChatService _chatService = ChatService();
final AuthServices _authServices = AuthServices();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        title: const Text("HOME"),
        centerTitle: true,
      ),
      body: const BuildUserList(),
    );
  }
}

class BuildUserList extends StatelessWidget {
  const BuildUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _chatService.getuserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>(
                (userData) => BuilduserStreamList(
                  userData: userData,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class BuilduserStreamList extends StatelessWidget {
  const BuilduserStreamList({super.key, required this.userData});
  final Map<String, dynamic> userData;
  @override
  Widget build(BuildContext context) {
    if (userData['email'] != _authServices.getCurrentuser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                receiverEmail: userData["email"],
                receiverId: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
