import 'package:get/get.dart';
import 'package:test_project/app/domain/repositories/chat_repository.dart';
import 'package:test_project/app/features/chat_dahsboard/models/chat_ui_model.dart';

class ChatDashboardController extends GetxController {
  // Inject Repository (Matches your DI setup)
  final ChatRepository chatRepository;
  ChatDashboardController({required this.chatRepository});

  // State
  final isLoading = true.obs;
  final chatList = <ChatUIModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchChatList();
  }

  Future<void> _fetchChatList() async {
    try {
      isLoading.value = true;
      // In real app: await chatRepository.getChats();
      // Simulating network delay and data for UI demo
      await Future.delayed(const Duration(seconds: 1));

      chatList.assignAll([
        ChatUIModel(
          id: '1',
          name: 'John Doe',
          lastMessage: 'Hey, are we still on for tomorrow?',
          time: '10:30 AM',
          avatarUrl: 'https://i.pravatar.cc/150?u=1',
          unreadCount: 2,
        ),
        ChatUIModel(
          id: '2',
          name: 'Jane Smith',
          lastMessage: 'Project files attached.',
          time: 'Yesterday',
          avatarUrl: 'https://i.pravatar.cc/150?u=2',
        ),
      ]);
    } finally {
      isLoading.value = false;
    }
  }

  void onChatTap(String id) {
    // Navigate to chat detail
    // Get.toNamed(Routes.CHAT_DETAIL, arguments: id);
  }
}
