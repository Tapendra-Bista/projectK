import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/divider.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/features/stories/bloc/stories_bloc.dart';
import 'package:afriqueen/features/stories/bloc/stories_event.dart';
import 'package:afriqueen/features/stories/bloc/stories_state.dart';
import 'package:afriqueen/features/stories/model/stories_model.dart';
import 'package:afriqueen/features/stories/screen/view_stories.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//---------------------Other user Stories--------------------------------
class OtherUserStories extends StatelessWidget {
  const OtherUserStories({
    super.key,
    required this.data,
  });

  final StoriesFetchModel data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final isValidImage = Uri.tryParse(data.userImg)!.hasAbsolutePath == true;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AdvancedAvatar(
          foregroundDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryColor,
              width: 2.5,
            ),
          ),
          decoration: const BoxDecoration(
            color: AppColors.floralWhite,
            shape: BoxShape.circle,
          ),
          image: isValidImage ? CachedNetworkImageProvider(data.userImg) : null,
          size: 75.r,
        ),
        Text(
          data.userName,
          style: theme
              .bodySmall!
              .copyWith(color: AppColors.black, fontSize: 11.2.sp),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}

//---------------------Current user Stories--------------------------------
class OwnStories extends StatelessWidget {
  const OwnStories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return BlocSelector<StoriesBloc, StoriesState, StoriesFetchModel>(
        selector: (state) => state.currentUserStoriesData,
        builder: (context, currentUserStoriesData) {
          return GestureDetector(
              onTap: () {
                if (currentUserStoriesData.containUrl.isNotEmpty) {
                  Get.to(() => ViewStories(data: currentUserStoriesData));
                }
              },
              child: BlocSelector<StoriesBloc, StoriesState, ProfileModel>(
                selector: (state) => state.profileData,
                builder: (context, profileData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AdvancedAvatar(
                        foregroundDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 2.5,
                          ),
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.floralWhite,
                          shape: BoxShape.circle,
                        ),
                        image:
                            Uri.tryParse(profileData.imgURL)!.hasAbsolutePath ==
                                    true
                                ? CachedNetworkImageProvider(profileData.imgURL)
                                : null,
                        size: 75.r,
                        children: [
                          Positioned(
                            right: -0.4,
                            bottom: -0.4,
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: PlatformIconButton(
                                padding: EdgeInsets.zero,
                                material: (context, platform) =>
                                    MaterialIconButtonData(
                                  constraints: const BoxConstraints(),
                                  iconSize: 25.r,
                                ),
                                onPressed: () => showModalBottomSheet(
                                    constraints: BoxConstraints(
                                      minWidth: double.maxFinite,
                                    ),
                                    backgroundColor: AppColors.floralWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(32.r),
                                      ),
                                    ),
                                    context: context,
                                    builder: (bottomSheetContext) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10.h,
                                              ),
                                              child: Text(
                                                EnumLocale.addStory.name.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontSize: 25.sp,
                                                    ),
                                              ),
                                            ),
                                            const CustomDivider(),
                                            InkWell(
                                              onTap: () {
                                                context.read<StoriesBloc>().add(
                                                      StoriesImage(
                                                        name:
                                                            profileData.pseudo,
                                                        img: profileData.imgURL,
                                                      ),
                                                    );

                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: double.maxFinite,
                                                height: 60.h,
                                                color: AppColors
                                                    .greyContainerColor,
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    spacing: 15.w,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .collections_outlined,
                                                        size: 30.sp,
                                                      ),
                                                      Text(EnumLocale
                                                          .addPhoto.name.tr),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                icon: Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: AppColors.floralWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        EnumLocale.yourStory.name.tr,
                        style: theme.bodySmall!.copyWith(
                            color: AppColors.black, fontSize: 11.2.sp),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  );
                },
              ));
        });
  }
}
