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
    // Create Model
    final msgModel = ChatMessageModel(
      message: message,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    // We just set the targetId. ObjectBox handles the rest.
    msgModel.chatRoom.targetId = chatRoomId;
    msgModel.sender.targetId = senderId;

    // Save
    _messageBox.put(msgModel);
  }

  @override
  Future<void> seedChatData() async {
    // Only seed if rooms are empty
    if (_roomBox.isEmpty()) {
      // Create and Save Rooms
      // Note: After putMany, room1 and room2 will automatically get their IDs assigned.
      final room1 = ChatRoomModel(name: 'General Tech');
      final room2 = ChatRoomModel(name: 'Random Talks');

      _roomBox.putMany([room1, room2]);

      // Prepare Messages
      final now = DateTime.now();

      final messages = [
        // Conversation in Room 1
        ChatMessageModel(
            message: 'Welcome to the tech channel guys!',
            timestamp: now
                .subtract(const Duration(minutes: 60))
                .millisecondsSinceEpoch,
          )
          ..chatRoom.target = room1
          ..sender.targetId = 1,

        ChatMessageModel(
            message: 'Hey Bro! Are you using GetX for the test?',
            timestamp: now
                .subtract(const Duration(minutes: 55))
                .millisecondsSinceEpoch,
          )
          ..chatRoom.target = room1
          ..sender.targetId = 2,

        ChatMessageModel(
            message: 'Yes, combining it with ObjectBox for local storage.',
            timestamp: now
                .subtract(const Duration(minutes: 50))
                .millisecondsSinceEpoch,
          )
          ..chatRoom.target = room1
          ..sender.targetId = 1,

        ChatMessageModel(
            message: 'Nice choice! Very fast.',
            timestamp: now
                .subtract(const Duration(minutes: 48))
                .millisecondsSinceEpoch,
          )
          ..chatRoom.target = room1
          ..sender.targetId = 2,

        // Conversation in Room 2
        ChatMessageModel(
            message: 'Has anyone seen my coffee?',
            timestamp: now
                .subtract(const Duration(hours: 2))
                .millisecondsSinceEpoch,
          )
          ..chatRoom.target = room2
          ..sender.targetId = 2,

        ChatMessageModel(
            message: 'I want this job..',
            timestamp: now
                .subtract(const Duration(hours: 5))
                .millisecondsSinceEpoch,
          )
          ..chatRoom.target = room2
          ..sender.targetId = 1,
      ];

      // Save all messages at once
      _messageBox.putMany(messages);
    }
  }
}
