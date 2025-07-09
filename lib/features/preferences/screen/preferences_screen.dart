import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/divider.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_event.dart';
import 'package:afriqueen/features/preferences/bloc/preferences_bloc.dart';
import 'package:afriqueen/features/profile/bloc/profile_bloc.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class PreferencesScreen extends StatelessWidget {
  //----------------Main Screen--------------
  PreferencesScreen({super.key});
  final _PreferencesBloc = getIt<PreferencesBloc>();
  final _homeBloc = getIt<HomeBloc>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        material: (context, platform) {
          return MaterialAppBarData(centerTitle: true);
        },
        title: Text(
          EnumLocale.preferences.name.tr,
          style: theme.bodyMedium!.copyWith(fontSize: 22.sp),
        ),
        leading: PlatformIconButton(
            onPressed: () => Get.back(),
            icon: Icon(HugeIcons.strokeRoundedMultiplicationSign)),
      ),
      body: BlocBuilder<PreferencesBloc, PreferencesState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          return BlocSelector<ProfileBloc, ProfileState, ProfileModel>(
            selector: (state) =>
                (state is ProfileLoaded) ? state.data : ProfileModel.empty(),
            builder: (context, CurrentUserData) {
              return SafeArea(
                  child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                    horizontal: 15.w, vertical: 15.h),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15.h,
                    children: [
                      CustomDivider(),
                      Text(
                        EnumLocale.likeToMeet.name.tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 18.sp),
                      ),
                      Row(
                        spacing: 10.w,
                        children: [
                          InkWell(
                            onTap: () {
                              final toggledIsMenClicked = !state.isMenClicked;
                              _PreferencesBloc.add(GenderPreferencesRequested(
                                  isMenClicked: toggledIsMenClicked,
                                  men: toggledIsMenClicked
                                      ? EnumLocale.genderMale.name.tr
                                      : '',
                                  isWomenClicked: state.isWomenClicked,
                                  women: state.women));

                              _homeBloc.add(HomeUsersProfileList());
                            },
                            child: Container(
                              height: 40.h,
                              width: 82.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: AppColors.greyContainerColor,
                                  border: state.isMenClicked
                                      ? BoxBorder.all(
                                          color: AppColors.primaryColor,
                                          width: 1.w)
                                      : null),
                              child: Center(
                                child: Text(
                                  EnumLocale.genderMale.name.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.black),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final toggledIsWomenClicked =
                                  !state.isWomenClicked;
                              _PreferencesBloc.add(GenderPreferencesRequested(
                                  isWomenClicked: toggledIsWomenClicked,
                                  women: toggledIsWomenClicked
                                      ? EnumLocale.genderFemale.name.tr
                                      : '',
                                  isMenClicked: state.isMenClicked,
                                  men: state.men));
                              _homeBloc.add(HomeUsersProfileList());
                            },
                            child: Container(
                              height: 40.h,
                              width: 82.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: AppColors.greyContainerColor,
                                  border: state.isWomenClicked
                                      ? BoxBorder.all(
                                          color: AppColors.primaryColor,
                                          width: 1.w)
                                      : null),
                              child: Center(
                                child: Text(
                                  EnumLocale.genderFemale.name.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      CustomDivider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            EnumLocale.age.name.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 18.sp),
                          ),
                          Text(
                            "${state.start.toInt()}-${state.end.toInt()} ${EnumLocale.years.name.tr}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 18.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      RangeSlider(
                          min: 18,
                          max: 60,
                          labels: RangeLabels(
                              state.start.toString(), state.end.toString()),
                          inactiveColor: AppColors.grey,
                          activeColor: AppColors.primaryColor,
                          values: RangeValues(state.start, state.end),
                          onChanged: (RangeValues newValue) {
                            _PreferencesBloc.add(AgePreferencesRequested(
                                newValue.start, newValue.end));

                            _homeBloc.add(HomeUsersProfileList());
                          }),
                      SizedBox(
                        height: 35.h,
                      ),
                      CustomDivider(),
                      Text(
                        EnumLocale.same.name.tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 18.sp),
                      ),
                      Row(
                        spacing: 10.w,
                        children: [
                          InkWell(
                            onTap: () {
                              final toggledIsCountryClicked =
                                  !state.isCountryClicked;
                              _PreferencesBloc.add(LocationPreferencesRequested(
                                  isCountryClicked: toggledIsCountryClicked,
                                  country: toggledIsCountryClicked
                                      ? CurrentUserData.country
                                      : '',
                                  isCityClicked: state.isCityClicked,
                                  city: state.city));
                              _homeBloc.add(HomeUsersProfileList());
                            },
                            child: Container(
                              height: 40.h,
                              width: 82.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: AppColors.greyContainerColor,
                                  border: state.isCountryClicked
                                      ? BoxBorder.all(
                                          color: AppColors.primaryColor,
                                          width: 1.w)
                                      : null),
                              child: Center(
                                child: Text(
                                  EnumLocale.sameCountry.name.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.black),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              final toggledIsCityClicked = !state.isCityClicked;
                              _PreferencesBloc.add(LocationPreferencesRequested(
                                  isCityClicked: toggledIsCityClicked,
                                  city: toggledIsCityClicked
                                      ? CurrentUserData.city
                                      : '',
                                  isCountryClicked: state.isCountryClicked,
                                  country: state.country));
                              _homeBloc.add(HomeUsersProfileList());
                            },
                            child: Container(
                              height: 40.h,
                              width: 82.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.r),
                                  color: AppColors.greyContainerColor,
                                  border: state.isCityClicked
                                      ? BoxBorder.all(
                                          color: AppColors.primaryColor,
                                          width: 1.w)
                                      : null),
                              child: Center(
                                child: Text(
                                  EnumLocale.sameCity.name.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      CustomDivider(),
                      SizedBox(
                        height: 10.w,
                      ),
                    ],
                  ),
                ),
              ));
            },
          );
        },
      ),
    );
  }
}
