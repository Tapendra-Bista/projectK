import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/constant/constant_strings.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/report/bloc/report_bloc.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//--------------- Guidelines Violation-----------------
class GuidelinesViolation extends StatelessWidget {
  const GuidelinesViolation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
          isScrollControlled: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.zero),
          useSafeArea: true,
          backgroundColor: AppColors.floralWhite,
          context: context,
          builder: (context) => BottomSheetContant()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        height: 40.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.greyContainerColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocSelector<ReportBloc, ReportState, String?>(
              bloc: getIt<ReportBloc>(),
              selector: (state) {
                if (state is Violation) {
                  return state.violation;
                }

                return null;
              },
              builder: (context, violation) {
                print(violation);
                return Text(
                  violation ?? EnumLocale.violationOfGuidenlines.name.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.black, fontSize: 14.sp),
                  overflow: TextOverflow.ellipsis,
                );
              },
            ),
            Icon(
              CupertinoIcons.chevron_down,
              size: 18.sp,
              color: AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}

class BottomSheetContant extends StatelessWidget {
  const BottomSheetContant({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
        Text(
          EnumLocale.whyAreYouReporting.name.tr,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.red,
              ),
        ),
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            physics: NeverScrollableScrollPhysics(),
            itemCount: AppStrings.guidelineViolationList.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    getIt<ReportBloc>().add(ViolationChoosen(
                        violation: AppStrings.guidelineViolationList[index]));
                    print(
                        "Printed ${AppStrings.guidelineViolationList[index]}");
                    Get.back();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: AppColors.greyContainerColor,),
                    child: Center(
                        child: Text(
                      AppStrings.guidelineViolationList[index],
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )),
                  ),
                ))
      ],
    );
  }
}
