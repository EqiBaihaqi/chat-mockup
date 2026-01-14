import 'package:test_project/app/domain/entity/chat_message.dart';
import 'package:test_project/app/domain/entity/chat_room.dart';

abstract class ChatRepository {
  // 1. Get List of Rooms
  Future<List<ChatRoom>> getChatRooms();

  // 2. Get Messages for a specific Room
  Future<List<ChatMessage>> getMessages(int chatRoomId);

  // 3. Send Message (Persist to DB)
  Future<void> sendMessage(int chatRoomId, int senderId, String message);

  // 4. Seed Initial Rooms (Requirement 2.5)
  Future<void> seedChatData();
}
