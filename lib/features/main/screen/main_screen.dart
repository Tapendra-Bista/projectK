import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/features/add/screen/add_screen.dart';
import 'package:afriqueen/features/archive/bloc/archive_bloc.dart';
import 'package:afriqueen/features/archive/bloc/archive_event.dart';
import 'package:afriqueen/features/block/bloc/block_bloc.dart';
import 'package:afriqueen/features/block/bloc/block_event.dart';
import 'package:afriqueen/features/chat/bloc/chat_bloc.dart';
import 'package:afriqueen/features/chat/bloc/chat_event.dart';
import 'package:afriqueen/features/chat/screen/chat_rooms_screen.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_bloc.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_event.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_event.dart';
import 'package:afriqueen/features/home/screen/home_screen.dart';
import 'package:afriqueen/features/like/bloc/like_bloc.dart';
import 'package:afriqueen/features/like/bloc/like_event.dart';
import 'package:afriqueen/features/match/screen/match_screen.dart';
import 'package:afriqueen/features/profile/bloc/profile_bloc.dart';
import 'package:afriqueen/features/profile/bloc/profile_event.dart';
import 'package:afriqueen/features/reels/screen/reels_screen.dart';
import 'package:afriqueen/features/stories/bloc/stories_bloc.dart';
import 'package:afriqueen/features/stories/bloc/stories_event.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:afriqueen/services/status/repository/status_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hugeicons/hugeicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgets = [
    HomeScreen(),
    MatchScreen(),
    AddScreen(),
    ChatRoomsScreen(),
    ReelsScreen(),
  ];

  @override
  void initState() {
    super.initState();

    if (FirebaseAuth.instance.currentUser != null) {
      StatusRepository().setupUserPresence();
      getIt<BlockBloc>().add(BlockUsersFetched());
      getIt<StoriesBloc>().add(StoriesFetching());
      getIt<ProfileBloc>().add(ProfileFetch());
      getIt<FavoriteBloc>().add(FavoriteUsersFetched());
      getIt<LikeBloc>().add(LikeUsersFetched());
      getIt<ArchiveBloc>().add(ArchiveUsersFetched());
      getIt<HomeBloc>().add(HomeUsersFetched());
      getIt<ChatBloc>()
          .add(ChatRoomsLists(id: FirebaseAuth.instance.currentUser!.uid));
      getIt<HomeBloc>().add(HomeUsersProfileList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgets[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.floralWhite,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: GNav(
              rippleColor: AppColors.grey.withValues(alpha: 0.2),
              hoverColor: AppColors.grey.withValues(alpha: 0.2),
              gap: 8.w,
              activeColor: AppColors.primaryColor,
              iconSize: 24.r,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: AppColors.grey.withValues(alpha: 0.2),
              color: Colors.black,
              tabs: [
                GButton(
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                  iconSize: 27.r,
                  gap: 5.w,
                  icon: HugeIcons.strokeRoundedLocation01,
                ),
                GButton(
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                  gap: 5.w,
                  iconSize: 27.r,
                  icon: HugeIcons.strokeRoundedCards01,
                ),
                GButton(
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                  gap: 5.w,
                  iconSize: 27.r,
                  icon: CupertinoIcons.plus,
                ),
                GButton(
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                  gap: 5.w,
                  iconSize: 27.r,
                  icon: CupertinoIcons.chat_bubble,
                ),
                GButton(
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                  iconSize: 27.r,
                  gap: 5.w,
                  icon: CupertinoIcons.play_arrow,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
