import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/snackbar_message.dart';
import 'package:afriqueen/features/stories/bloc/stories_bloc.dart';
import 'package:afriqueen/features/stories/model/stories_model.dart';
import 'package:afriqueen/features/stories/screen/view_stories.dart';
import 'package:afriqueen/features/stories/widgets/stories_widgets.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';





class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoriesBloc, StoriesState>(
      listener: _onListener,
      child: SliverToBoxAdapter(
        child: BlocSelector<StoriesBloc, StoriesState, List<StoriesFetchModel>>(
          selector: (state) => state.storiesData,
          builder: (context, storiesData) {
            return SizedBox(
              height: 100.h, // Slightly more space to avoid pixel clipping
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                itemCount: 1 + storiesData.length,
                separatorBuilder: (_, __) => SizedBox(width: 10.w),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const OwnStories();
                  }
                  return GestureDetector(
                    onTap: () => Get.to(() => ViewStories(
                          data: storiesData[index - 1],
                        )),
                    child: OtherUserStories(data: storiesData[index - 1]),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

void _onListener(context, state) {
  if (state is Posting) {
    snackBarMessage(context, EnumLocale.posting.name.tr, Theme.of(context));
  }
  if (state is Posted) {
    getIt<StoriesBloc>().add(StoriesFetching());
    snackBarMessage(context, EnumLocale.posted.name.tr, Theme.of(context));
  }
}