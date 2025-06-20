import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_state.dart';
import 'package:afriqueen/features/match/widget/card_screen_widget.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final CardSwiperController controller = CardSwiperController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, List<ProfileModel?>>(
      selector: (state) => state.profileList,
      builder: (context, userData) {
        return PlatformScaffold(
          appBar: PlatformAppBar(
            material: (context, platform) {
              return MaterialAppBarData(centerTitle: true);
            },
            title: PlatformText(
              EnumLocale.match.name.tr,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 20.sp),
              overflow: TextOverflow.ellipsis,
            ),
            leading: PlatformIconButton(
              onPressed: () => Get.toNamed(AppRoutes.profile),
              icon: Icon(LineIcons.user, size: 35.r),
            ),
          ),
          body: SafeArea(
              child: Center(
            child: SizedBox(
              height: 540,
              child: userData.length >= 2
                  ? CardSwiper(
                      controller: controller,
                      duration: Duration(milliseconds: 100),
                      numberOfCardsDisplayed: 2,
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 5.w),
                      cardBuilder: (
                        context,
                        index,
                        horizontalThresholdPercentage,
                        verticalThresholdPercentage,
                      ) {
                        final item = userData[index];
                        return Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: AppColors.floralWhite,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border(
                              left:
                                  BorderSide(color: AppColors.grey, width: 1.w),
                              right:
                                  BorderSide(color: AppColors.grey, width: 1.w),
                              bottom:
                                  BorderSide(color: AppColors.grey, width: 1.w),
                            ),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Column(
                              spacing: 5.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ImageAndStatus(user: item!),
                                ListOfButtons(
                                    user: item, controller: controller),
                                UserDetails(user: item),
                                Interests(
                                  user: item,
                                ),
                                Description(user: item)
                              ],
                            ),
                          ),
                        );
                      },
                      cardsCount: userData.length)
                  : Center(
                      child: Text(
                        EnumLocale.atLeastTwoUsers.name.tr,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
            ),
          )),
        );
      },
    );
  }
}
