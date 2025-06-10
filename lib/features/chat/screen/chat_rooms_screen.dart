import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/circular_indicator.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/bloc/chat_event.dart';
import 'package:afriqueen/features/chat/bloc/chat_state.dart';
import 'package:afriqueen/features/chat/widgets/list_of_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';

class ChatRoomsScreen extends StatefulWidget {
  const ChatRoomsScreen({super.key});

  @override
  State<ChatRoomsScreen> createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(ChatRoomsLists(id: _currentUserId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(EnumLocale.chats.name.tr),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
          return switch (state) {
            ChatLoading() => CustomCircularIndicator(),
            ChatError() => Center(
                child: Text(
                    "${EnumLocale.defaultError.name.tr} error:${state.errorMessage}"),
              ),
            ChatEmpty() => Center(
                child: Text(
                  EnumLocale.noRecentChats.name.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 18),
                ),
              ),
            _ => ListOfUsers()
          };
        }));
  }
}
