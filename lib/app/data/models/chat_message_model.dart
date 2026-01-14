import 'package:objectbox/objectbox.dart';
import 'package:test_project/app/data/models/chat_room_model.dart';
import 'package:test_project/app/domain/entity/chat_message.dart';
import 'user_model.dart';

@Entity()
class ChatMessageModel {
  @Id()
  int id = 0;

  String message;
  int timestamp; // ObjectBox stores dates as Integers (milliseconds)

  // RELATIONSHIPS
  // Message belongs to ONE ChatRoom
  final chatRoom = ToOne<ChatRoomModel>();

  // Message belongs to ONE User (Sender)
  final sender = ToOne<UserModel>();

  ChatMessageModel({
    this.id = 0,
    required this.message,
    required this.timestamp,
  });

  // MAPPER: Model (DB) -> Entity (Domain)
  // This extracts the data from the relations so the UI is easy to build
  ChatMessage toEntity() {
    return ChatMessage(
      id: id,
      message: message,
      timestamp: DateTime.fromMillisecondsSinceEpoch(timestamp),

      // Extracting IDs from Relations
      chatRoomId: chatRoom.targetId,
      userId: sender.targetId,
    );
  }
}
