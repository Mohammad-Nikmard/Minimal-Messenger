import 'package:flutter/material.dart';
import 'package:minimal_messenger/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isCurrentUser,
    required this.message,
  });
  final String message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.5),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? isDarkMode
                ? Colors.green.shade600
                : Colors.green.shade500
            : isDarkMode
                ? Colors.grey.shade800
                : Colors.grey.shade200,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser
              ? Colors.white
              : isDarkMode
                  ? Colors.white
                  : Colors.black,
        ),
      ),
    );
  }
}
