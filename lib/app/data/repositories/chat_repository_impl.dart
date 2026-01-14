import 'package:test_project/app/domain/entity/chat_message.dart';
import 'package:test_project/app/domain/entity/chat_room.dart';
import 'package:test_project/app/domain/repositories/chat_repository.dart';
import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';
import '../../../objectbox.g.dart'; // generated file

class ChatRepositoryImpl implements ChatRepository {
  final Box<ChatRoomModel> _roomBox;
  final Box<ChatMessageModel> _messageBox;

  ChatRepositoryImpl(Store store)
    : _roomBox = store.box<ChatRoomModel>(),
      _messageBox = store.box<ChatMessageModel>();

  @override
  Future<List<ChatRoom>> getChatRooms() async {
    final roomModels = _roomBox.getAll();
    return roomModels.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<ChatMessage>> getMessages(int chatRoomId) async {
    // Query: Find messages where the 'chatRoom' relation matches this ID
    final query = _messageBox
        .query(ChatMessageModel_.chatRoom.equals(chatRoomId))
        .order(ChatMessageModel_.timestamp) // Oldest first
        .build();

    final messageModels = query.find();
    query.close();

    return messageModels.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> sendMessage(int chatRoomId, int senderId, String message) async {
    // 1. Create Model
    final msgModel = ChatMessageModel(
      message: message,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    // 2. Link Relations (ObjectBox Way)
    // We just set the targetId. ObjectBox handles the rest.
    msgModel.chatRoom.targetId = chatRoomId;
    msgModel.sender.targetId = senderId;

    // 3. Save
    _messageBox.put(msgModel);
  }

  @override
  Future<void> seedChatData() async {
    if (_roomBox.isEmpty()) {
      // Create 2 Rooms
      final room1 = ChatRoomModel(name: 'General Tech');
      final room2 = ChatRoomModel(name: 'Random Talks');

      // Save Rooms (IDs generated)
      _roomBox.putMany([room1, room2]);

      // Create a Seed Message in Room 1
      // Assuming User ID 1 (Alice) exists from Auth Seeding
      final seedMsg = ChatMessageModel(
        message: 'Welcome to the tech channel! (Seed)',
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

      seedMsg.chatRoom.target = room1;
      seedMsg.sender.targetId = 1; // Alice

      _messageBox.put(seedMsg);
    }
  }
}
