import 'package:get/get.dart';
import 'package:test_project/app/core/widgets/logout_dialog.dart';
import 'package:test_project/app/domain/entity/chat_room.dart';
import 'package:test_project/app/domain/usecases/get_chat_room_usecase.dart';
import 'package:test_project/app/routes/app_pages.dart';
import 'package:test_project/app/utils/session/session_manager.dart';

class ChatDashboardController extends GetxController {
  ChatDashboardController(this.getChatRoomUsecase, this._session);

  final GetChatRoomUsecase getChatRoomUsecase;

  // State
  final isLoading = true.obs;
  final chatList = <ChatRoom>[].obs;
  final SessionManager _session;

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

  void onChatTap(int id, String roomName) {
    // Navigate to chat detail
    Get.toNamed(
      Routes.chat,
      arguments: {'roomId': id, 'roomName': roomName},
    );
  }

  void showDialogLogout() {
    Get.dialog(LogoutDialog(onConfirm: () => logout()));
  }

  Future<void> logout() async {
    try {
      await _session.clearAll();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
