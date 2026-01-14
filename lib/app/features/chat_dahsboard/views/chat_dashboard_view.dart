import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_dashboard_controller.dart';
import '../models/chat_ui_model.dart';

class ChatDashboardView extends GetView<ChatDashboardController> {
  const ChatDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.message),
      ),
      // Reactive UI based on controller state
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.chatList.isEmpty) {
          return const Center(child: Text("No conversations yet"));
        }

        return ListView.separated(
          itemCount: controller.chatList.length,
          separatorBuilder: (_, __) => const Divider(height: 1, indent: 82),
          itemBuilder: (context, index) {
            final chat = controller.chatList[index];
            return _ChatTile(
              chat: chat,
              onTap: () => controller.onChatTap(chat.id),
            );
          },
        );
      }),
    );
  }
}

// Extracted Widget for cleaner code & performance
class _ChatTile extends StatelessWidget {
  final ChatUIModel chat;
  final VoidCallback onTap;

  const _ChatTile({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: onTap,
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(chat.avatarUrl),
      ),
      title: Text(
        chat.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          chat.lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chat.time,
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
          if (chat.unreadCount > 0) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.blue, // Use AppColors.primary
                shape: BoxShape.circle,
              ),
              child: Text(
                chat.unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
