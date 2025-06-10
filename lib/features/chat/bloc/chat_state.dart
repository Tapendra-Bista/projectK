import 'package:afriqueen/features/chat/model/chat_message.dart';
import 'package:afriqueen/features/chat/model/chat_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum ChatStatus { initial, loading, loaded, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final String? chatRoomId;
  final String? receiverId;
  final List<ChatMessage> messages;
  final bool isReceiverOnline;
  final Timestamp? receiverLastSeen;
  final bool isReceiverTyping;
  final String? error;
  final bool isLoadingMore;
  final bool hasMoreMessages;
  final List<ChatRoomModel> chatRoomModel;
  const ChatState({
    this.status = ChatStatus.initial,
    this.chatRoomId,
    this.receiverId,
    this.messages = const [],
    this.isReceiverOnline = false,
    this.receiverLastSeen,
    this.isReceiverTyping = false,
    this.error,
    this.isLoadingMore = false,
    this.hasMoreMessages = true,
    this.chatRoomModel = const [],
  });

  ChatState copyWith(
      {ChatStatus? status,
      String? chatRoomId,
      String? receiverId,
      List<ChatMessage>? messages,
      bool? isReceiverOnline,
      Timestamp? receiverLastSeen,
      bool? isReceiverTyping,
      String? error,
      bool? isLoadingMore,
      bool? hasMoreMessages,
      List<ChatRoomModel>? chatRoomModel}) {
    return ChatState(
        status: status ?? this.status,
        chatRoomId: chatRoomId ?? this.chatRoomId,
        receiverId: receiverId ?? this.receiverId,
        messages: messages ?? this.messages,
        isReceiverOnline: isReceiverOnline ?? this.isReceiverOnline,
        receiverLastSeen: receiverLastSeen ?? this.receiverLastSeen,
        isReceiverTyping: isReceiverTyping ?? this.isReceiverTyping,
        error: error,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMoreMessages: hasMoreMessages ?? this.hasMoreMessages,
        chatRoomModel: chatRoomModel ?? this.chatRoomModel);
  }

  @override
  List<Object?> get props => [
        status,
        chatRoomId,
        receiverId,
        messages,
        isReceiverOnline,
        receiverLastSeen,
        isReceiverTyping,
        error,
        isLoadingMore,
        hasMoreMessages,
        chatRoomModel
      ];
}

class ChatLoading extends ChatState {}

class ChatEmpty extends ChatState {}

class ChatError extends ChatState {
  final String errorMessage;
  ChatError({required this.errorMessage});
}
