import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/features/chat_dahsboard/widgets/chat_tile.dart';
import '../controllers/chat_dashboard_controller.dart';

class ChatDashboardView extends GetView<ChatDashboardController> {
  const ChatDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.showDialogLogout(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.chatList.isEmpty) {
          return const Center(child: Text("No conversations yet"));
        }

        return ListView.separated(
          itemCount: controller.chatList.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final chat = controller.chatList[index];
            return ChatTile(
              chat: chat,
              onTap: () => controller.onChatTap(chat.id),
            );
          },
        );
      }),
    );
  }
}
