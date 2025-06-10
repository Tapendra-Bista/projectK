// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/repository/chat_repository.dart';
import 'package:afriqueen/features/chat/screen/chat_screen.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class StartChat extends StatelessWidget {
  const StartChat({super.key, required this.profileModel});
  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => ChatBloc(
        // Use a new context variable name to clarify
        chatRepository: getIt<ChatRepository>(),
      ),
      // Use a Builder here to get a context that is a descendant of BlocProvider
      child: Builder(
        builder: (innerContext) {
          // innerContext now has access to ChatBloc
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // Use innerContext here
                  final chatBloc = BlocProvider.of<ChatBloc>(innerContext);
                  Navigator.push(
                    innerContext, // Pass innerContext to Navigator.push
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: chatBloc,
                        child: ChatScreen(
                          imgURL: profileModel.imgURL,
                          receiverId: profileModel.id,
                          receiverName: profileModel.pseudo,
                        ),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  CupertinoIcons.chat_bubble,
                  color: AppColors.black,
                  size: 30,
                ),
              ),
              Text(
                EnumLocale.message.name.tr,
                style: Theme.of(context) // context is still fine for Theme.of
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.black),
              )
            ],
          );
        },
      ),
    );
  }
}
