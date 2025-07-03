import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/constant/constant_strings.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/report/bloc/report_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//---------------- Illegal contant----------------
class IllegalContant extends StatelessWidget {
  const IllegalContant({
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
              bloc: context.read<ReportBloc>(),
              selector: (state) {
                if (state is Illegal) {
                  return state.illegal;
                }

                return null;
              },
              builder: (context, illegal) {
                return Text(
                  illegal ?? EnumLocale.unLawfulContent.name.tr,
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
              color: AppColors.black,
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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: Align(
          alignment: Alignment.centerLeft,
          child: PlatformIconButton(
              onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
        )),
        SliverPadding(
          padding: EdgeInsetsGeometry.only(left: 4.w, bottom: 10.h),
          sliver: SliverToBoxAdapter(
            child: Text(
              EnumLocale.whyAreYouReporting.name.tr,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20.sp,
                    color: AppColors.red,
                  ),
            ),
          ),
        ),
        SliverList.builder(
            itemCount: AppStrings.illegalContentList.length,
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    context.read<ReportBloc>().add(IllegalChoosen(
                        illegal: AppStrings.illegalContentList[index]));
                    print("Printed ${AppStrings.illegalContentList[index]}");
                    Get.back();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: AppColors.greyContainerColor),
                    child: Center(
                        child: Text(
                      AppStrings.illegalContentList[index],
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
