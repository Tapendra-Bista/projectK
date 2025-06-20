import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/circular_indicator.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/bloc/chat_event.dart';
import 'package:afriqueen/features/chat/bloc/chat_state.dart';
import 'package:afriqueen/features/chat/widgets/list_of_users.dart';
import 'package:afriqueen/features/chat/widgets/no_chats.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';

class ChatRoomsScreen extends StatelessWidget {
  ChatRoomsScreen({super.key});

  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;

//------------Chat RoOM MAIN screen---------------------
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          automaticallyImplyLeading: false,
          title: Text(EnumLocale.chats.name.tr),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: BlocSelector<ChatBloc, ChatState, bool>(
                selector: (state) => state.isDelete!,
                builder: (context, isDeleting) {
                  return isDeleting
                      ? LinearProgressIndicator(
                          backgroundColor: AppColors.greyContainerColor,
                          color: AppColors.primaryColor,
                        )
                      : SizedBox.shrink();
                },
              )),
        ),
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: AppColors.floralWhite,
          onRefresh: () async {
            getIt<ChatBloc>().add(ChatRoomsLists(id: _currentUserId));
          },
          child: BlocBuilder<ChatBloc, ChatState>(
              buildWhen: (previous, current) => current != previous,
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
