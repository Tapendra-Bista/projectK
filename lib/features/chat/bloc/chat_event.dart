import 'package:afriqueen/features/chat/model/chat_message.dart';
import 'package:afriqueen/features/chat/model/chat_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatEvent {}

class InitializeChatEvent extends ChatEvent {
  final String receiverId;
  InitializeChatEvent(this.receiverId);
}

class SendMessage extends ChatEvent {
  final String content;
  final String receiverId;
  SendMessage({required this.content, required this.receiverId});
}

class LoadMoreMessages extends ChatEvent {}

class StartTyping extends ChatEvent {}

class LeaveChat extends ChatEvent {}

class MessagesUpdated extends ChatEvent {
  final List<ChatMessage> messages;
  MessagesUpdated(this.messages);
}

class OnlineStatusUpdated extends ChatEvent {
  final bool isOnline;
  final Timestamp? lastSeen;
  OnlineStatusUpdated(this.isOnline, this.lastSeen);
}

class TypingStatusUpdated extends ChatEvent {
  final bool isTyping;
  TypingStatusUpdated(this.isTyping);
}

class ChatRoomsLists extends ChatEvent {
  final String id;
  ChatRoomsLists({required this.id});
}

class ChatRoomsUpdated extends ChatEvent {
  final List<ChatRoomModel> chatRooms;

  ChatRoomsUpdated({required this.chatRooms});
}

class ChatRoomsError extends ChatEvent {
  final String errorMessage;

  ChatRoomsError({required this.errorMessage});
}
