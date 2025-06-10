import 'package:afriqueen/features/stories/bloc/stories_bloc.dart';
import 'package:afriqueen/features/stories/bloc/stories_event.dart';
import 'package:afriqueen/features/stories/bloc/stories_state.dart';
import 'package:afriqueen/features/stories/model/stories_model.dart';
import 'package:afriqueen/features/stories/repository/stories_repository.dart';
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
    return SliverToBoxAdapter(
        child:  BlocProvider(
                create: (context) =>
                    StoriesBloc(repo: getIt<StoriesRepository>())
                      ..add(StoriesFetching()),
                child: BlocSelector<StoriesBloc, StoriesState,
                    List<StoriesFetchModel>>(
                  selector: (state) => state.storiesData,
                  builder: (context, storiesData) {
                    return SizedBox(
                      height: 85.h,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemCount: 1 + storiesData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 0,
                                childAspectRatio: 1.2,
                                crossAxisSpacing: 0),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            // ----------------- "Add Story" Avatar -------------------
                            return OwnStories();
                          }

                          //---------------------Other user Stories--------------------------------
                          return GestureDetector(
                            onTap: () => Get.to(() =>
                                ViewStories(data: storiesData[index - 1])),
                            child: OtherUserStories(
                              data: storiesData[index - 1],
                            ),
                          );
                        },
                      ),
                    );
                  },
                )));
  }
}
