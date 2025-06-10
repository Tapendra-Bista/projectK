import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/features/chat/model/chat_room_model.dart';
import 'package:afriqueen/features/chat/repository/chat_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatListTitle extends StatelessWidget {
  final ChatRoomModel chat;
  final String currentUserId;
  final VoidCallback onTap;

  ChatListTitle(
      {super.key,
      required this.chat,
      required this.currentUserId,
      required this.onTap});

  String _getOtherUsername(context) {
    try {
      final otherUserId = chat.participants.firstWhere(
        (id) => id != currentUserId,
        orElse: () => 'Unknown User',
      );
      return chat.participantsName?[otherUserId]!['pseudo'] ?? "Unknown User";
    } catch (e) {
      return "Unknown User";
    }
  }

  String _getOtherUserimage() {
    try {
      final otherUserId = chat.participants.firstWhere(
        (id) => id != currentUserId,
        orElse: () => 'Unknown User',
      );
      return chat.participantsName?[otherUserId]!['imgURL'] ?? "";
    } catch (e) {
      return "Unknown User";
    }
  }

  final chatRepository = ChatRepository();
  @override
  Widget build(BuildContext context) {
    final isValideUrl = _getOtherUserimage().isNotEmpty &&
        Uri.tryParse(_getOtherUserimage())!.hasAbsolutePath == true;

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 25.5.r,
        backgroundImage: isValideUrl
            ? CachedNetworkImageProvider(_getOtherUserimage())
            : null,
        backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      ),
      title: Text(
        _getOtherUsername(context),
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18),
      ),
      subtitle: Row(
        children: [
          Expanded(
              child: Text(
            chat.lastMessage ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: AppColors.grey, fontSize: 14.sp),
          )),
        ],
      ),
      trailing: StreamBuilder<int>(
        stream: chatRepository.getUnreadCount(chat.id, currentUserId),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == 0) {
            return const SizedBox();
          }
          return Container(
            height: 15,
            width: 15,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                snapshot.data.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 10.sp, color: AppColors.floralWhite),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}
