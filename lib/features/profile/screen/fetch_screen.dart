//------------ main part of data fetched state-----------------
import 'package:afriqueen/features/profile/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDataContent extends StatelessWidget {
  const ProfileDataContent({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: CustomScrollView(
        slivers: [
          //-------------------app bar-------------------
          const ProfilePlatformAppBar(),
          //---------------User Profile Image--------------------
          ProfileImage(),
          const UserSeniority(),
          //---------------User Profile Details--------------------
          const UserDetails(),

          //------------------------------ user interests------------------------------
          const UserInterestsList(),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          const DescriptionText(),
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
        ],
      ),
    );
  }
}
