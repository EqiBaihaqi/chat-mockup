class ChatMessage {
  ChatMessage({
    required this.id,
    required this.chatRoomId,
    required this.userId,
    required this.message,
    required this.timestamp,
  });
  final int id;
  final int chatRoomId;
  final int userId;
  final String message;
  final DateTime timestamp;
}
