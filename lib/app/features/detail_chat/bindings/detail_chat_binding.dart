import 'package:get/instance_manager.dart';
import 'package:test_project/app/domain/repositories/chat_repository.dart';
import 'package:test_project/app/domain/usecases/get_messages_usecase.dart';
import 'package:test_project/app/domain/usecases/send_message_usecase.dart';
import 'package:test_project/app/features/detail_chat/controllers/detail_chat_controller.dart';
import 'package:test_project/app/utils/session/session_manager.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailChatController>(
      () => DetailChatController(
        Get.find<GetMessagesUsecase>(),
        Get.find<SendMessageUsecase>(),
        Get.find<SessionManager>(),
      ),
    );
    Get.lazyPut<GetMessagesUsecase>(
      () => GetMessagesUsecase(Get.find<ChatRepository>()),
    );
    Get.lazyPut<SendMessageUsecase>(
      () => SendMessageUsecase(Get.find<ChatRepository>()),
    );
    Get.lazyPut<SessionManager>(() => SessionManagerImpl());
  }
}
