//-------------------Image and status------------------------------
import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/seniority.dart';
import 'package:afriqueen/common/widgets/snackbar_message.dart';
import 'package:afriqueen/common/widgets/user_status.dart';
import 'package:afriqueen/features/archive/bloc/archive_bloc.dart';
import 'package:afriqueen/features/archive/bloc/archive_event.dart';
import 'package:afriqueen/features/chat/screen/chat_screen.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_bloc.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_event.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_event.dart';
import 'package:afriqueen/features/like/bloc/like_bloc.dart';
import 'package:afriqueen/features/like/bloc/like_event.dart';
import 'package:afriqueen/features/like/bloc/like_state.dart';
import 'package:afriqueen/features/like/model/like_model.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/features/user_details/screen/user_details_screen.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
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
            height: 260.h,
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
    return Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
            color: AppColors.greyContainerColor,
            borderRadius: BorderRadius.circular(12.r)),
        child: Text(Seniority.formatJoinedTime(user.createdDate),
            style: Theme.of(context).textTheme.bodyMedium));
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
    return Container(
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
              getIt<HomeBloc>().add(HomeUsersProfileList());
              controller.swipe(CardSwiperDirection.right);
            },
            icon: Icon(Icons.favorite_border_outlined,
                size: 20.r, color: AppColors.black),
          ),
          // ------------------following-----------------
          PlatformIconButton(
              onPressed: () {
                snackBarMessage(
                    context,
                    "${EnumLocale.following.name.tr} ${user.pseudo}",
                    Theme.of(context));
                controller.swipe(CardSwiperDirection.right);
              },
              icon: Icon(
                Icons.person_add_outlined,
                color: AppColors.black,
                size: 20.r,
              )),
//----------Archive--------------------------
          PlatformIconButton(
            onPressed: () async {
              context
                  .read<ArchiveBloc>()
                  .add(ArchiveUserAdded(archiveId: user.id));
              snackBarMessage(context, EnumLocale.addedToArchive.name.tr,
                  Theme.of(context));
              getIt<HomeBloc>().add(HomeUsersProfileList());
              controller.swipe(CardSwiperDirection.right);
            },
            icon: Icon(
              LineIcons.archive,
              color: AppColors.black,
              size: 20.r,
            ),
          ),
        ],
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
              getIt<LikeBloc>().add(LikeUserRemoved(likeId: id));
              debugPrint("unLike  ${id}");
            } else {
              getIt<LikeBloc>().add(LikeUserAdded(likeId: id));
              debugPrint("Like  ${id}");
            }
          },
          icon: Icon(
            likeData.likeId.contains(id)
                ? Icons.thumb_up_rounded
                : Icons.thumb_up_alt_outlined,
            color:
                likeData.likeId.contains(id) ? AppColors.blue : AppColors.black,
            size: 20.r,
          ),
        );
      },
    );
  }
}

//-----------------Starting chat from match from here-----------------------
class StartChatFromMatch extends StatelessWidget {
  const StartChatFromMatch({super.key, required this.profileModel});
  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    // innerContext now has access to ChatBloc
    return PlatformIconButton(
      onPressed: () {
        // Use innerContext here

        Get.to(() => ChatScreen(
              imgURL: profileModel.imgURL,
              receiverId: profileModel.id,
              receiverName: profileModel.pseudo,
            ));
      },
      icon: Icon(
        CupertinoIcons.chat_bubble,
        color: AppColors.black,
        size: 20.r,
      ),
    );
  }
}

// ---------pesudo, age and City--------------------------
class UserDetails extends StatelessWidget {
  const UserDetails({super.key, required this.user});

  final ProfileModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          user.pseudo,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: AppColors.primaryColor),
        ),
        Text(
          "${user.age}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          user.city,
          style: Theme.of(context).textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
        ),
      ],
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
          style: Theme.of(context).textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
