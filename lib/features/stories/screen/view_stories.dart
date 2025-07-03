import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/widgets/seniority.dart';
import 'package:afriqueen/features/stories/model/stories_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_story_view/flutter_story_view.dart';
import 'package:flutter_story_view/models/story_item.dart';
import 'package:get/get.dart';

class ViewStories extends StatefulWidget {
  const ViewStories({super.key, required this.data});
  final StoriesFetchModel data;

  @override
  State<ViewStories> createState() => _ViewStoriesState();
}

class _ViewStoriesState extends State<ViewStories> {
  int currentIndex = 0;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          initialized = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return PlatformScaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              FlutterStoryView(
                showReplyButton: false,
                indicatorPadding: REdgeInsets.only(top: 30.h),
                storyItems: widget.data.containUrl.map((imgUrl) {
                  return StoryItem(
                    url: imgUrl,
                    type: StoryItemType.image,
                    duration: 4,
                  );
                }).toList(),
                onComplete: () {
                  Get.back();
                },
                onPageChanged: (index) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        currentIndex = index;
                      });
                    }
                  });
                },
                indicatorColor: Colors.grey[500],
                indicatorHeight: 2,
                indicatorValueColor: Colors.white,
              ),

              // User avatar + name + time
              Positioned(
                top: 38.h,
                left: 10.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdvancedAvatar(
                      foregroundDecoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.floralWhite,
                        shape: BoxShape.circle,
                      ),
                      image: CachedNetworkImageProvider(widget.data.userImg),
                      size: 40.r,
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.userName,
                          style: theme.bodyMedium!
                              .copyWith(color: AppColors.floralWhite),
                        ),
                        Text(
                          (initialized &&
                                  widget.data.createdDate.length > currentIndex)
                              ? Seniority.formatStoriesTime(
                                  widget.data.createdDate[currentIndex])
                              : '',
                          style: theme.bodySmall!
                              .copyWith(color: AppColors.floralWhite),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
