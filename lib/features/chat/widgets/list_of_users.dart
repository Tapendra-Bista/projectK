import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/bloc/chat_state.dart';
import 'package:afriqueen/features/chat/model/chat_room_model.dart';
import 'package:afriqueen/features/chat/screen/chat_screen.dart';
import 'package:afriqueen/features/chat/widgets/chat_list_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ListOfUsers extends StatelessWidget {
  ListOfUsers({
    super.key,
  });

  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;
//-----------------List of user or Chatrooms List---------------------
  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatBloc, ChatState, List<ChatRoomModel>>(
        selector: (state) => state.chatRoomModel,
        builder: (context, chats) {
          return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];

                final otherUserId =
                    chat.participants.firstWhere((id) => id != _currentUserId);

                return ChatListTitle(
                  chat: chat,
                  currentUserId: _currentUserId,
                  onTap: () {
                    print("home screen current user id $_currentUserId");
                    final otherUserName = chat.participantsName?[otherUserId]
                            ?['pseudo'] ??
                        'Unknown';
                    final otherUserImage =
                        chat.participantsName?[otherUserId]?['imgURL'] ?? '';
                    Get.to(
                      () => ChatScreen(
                          imgURL: otherUserImage,
                          receiverId: otherUserId,
                          receiverName: otherUserName),
                    );
                  },
                );
              });
        });
  }
}
