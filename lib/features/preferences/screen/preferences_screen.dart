import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/divider.dart';
import 'package:afriqueen/features/preferences/bloc/preferences_bloc.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class PreferencesScreen extends StatelessWidget {
  //----------------Main Screen--------------
  PreferencesScreen({super.key});
  final _PreferencesBloc = getIt<PreferencesBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          EnumLocale.preferences.name.tr,
          style:
              Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 22.sp),
        ),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(HugeIcons.strokeRoundedMultiplicationSign)),
      ),
      body: BlocBuilder<PreferencesBloc, PreferencesState>(
        builder: (context, state) {
          return SafeArea(
              child: Padding(
            padding:
                EdgeInsetsGeometry.symmetric(horizontal: 15.w, vertical: 15.h),
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
                        onTap: () => _PreferencesBloc.add(
                            GenderPreferencesRequested(
                                isMenClicked: state.isMenClicked ? false : true,
                                men: state.isMenClicked
                                    ? EnumLocale.men.name.tr
                                    : '',
                                isWomenClicked: state.isWomenClicked,
                                women: state.women)),
                        child: Container(
                          height: 40.h,
                          width: 82.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: AppColors.greyContainerColor,
                              border: state.isMenClicked
                                  ? BoxBorder.all(
                                      color: AppColors.primaryColor, width: 1.w)
                                  : null),
                          child: Center(
                            child: Text(
                              EnumLocale.men.name.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppColors.black),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _PreferencesBloc.add(
                            GenderPreferencesRequested(
                                isWomenClicked:
                                    state.isWomenClicked ? false : true,
                                women: state.isWomenClicked
                                    ? EnumLocale.women.name.tr
                                    : '',
                                isMenClicked: state.isMenClicked,
                                men: state.men)),
                        child: Container(
                          height: 40.h,
                          width: 82.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: AppColors.greyContainerColor,
                              border: state.isWomenClicked
                                  ? BoxBorder.all(
                                      color: AppColors.primaryColor, width: 1.w)
                                  : null),
                          child: Center(
                            child: Text(
                              EnumLocale.women.name.tr,
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
                        onTap: () => _PreferencesBloc.add(
                            LocationPreferencesRequested(
                                isCountryClicked:
                                    state.isCountryClicked ? false : true,
                                country: state.isCountryClicked
                                    ? EnumLocale.sameCountry.name.tr
                                    : '',
                                isCityClicked: state.isCityClicked,
                                city: state.city)),
                        child: Container(
                          height: 40.h,
                          width: 82.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: AppColors.greyContainerColor,
                              border: state.isCountryClicked
                                  ? BoxBorder.all(
                                      color: AppColors.primaryColor, width: 1.w)
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
                        onTap: () => _PreferencesBloc.add(
                            LocationPreferencesRequested(
                                isCityClicked:
                                    state.isCityClicked ? false : true,
                                city: state.isCityClicked
                                    ? EnumLocale.sameCity.name.tr
                                    : '',
                                isCountryClicked: state.isCountryClicked,
                                country: state.country)),
                        child: Container(
                          height: 40.h,
                          width: 82.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: AppColors.greyContainerColor,
                              border: state.isCityClicked
                                  ? BoxBorder.all(
                                      color: AppColors.primaryColor, width: 1.w)
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
      ),
    );
  }
}
