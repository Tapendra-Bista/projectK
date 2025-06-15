import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/bloc/chat_event.dart';
import 'package:afriqueen/features/chat/bloc/chat_state.dart';
import 'package:afriqueen/features/chat/widgets/list_of_users.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/get_utils.dart';

class ChatRoomsScreen extends StatelessWidget {
  ChatRoomsScreen({super.key});
  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;
//------------Chat RoOM MAIN screen---------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(EnumLocale.chats.name.tr),
        ),
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: AppColors.floralWhite,
          onRefresh: () async {
            getIt<ChatBloc>().add(ChatRoomsLists(id: _currentUserId));
          },
          child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
            return switch (state) {
              //-------initial state-----------------

              //--------------- Except above condition--------
              _ => ListOfUsers()
            };
          }),
        ));
  }
}
