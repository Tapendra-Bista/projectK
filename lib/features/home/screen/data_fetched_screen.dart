//------------ main part of data fetched state-----------------

import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_event.dart';
import 'package:afriqueen/features/home/widget/data_fetched_screen_widgets.dart';
import 'package:afriqueen/features/home/widget/home_widgets.dart';
import 'package:afriqueen/features/stories/screen/stories_screen.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDataContent extends StatelessWidget {
  const HomeDataContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      color: AppColors.primaryColor,
      backgroundColor: AppColors.floralWhite,
      onRefresh: () async {
        getIt<HomeBloc>().add(HomeUsersProfileList());
      },
      child: CustomScrollView(
        slivers: [
          //-------------------app bar-------------------
          const HomeAppBar(),
          //-------------------Stories-------------------
          const StoriesScreen(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              //-----------User profile grid-------------------------
              child: const UserImageGrid(),
            ),
          ),
        ],
      ),
    ));
  }
}
