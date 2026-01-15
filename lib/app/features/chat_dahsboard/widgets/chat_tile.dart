// Extracted Widget for cleaner code & performance
import 'package:flutter/material.dart';
import 'package:test_project/app/domain/entity/chat_room.dart';

class ChatTile extends StatelessWidget {
  final ChatRoom chat;
  final VoidCallback onTap;

  const ChatTile({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: onTap,
      title: Text(
        chat.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
