import 'package:get/get.dart';
import 'package:test_project/app/domain/repositories/chat_repository.dart';
import 'package:test_project/app/domain/usecases/get_chat_room_usecase.dart';
import 'package:test_project/app/features/chat_dahsboard/controllers/chat_dashboard_controller.dart';

class ChatDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDashboardController>(
      () => ChatDashboardController(
        getChatRoomUsecase: Get.find<GetChatRoomUsecase>(),
      ),
    );
    Get.lazyPut<GetChatRoomUsecase>(
      () => GetChatRoomUsecase(Get.find<ChatRepository>()),
    );
  }
}
