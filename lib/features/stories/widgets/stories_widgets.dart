import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/divider.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/features/stories/bloc/stories_bloc.dart';
import 'package:afriqueen/features/stories/bloc/stories_event.dart';
import 'package:afriqueen/features/stories/bloc/stories_state.dart';
import 'package:afriqueen/features/stories/model/stories_model.dart';
import 'package:afriqueen/features/stories/repository/stories_repository.dart';
import 'package:afriqueen/features/stories/screen/view_stories.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          style: Theme.of(context)
              .textTheme
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
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                iconSize: 25.r,
                                onPressed: () => showModalBottomSheet(
                                  constraints: BoxConstraints(
                                    minWidth: double.maxFinite,
                                  ),
                                  backgroundColor: AppColors.floralWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(8.r),
                                    ),
                                  ),
                                  context: context,
                                  builder: (bottomSheetContext) =>
                                      BlocProvider<StoriesBloc>(
                                    create: (blocContext) => StoriesBloc(
                                      repo: getIt<StoriesRepository>(),
                                    ),
                                    child: Builder(
                                      builder: (blocContext) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10.h,
                                              ),
                                              child: Text(
                                                EnumLocale.addStory.name.tr,
                                                style: Theme.of(blocContext)
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
                                            SizedBox(height: 25.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    blocContext
                                                        .read<StoriesBloc>()
                                                        .add(
                                                          StoriesImage(
                                                            name: profileData
                                                                .pseudo,
                                                            img: profileData
                                                                .imgURL,
                                                          ),
                                                        );

                                                    Navigator.pop(blocContext);
                                                  },
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .add_a_photo_outlined,
                                                        size: 50.r,
                                                      ),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      Text(EnumLocale
                                                          .addPhoto.name.tr),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 25.h),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
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
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
