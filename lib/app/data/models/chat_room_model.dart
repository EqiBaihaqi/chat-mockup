import 'package:objectbox/objectbox.dart';
import 'package:test_project/app/data/models/chat_message_model.dart';
import 'package:test_project/app/domain/entity/chat_room.dart';

@Entity()
class ChatRoomModel {
  ChatRoomModel({this.id = 0, required this.name});
  @Id()
  int id;

  String name;

  // Relation that 1 room has many chat messages
  @Backlink('chatRoom')
  final messages = ToMany<ChatMessageModel>();

  // Mapper model -> entity
  ChatRoom toEntity() {
    return ChatRoom(id: id, name: name);
  }

  // Mapper entitiy -> model
  factory ChatRoomModel.fromEntity(ChatRoom room) {
    return ChatRoomModel(id: room.id, name: room.name);
  }
}
