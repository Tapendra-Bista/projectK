//-------------------Image and status------------------------------
import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/loading.dart';
import 'package:afriqueen/common/widgets/seniority.dart';
import 'package:afriqueen/common/widgets/snackbar_message.dart';
import 'package:afriqueen/common/widgets/user_status.dart';
import 'package:afriqueen/features/archive/bloc/archive_bloc.dart';
import 'package:afriqueen/features/archive/bloc/archive_event.dart';
import 'package:afriqueen/features/chat/screen/chat_screen.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_bloc.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_event.dart';
import 'package:afriqueen/features/follow/screen/follow_screen.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_event.dart';
import 'package:afriqueen/features/like/bloc/like_bloc.dart';
import 'package:afriqueen/features/like/bloc/like_event.dart';
import 'package:afriqueen/features/like/bloc/like_state.dart';
import 'package:afriqueen/features/like/model/like_model.dart';
import 'package:afriqueen/features/messages_requests/bloc/request_sender_bloc.dart';
import 'package:afriqueen/features/messages_requests/model/request_model.dart';
import 'package:afriqueen/features/profile/bloc/profile_bloc.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/features/user_details/screen/user_details_screen.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:quickalert/quickalert.dart';

//-----------Image and Status---------------------------
class ImageAndStatus extends StatelessWidget {
  const ImageAndStatus({
    super.key,
    required this.user,
  });
  final ProfileModel user;

  @override
  Widget build(BuildContext context) {
    final validUrl = user.imgURL.isNotEmpty &&
        Uri.tryParse(user.imgURL)!.hasAbsolutePath == true;
    return GestureDetector(
      onTap: () => Get.to(() => UserDetailsScreen(data: user)),
      child: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: 290.h,
            decoration: validUrl
                ? BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(user.imgURL),
                    ),
                  )
                : null,
          ),
          Positioned(
            top: 8.r,
            right: 8.r,
            child: UserStatus(id: user.id),
          ),
          Positioned(bottom: 1, child: CreatedDate(user: user))
        ],
      ),
    );
  }
}

//-----------Seniority------------------------------
class CreatedDate extends StatelessWidget {
  const CreatedDate({super.key, required this.user});
  final ProfileModel user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
            color: AppColors.greyContainerColor,
            borderRadius: BorderRadius.circular(12.r)),
        child: Text(Seniority.formatJoinedTime(user.createdDate.toDate()),
            style: theme.bodyMedium));
  }
}

//----------------fav , following, archive----------------
class ListOfButtons extends StatelessWidget {
  const ListOfButtons(
      {super.key, required this.user, required this.controller});
  final ProfileModel user;
  final CardSwiperController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.greyContainerColor,
            borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //-----------like----------------
            LikeButtonForMatch(
              id: user.id,
            ),
            //-------- chat-------
            StartChatFromMatch(
              profileModel: user,
            ),
            PlatformIconButton(
              onPressed: () async {
                context
                    .read<FavoriteBloc>()
                    .add(FavoriteUserAdded(favId: user.id));
                snackBarMessage(context, EnumLocale.savedToFavorites.name.tr,
                    Theme.of(context));
                context.read<HomeBloc>().add(HomeUsersProfileList());
                controller.swipe(CardSwiperDirection.right);
              },
              icon: Icon(CupertinoIcons.heart,
                  size: 30.r, color: AppColors.black),
            ),
            // ------------------following-----------------
            FollowButton(
              id: user.id,
              color: AppColors.black.withValues(alpha: 0.9),
            ),
            //----------Archive--------------------------
            PlatformIconButton(
              onPressed: () async {
                context
                    .read<ArchiveBloc>()
                    .add(ArchiveUserAdded(archiveId: user.id));
                snackBarMessage(context, EnumLocale.addedToArchive.name.tr,
                    Theme.of(context));
                context.read<HomeBloc>().add(HomeUsersProfileList());
                controller.swipe(CardSwiperDirection.right);
              },
              icon: Icon(
                HugeIcons.strokeRoundedArchive,
                color: AppColors.black,
                size: 30.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//------------------ only for match page-------------------------
class LikeButtonForMatch extends StatelessWidget {
  final String id;
  const LikeButtonForMatch({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LikeBloc, LikeState, LikeModel>(
      selector: (state) => state.likeUserList,
      builder: (context, likeData) {
        return PlatformIconButton(
          onPressed: () {
            if (likeData.likeId.contains(id)) {
              context.read<LikeBloc>().add(LikeUserRemoved(likeId: id));
              debugPrint("unLike  ${id}");
            } else {
              context.read<LikeBloc>().add(LikeUserAdded(likeId: id));
              debugPrint("Like  ${id}");
            }
          },
          icon: Icon(
            likeData.likeId.contains(id)
                ? CupertinoIcons.hand_thumbsup_fill
                : CupertinoIcons.hand_thumbsup,
            color:
                likeData.likeId.contains(id) ? AppColors.blue : AppColors.black,
            size: 30.r,
          ),
        );
      },
    );
  }
}

//-----------------Starting chat from match from here-----------------------

class StartChatFromMatch extends StatefulWidget {
  const StartChatFromMatch({super.key, required this.profileModel});
  final ProfileModel profileModel;

  @override
  State<StartChatFromMatch> createState() => _StartChatFromMatchState();
}

class _StartChatFromMatchState extends State<StartChatFromMatch> {
  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
      context.read<RequestSenderBloc>().add(CheckingUserAvailableEvent(
          senderId: FirebaseAuth.instance.currentUser!.uid,
          receiverId: widget.profileModel.id));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestSenderBloc, RequestSenderState>(
      listener: _listener,
      child: BlocSelector<RequestSenderBloc, RequestSenderState, Requestmodel?>(
        selector: (state) {
          if (state is CheckingUserAvailableState) return state.userData;
          return null;
        },
        builder: (context, data) {
          return PlatformIconButton(
            onPressed: () {
              if (data == null) {
                final state = getIt<ProfileBloc>().state as ProfileLoaded;
                final currentUserData = state.data;
                print("current user name ${currentUserData.pseudo}");
                QuickAlert.show(
                  textAlignment: TextAlign.left,
                  widget: SizedBox.shrink(),
                  text:
                      "${EnumLocale.messageRequestsText1.name.tr} ${widget.profileModel.pseudo} ${EnumLocale.messageRequestsText2.name.tr} ",
                  headerBackgroundColor: AppColors.yellow,
                  backgroundColor: AppColors.floralWhite,
                  context: context,
                  confirmBtnText: EnumLocale.sendButtonText.name.tr,
                  cancelBtnText: EnumLocale.cancel.name.tr,
                  confirmBtnColor: AppColors.primaryColor,
                  showCancelBtn: true,
                  title: EnumLocale.sendRequest.name.tr,
                  type: QuickAlertType.info,
                  onCancelBtnTap: () {
                    print("message requests cancel !");
                    Get.back();
                  },
                  onConfirmBtnTap: () {
                    print("message requests send !");
                    context.read<RequestSenderBloc>().add(RequestSenderSend(
                          senderId: FirebaseAuth.instance.currentUser!.uid,
                          senderName: currentUserData.pseudo,
                          senderProfile: currentUserData.imgURL,
                          receiverId: widget.profileModel.id,
                          receiverName: widget.profileModel.pseudo,
                          receiverProfile: widget.profileModel.imgURL,
                        ));
                    Get.back();
                  },
                );
              } else {
                print("User Avaible !");
                print(data.responseStatus.toString());
                if (data.responseStatus.name == ResponseStatus.Initial.name) {
                  QuickAlert.show(
                    textAlignment: TextAlign.left,
                    widget: SizedBox.shrink(),
                    text:
                        "${widget.profileModel.pseudo} ${EnumLocale.requestInitialMessage.name.tr} ",
                    headerBackgroundColor: AppColors.yellow,
                    backgroundColor: AppColors.floralWhite,
                    context: context,
                    title: EnumLocale.requestInitial.name.tr,
                    type: QuickAlertType.info,
                    onConfirmBtnTap: () {
                      Get.back();
                    },
                  );
                } else if (data.responseStatus.name ==
                    ResponseStatus.Accepted.name) {
                  Get.to(
                    () => ChatScreen(
                      imgURL: widget.profileModel.imgURL,
                      receiverId: widget.profileModel.id,
                      receiverName: widget.profileModel.pseudo,
                    ),
                  );
                }
              }
            },
            icon: Icon(
              CupertinoIcons.chat_bubble,
              color: AppColors.black,
              size: 30,
            ),
          );
        },
      ),
    );
  }

  void _listener(context, state) {
    if (state is RequestsLoading) {
      customLoading(context);
    }
    if (state is ErrorInRequests) {
      Get.back();
      snackBarMessage(context, state.errorMessage, Theme.of(context));
    }
    if (state is RequestSendSuccessfully) {
      Get.back();
      snackBarMessage(
          context,
          "${EnumLocale.messageRequestsSend1.name.tr} ${widget.profileModel.pseudo} ${EnumLocale.messageRequestsSend2.name.tr} ",
          Theme.of(context));
    }
  }
}

// ---------pesudo, age and City--------------------------
class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.user});

  final ProfileModel user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            user.pseudo,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: AppColors.primaryColor),
          ),
          Text(
            "${user.age}",
            style: theme.bodyMedium,
          ),
          Text(
            user.city,
            style: theme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

//-----------------------Interest grid------------------------
class Interests extends StatelessWidget {
  const Interests({super.key, required this.user});
  final ProfileModel user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72.h,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        physics: NeverScrollableScrollPhysics(),
        itemCount: user.interests.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          childAspectRatio: 3,
        ),
        itemBuilder: (BuildContext context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            height: 20.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withAlpha(10),
                  blurRadius: 2.r,
                  spreadRadius: 2.r,
                  offset: Offset(0.4.w, 0.4.h),
                  blurStyle: BlurStyle.solid,
                ),
              ],
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.primaryColor, width: 1.w),
            ),
            child: Center(
              child: Text(
                user.interests[index],
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}

//---------------User description-------------------------
class Description extends StatelessWidget {
  const Description({super.key, required this.user});

  final ProfileModel user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
            color: AppColors.greyContainerColor,
            borderRadius: BorderRadius.circular(12.r)),
        child: Text(
          user.description,
          style: theme.bodyMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
