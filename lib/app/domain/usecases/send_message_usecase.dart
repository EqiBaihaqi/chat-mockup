import 'package:test_project/app/domain/repositories/chat_repository.dart';

class SendMessageUsecase {
  SendMessageUsecase(this._chatRepository);
  final ChatRepository _chatRepository;

  Future<void> execute(int chatRoomId, int senderId, String message) async {
    return await _chatRepository.sendMessage(chatRoomId, senderId, message);
  }
}
