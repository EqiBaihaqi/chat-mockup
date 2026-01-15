import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:test_project/app/core/theme/app_textstyle.dart';
import 'package:test_project/app/features/detail_chat/controllers/detail_chat_controller.dart';

class DetailChatView extends GetView<DetailChatController> {
  const DetailChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.chatRoomName, style: AppTextStyles.bodyMedium),
        elevation: 1,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Chat(
          currentUserId: controller.currentUser.id,
          resolveUser: controller.resolveUser,
          chatController: controller.chatUIController,
          onMessageSend: controller.handleSendPressed,
          builders: Builders(
            chatMessageBuilder:
                (
                  context,
                  message,
                  index,
                  animation,
                  child, {
                  isRemoved,
                  isSentByMe = false,
                  groupStatus,
                }) {
                  return ChatMessage(
                    message: message,
                    index: index,
                    animation: animation,
                    isRemoved: isRemoved,
                    groupStatus: groupStatus,
                    topWidget: Username(userId: message.authorId),
                    child: child,
                  );
                },
          ),
        );
      }),
    );
  }
}
