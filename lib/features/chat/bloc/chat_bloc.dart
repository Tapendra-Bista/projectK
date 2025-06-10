import 'dart:async';
import 'dart:developer';
import 'package:afriqueen/features/block/repository/block_repository.dart';
import 'package:afriqueen/features/chat/model/chat_room_model.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repository/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  bool _isInChat = false;

  StreamSubscription? _messageSubscription;
  StreamSubscription? _onlineStatusSubscription;
  StreamSubscription? _typingSubscription;
  StreamSubscription<List<ChatRoomModel>>? _chatRoomsSubscription;
  Timer? _typingTimer;

  ChatBloc({required ChatRepository chatRepository})
      : _chatRepository = chatRepository,
        super(const ChatState()) {
    on<InitializeChatEvent>(_onEnterChat);
    on<SendMessage>(_onSendMessage);
    on<LoadMoreMessages>(_onLoadMoreMessages);
    on<StartTyping>(_onStartTyping);
    on<LeaveChat>(_onLeaveChat);
    on<MessagesUpdated>(_onMessagesUpdated);
    on<OnlineStatusUpdated>(_onOnlineStatusUpdated);
    on<TypingStatusUpdated>(_onTypingStatusUpdated);
    on<ChatRoomsLists>(_onChatRoomsLists);
    on<ChatRoomsUpdated>(_onChatRoomsUpdated);
    on<ChatRoomsError>(_onChatRoomsError);
  }
  void _onChatRoomsUpdated(ChatRoomsUpdated event, Emitter<ChatState> emit) {
    if (event.chatRooms.isEmpty) {
      emit(ChatEmpty());
    } else {
      emit(ChatState(chatRoomModel: event.chatRooms));
    }
  }

  void _onChatRoomsError(ChatRoomsError event, Emitter<ChatState> emit) {
    emit(ChatError(errorMessage: event.errorMessage));
  }

  Future<void> _onChatRoomsLists(
      ChatRoomsLists event, Emitter<ChatState> emit) async {
    // Cancel any previous subscription to chat rooms to avoid multiple listeners
    _chatRoomsSubscription?.cancel();

    emit(ChatLoading()); // Emit loading state immediately
    _chatRoomsSubscription = _chatRepository.getChatRooms(event.id).listen(
      (chatsData) async {
        try {
          final blockData = await getIt<BlockRepository>().fetchBlocks();
          final blockedUserIds = blockData?.blockId ?? [];

          final List<ChatRoomModel> chats = chatsData.where((chat) {
            final otherUserId = chat.participants.firstWhere(
              (id) => id != FirebaseAuth.instance.currentUser!.uid,
              orElse: () => '',
            );
            return otherUserId.isNotEmpty &&
                !blockedUserIds.contains(otherUserId);
          }).toList();

          // Instead of emit, add a new event
          add(ChatRoomsUpdated(chatRooms: chats));
        } catch (e) {
          add(ChatRoomsError(errorMessage: e.toString()));
        }
      },
    );
  }

  Future<void> _onEnterChat(
      InitializeChatEvent event, Emitter<ChatState> emit) async {
    _isInChat = true;
    // emit(state.copyWith(status: ChatStatus.loading));
    try {
      final chatRoom = await _chatRepository.getOrCreateChatRoom(
          FirebaseAuth.instance.currentUser!.uid, event.receiverId);

      emit(state.copyWith(
        chatRoomId: chatRoom.id,
        receiverId: event.receiverId,
        status: ChatStatus.loaded,
      ));

      _subscribeToMessages(chatRoom.id);
      _subscribeToOnlineStatus(event.receiverId);
      _subscribeToTypingStatus(chatRoom.id);

      await _chatRepository.updateOnlineStatus(
          FirebaseAuth.instance.currentUser!.uid, true);
    } catch (e) {
      emit(state.copyWith(
          status: ChatStatus.error, error: "Failed to create chat room $e"));
    }
  }

  Future<void> _onSendMessage(
      SendMessage event, Emitter<ChatState> emit) async {
    if (state.chatRoomId == null) return;
    try {
      await _chatRepository.sendMessage(
        chatRoomId: state.chatRoomId!,
        senderId: FirebaseAuth.instance.currentUser!.uid,
        receiverId: event.receiverId,
        content: event.content,
      );
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(error: "Failed to send message"));
    }
  }

  Future<void> _onLoadMoreMessages(
      LoadMoreMessages event, Emitter<ChatState> emit) async {
    if (state.status != ChatStatus.loaded ||
        state.messages.isEmpty ||
        !state.hasMoreMessages ||
        state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));
    try {
      final lastMessage = state.messages.last;
      final lastDoc = await _chatRepository
          .getChatRoomMessages(state.chatRoomId!)
          .doc(lastMessage.id)
          .get();

      final moreMessages = await _chatRepository
          .getMoreMessages(state.chatRoomId!, lastDocument: lastDoc);

      if (moreMessages.isEmpty) {
        emit(state.copyWith(hasMoreMessages: false, isLoadingMore: false));
        return;
      }

      emit(state.copyWith(
        messages: [...state.messages, ...moreMessages],
        hasMoreMessages: moreMessages.length >= 20,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(state.copyWith(
          error: "Failed to load more messages", isLoadingMore: false));
    }
  }

  void _subscribeToMessages(String chatRoomId) {
    _messageSubscription?.cancel();
    _messageSubscription =
        _chatRepository.getMessages(chatRoomId).listen((messages) {
      if (_isInChat) {
        _markMessagesAsRead(chatRoomId);
      }
      add(MessagesUpdated(messages));
    }, onError: (error) {
      addError("Failed to load messages");
    });
  }

  void _subscribeToOnlineStatus(String userId) {
    _onlineStatusSubscription?.cancel();
    _onlineStatusSubscription =
        _chatRepository.getUserOnlineStatus(userId).listen((status) {
      final isOnline = status["isOnline"] as bool;
      final lastSeen = status["lastSeen"] as Timestamp?;

      add(OnlineStatusUpdated(isOnline, lastSeen));
    });
  }

  void _subscribeToTypingStatus(String chatRoomId) {
    _typingSubscription?.cancel();
    _typingSubscription =
        _chatRepository.getTypingStatus(chatRoomId).listen((status) {
      final isTyping = status["isTyping"] as bool;
      final typingUserId = status["typingUserId"] as String?;
      final isOtherUser =
          typingUserId != FirebaseAuth.instance.currentUser!.uid;
      add(TypingStatusUpdated(isTyping && isOtherUser));
    });
  }

  Future<void> _onStartTyping(
      StartTyping event, Emitter<ChatState> emit) async {
    if (state.chatRoomId == null) return;
    _typingTimer?.cancel();
    _updateTypingStatus(true);
    _typingTimer = Timer(const Duration(seconds: 3), () {
      _updateTypingStatus(false);
    });
  }

  Future<void> _updateTypingStatus(bool isTyping) async {
    if (state.chatRoomId == null) return;
    try {
      await _chatRepository.updateTypingStatus(
        state.chatRoomId!,
        FirebaseAuth.instance.currentUser!.uid,
        isTyping,
      );
    } catch (e) {
      print("error updating typing status $e");
    }
  }

  Future<void> _markMessagesAsRead(String chatRoomId) async {
    try {
      await _chatRepository.markMessagesAsRead(
        chatRoomId,
        FirebaseAuth.instance.currentUser!.uid,
      );
    } catch (e) {
      print("error marking messages as read $e");
    }
  }

  Future<void> _onLeaveChat(LeaveChat event, Emitter<ChatState> emit) async {
    _isInChat = false;
    // You might want to cancel specific subscriptions here if leaving a specific chat.
    // However, for the chat rooms list, it's handled in _onChatRoomsLists.
  }

  void _onMessagesUpdated(MessagesUpdated event, Emitter<ChatState> emit) {
    emit(state.copyWith(messages: event.messages, error: null));
  }

  void _onOnlineStatusUpdated(
      OnlineStatusUpdated event, Emitter<ChatState> emit) {
    emit(state.copyWith(
      isReceiverOnline: event.isOnline,
      receiverLastSeen: event.lastSeen,
    ));
  }

  void _onTypingStatusUpdated(
      TypingStatusUpdated event, Emitter<ChatState> emit) {
    emit(state.copyWith(isReceiverTyping: event.isTyping));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _onlineStatusSubscription?.cancel();
    _typingSubscription?.cancel();
    _chatRoomsSubscription?.cancel(); // Cancel the chat rooms subscription here
    _typingTimer?.cancel();
    return super.close();
  }
}
