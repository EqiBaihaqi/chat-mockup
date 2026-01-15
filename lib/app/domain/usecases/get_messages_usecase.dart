import 'package:test_project/app/domain/entity/chat_message.dart';
import 'package:test_project/app/domain/repositories/chat_repository.dart';

class GetMessagesUsecase {
  GetMessagesUsecase(this._chatRepository);
  final ChatRepository _chatRepository;

  Future<List<ChatMessage>> execute(int chatRoomId) async {
    return await _chatRepository.getMessages(chatRoomId);
  }
}
