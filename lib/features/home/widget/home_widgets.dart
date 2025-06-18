//----------------AppBar -----------------------
import 'package:afriqueen/features/profile/bloc/profile_bloc.dart';
import 'package:afriqueen/features/profile/bloc/profile_state.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

//-------------------App Bar-------------------------------
class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => Get.toNamed(AppRoutes.preferences),
          icon: Icon(Icons.tune_outlined, size: 35.r),
        ),
      ],
      title: CityName(),
      leading: IconButton(
        onPressed: () => Get.toNamed(AppRoutes.profile),
        icon: Icon(LineIcons.user, size: 35.r),
      ),
    );
  }
}

class CityName extends StatelessWidget {
  const CityName({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileBloc, ProfileState, ProfileModel>(
        selector: (state) => state.data,
        builder: (context, model) => PlatformText(
              model.city,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 20.sp),
              overflow: TextOverflow.ellipsis,
            ));
  }
}
