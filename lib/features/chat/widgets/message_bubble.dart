import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/features/chat/model/chat_message.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  // final bool showTime;
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    // required this.showTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      BubbleSpecialOne(
        text: "${message.content}",
        isSender: isMe,
        tail: true,
        textStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: AppColors.white),
        color: isMe
            ? AppColors.primaryColor.withValues(alpha: 0.8)
            : AppColors.black.withValues(alpha: 0.72),
        sent: message.status == MessageStatus.sent ? true : false,
        seen: message.status == MessageStatus.read ? true : false,
      ),
      BubbleSpecialOne(
        text: DateFormat('h:mm a').format(message.timestamp.toDate()),
        isSender: isMe,
        textStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: AppColors.black, fontSize: 11.sp),
        color: AppColors.floralWhite,
      )
    ]);
  }
}
