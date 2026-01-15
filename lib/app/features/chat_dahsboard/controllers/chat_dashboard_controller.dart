import 'package:get/get.dart';
import 'package:test_project/app/domain/entity/chat_room.dart';
import 'package:test_project/app/domain/usecases/get_chat_room_usecase.dart';
import 'package:test_project/app/routes/app_pages.dart';

class ChatDashboardController extends GetxController {
  final GetChatRoomUsecase getChatRoomUsecase;
  ChatDashboardController({required this.getChatRoomUsecase});

  // State
  final isLoading = true.obs;
  final chatList = <ChatRoom>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchChatList();
  }

  Future<void> _fetchChatList() async {
    try {
      isLoading.value = true;
      Future.delayed(Duration(seconds: 1));
      final rooms = await getChatRoomUsecase.execute();

      chatList.assignAll(rooms);
    } finally {
      isLoading.value = false;
    }
  }

  void onChatTap(int id) {
    // Navigate to chat detail
    Get.toNamed(Routes.chat, arguments: id);
  }
}
