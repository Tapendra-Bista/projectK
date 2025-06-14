import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/bloc/chat_state.dart';
import 'package:afriqueen/features/chat/widgets/list_of_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';

class ChatRoomsScreen extends StatelessWidget {
  const ChatRoomsScreen({super.key});
//------------Chat RoOM MAIN screen---------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(EnumLocale.chats.name.tr),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
          return switch (state) {
            //-------initial state-----------------

            //--------------- Except above condition--------
            _ => ListOfUsers()
          };
        }));
  }
}
