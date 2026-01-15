import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:get/get.dart';
import 'package:objectbox/objectbox.dart';
import 'package:test_project/app/data/models/user_model.dart';
import 'package:test_project/app/domain/usecases/get_messages_usecase.dart';
import 'package:test_project/app/domain/usecases/send_message_usecase.dart';
import 'package:test_project/app/utils/session/session_key.dart';
import 'package:test_project/app/utils/session/session_manager.dart';
import 'package:uuid/uuid.dart';

class DetailChatController extends GetxController {
  DetailChatController(
    this._getMessagesUseCase,
    this._sendMessageUseCase,
    this._sessionManager,
  );

  final GetMessagesUsecase _getMessagesUseCase;
  final SendMessageUsecase _sendMessageUseCase;
  final SessionManager _sessionManager;
  late final Store _store;

  // Args
  late final int chatRoomId;
  late final String chatRoomName;

  // State
  late final User currentUser;
  late final ChatController chatUIController;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _store = Get.find<Store>();
    _readChatArguments(Get.arguments);
    _setupCurrentUser();
    chatUIController = InMemoryChatController();
    loadMessages();
  }

  void _readChatArguments(dynamic args) {
    if (args is Map) {
      chatRoomId = args['roomId'] ?? 0;
      chatRoomName = args['roomName'] ?? 'Chat';
      return;
    }

    if (args is int) {
      chatRoomId = args;
      chatRoomName = 'Chat';
      return;
    }

    chatRoomId = 0;
    chatRoomName = 'Chat';
  }

  void _setupCurrentUser() {
    final userId = _sessionManager.read(SessionKey.currentUserId);

    // UI Package requires ID as String
    final safeUserId = userId?.toString() ?? '0';
    final userName = _lookupUserName(userId, safeUserId);
    currentUser = User(id: safeUserId, name: userName);
  }

  String _lookupUserName(dynamic userId, String fallbackId) {
    final idAsInt = userId is int ? userId : int.tryParse(fallbackId);
    if (idAsInt == null || idAsInt <= 0) {
      return 'User $fallbackId';
    }

    final userModel = _store.box<UserModel>().get(idAsInt);
    return userModel?.name ?? 'User $fallbackId';
  }

  Future<void> loadMessages() async {
    isLoading.value = true;

    try {
      // 1. Call UseCase
      final domainMessages = await _getMessagesUseCase.execute(chatRoomId);

      // 2. Map Domain Entity -> UI Type
      final uiMessages = domainMessages.map((e) {
        return Message.text(
          id: e.id.toString(),
          authorId: e.userId.toString(),
          createdAt: e.timestamp,
          text: e.message,
        );
      }).toList();

      uiMessages.sort((a, b) {
        final aTime = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return aTime.compareTo(bTime);
      });

      await chatUIController.setMessages(uiMessages);
    } catch (e) {
      print("Error loading messages: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleSendPressed(String text) async {
    if (text.trim().isEmpty) return;

    final tempMessage = Message.text(
      id: const Uuid().v4(),
      authorId: currentUser.id,
      createdAt: DateTime.now(),
      text: text,
      metadata: const {'sending': true},
    );

    await chatUIController.insertMessage(tempMessage);

    try {
      final senderId = int.tryParse(currentUser.id);
      if (senderId == null) {
        throw Exception('Invalid user id');
      }

      await _sendMessageUseCase.execute(chatRoomId, senderId, text);

      final sentMessage = Message.text(
        id: tempMessage.id,
        authorId: tempMessage.authorId,
        createdAt: tempMessage.createdAt,
        text: text,
        sentAt: DateTime.now(),
      );

      await chatUIController.updateMessage(tempMessage, sentMessage);
    } catch (e) {
      final failedMessage = Message.text(
        id: tempMessage.id,
        authorId: tempMessage.authorId,
        createdAt: tempMessage.createdAt,
        text: text,
        failedAt: DateTime.now(),
      );

      await chatUIController.updateMessage(tempMessage, failedMessage);
      Get.snackbar('Error', 'Failed to send message');
    }
  }

  Future<User?> resolveUser(String id) async {
    if (id == currentUser.id) {
      return currentUser;
    }

    final name = _lookupUserName(id, id);
    return User(id: id, name: name);
  }

  @override
  void onClose() {
    chatUIController.dispose();
    super.onClose();
  }
}
