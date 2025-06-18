import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/circular_indicator.dart';
import 'package:afriqueen/common/widgets/loading.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/bloc/chat_event.dart';
import 'package:afriqueen/features/chat/bloc/chat_state.dart';
import 'package:afriqueen/features/chat/widgets/list_of_users.dart';
import 'package:afriqueen/features/chat/widgets/no_chats.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
          child: BlocConsumer<ChatBloc, ChatState>(
              listenWhen: (previous, current) => current != previous,
              buildWhen: (previous, current) => current != previous,
              listener: (context, state) {
                if (state is ChatDeleteProcessing) {
                  customLoading(context);
                } else {
                  Get.back();
                }
              },
              builder: (context, state) {
                return switch (state) {
                  //-------initial state-----------------
                  ChatLoading() => CustomCircularIndicator(),
                  //--------------- Except above condition--------
                  ChatEmpty() => NoChats(),
                  _ => ListOfUsers()
                };
              }),
        ));
  }
}
