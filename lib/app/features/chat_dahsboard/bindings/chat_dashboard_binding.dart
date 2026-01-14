import 'package:get/get.dart';
import 'package:test_project/app/domain/repositories/chat_repository.dart';
import 'package:test_project/app/features/chat_dahsboard/controllers/chat_dashboard_controller.dart';

class ChatDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDashboardController>(
      () => ChatDashboardController(chatRepository: Get.find<ChatRepository>()),
    );
  }
}
