import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/messages_requests/bloc/request_receiver_bloc.dart';
import 'package:afriqueen/features/messages_requests/bloc/request_sender_bloc.dart';
import 'package:afriqueen/features/messages_requests/model/request_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';

class RequestsReceiverScreen extends StatelessWidget {
  const RequestsReceiverScreen({super.key});
//---Fetch data screen---
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return BlocSelector<RequestReceiverBloc, RequestReceiverState,
        List<Requestmodel>>(
      selector: (state) {
        if (state is GetRequests) return state.receiverData;
        return [];
      },
      builder: (context, data) {
        return ListView.builder(
            itemCount: data.length,
            reverse: false,
            itemBuilder: (context, index) {
              final user = data[index];
              final isValidPath = user.senderProfile.isNotEmpty &&
                  Uri.tryParse(user.senderProfile)!.hasAbsolutePath == true;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Slidable(
                  endActionPane: ActionPane(motion: ScrollMotion(), children: [
                    SlidableAction(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.blue,
                      foregroundColor: AppColors.white,
                      onPressed: (context) {},
                      label: EnumLocale.accept.name.tr,
                      icon: Icons.check_circle,
                    ),
                    SlidableAction(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.greyContainerColor,
                      foregroundColor: AppColors.black,
                      onPressed: (context) {},
                      label: EnumLocale.archive.name.tr,
                      icon: Icons.archive_outlined,
                    ),
                    SlidableAction(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white,
                      onPressed: (context) {},
                      label: EnumLocale.reject.name.tr,
                      icon: Icons.cancel,
                    ),
                  ]),
                  dragStartBehavior: DragStartBehavior.down,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: AppColors.black.withValues(alpha: 0.6),
                            width: 0.5.w),
                        borderRadius: BorderRadiusGeometry.circular(5.r)),
                    leading: CircleAvatar(
                      radius: 25.5.r,
                      backgroundImage: isValidPath
                          ? CachedNetworkImageProvider(user.senderProfile)
                          : null,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user.senderName,
                          style: theme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          DateFormat('h:mm a').format(user.createdAt.toDate()),
                          style: theme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      EnumLocale.requestInfo.name.tr,
                      style: theme.bodySmall!.copyWith(fontSize: 10.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    trailing: SizedBox(
                      height: 60.h,
                      width: 10.w,
                      child: Icon(
                        Icons.chevron_left_outlined,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}

class RequestsSenderScreen extends StatelessWidget {
  const RequestsSenderScreen({super.key});
//---Fetch data screen---
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return BlocSelector<RequestSenderBloc, RequestSenderState,
        List<Requestmodel>>(
      selector: (state) {
        if (state is TotalRequestSenderSendState) return state.senderData;
        return [];
      },
      builder: (context, data) {
        return ListView.builder(
            itemCount: data.length,
            reverse: false,
            itemBuilder: (context, index) {
              final user = data[index];
              final isValidPath = user.receiverProfile.isNotEmpty &&
                  Uri.tryParse(user.receiverProfile)!.hasAbsolutePath == true;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                child: Slidable(
                  endActionPane: ActionPane(motion: ScrollMotion(), children: [
                    SlidableAction(
                      padding: EdgeInsets.symmetric(horizontal: 15.h),
                      backgroundColor: AppColors.red,
                      foregroundColor: AppColors.white,
                      onPressed: (context) {},
                      label: EnumLocale.deleteChat.name.tr,
                      icon: Icons.delete_outline,
                    ),
                  ]),
                  dragStartBehavior: DragStartBehavior.down,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: AppColors.black.withValues(alpha: 0.6),
                            width: 0.5.w),
                        borderRadius: BorderRadiusGeometry.circular(5.r)),
                    leading: CircleAvatar(
                      radius: 25.5.r,
                      backgroundImage: isValidPath
                          ? CachedNetworkImageProvider(user.receiverProfile)
                          : null,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          user.receiverName,
                          style: theme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          DateFormat('h:mm a').format(user.createdAt.toDate()),
                          style: theme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Request status: ",
                              style: theme.bodyMedium!.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              "${user.requestStatus.name}",
                              style: theme.bodySmall!.copyWith(
                                  color: user.requestStatus.name ==
                                          RequestStatus.send.name
                                      ? AppColors.black
                                      : AppColors.blue),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Response status: ",
                              style: theme.bodyMedium!.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              "${user.responseStatus.name}",
                              style: theme.bodySmall!
                                  .copyWith(color: AppColors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                    trailing: SizedBox(
                      height: 60.h,
                      width: 10.w,
                      child: Icon(
                        Icons.chevron_left_outlined,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
