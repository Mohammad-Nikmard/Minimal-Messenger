import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.text, required this.onTap});
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25.0),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(
              width: 20.0,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
