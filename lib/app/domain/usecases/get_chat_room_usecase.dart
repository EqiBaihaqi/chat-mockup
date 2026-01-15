import 'package:test_project/app/domain/entity/chat_room.dart';
import 'package:test_project/app/domain/repositories/chat_repository.dart';

class GetChatRoomUsecase {
  GetChatRoomUsecase(this._chatRepository);
  final ChatRepository _chatRepository;

  Future<List<ChatRoom>> execute() async {
    return await _chatRepository.getChatRooms();
  }
}
