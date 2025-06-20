// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/chat/screen/chat_screen.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';

class StartChat extends StatelessWidget {
  const StartChat({super.key, required this.profileModel});
  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PlatformIconButton(
          onPressed: () {
            Get.to(
              () => ChatScreen(
                imgURL: profileModel.imgURL,
                receiverId: profileModel.id,
                receiverName: profileModel.pseudo,
              ),
            );
          },
          icon: Icon(
            CupertinoIcons.chat_bubble,
            color: AppColors.black,
            size: 30,
          ),
        ),
        PlatformText(
          EnumLocale.message.name.tr,
          style: Theme.of(context) // context is still fine for Theme.of
              .textTheme
              .bodySmall!
              .copyWith(color: AppColors.black),
        )
      ],
    );
  }
}
