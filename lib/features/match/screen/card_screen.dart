import 'dart:math';

import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_state.dart';
import 'package:afriqueen/features/match/widget/card_screen_widget.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/routes/app_routes.dart';
import 'package:confetti/confetti.dart';
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
  final confettiController = ConfettiController(duration: Duration(seconds: 1));
  final random = Random();
  @override
  void dispose() {
    controller.dispose();
    confettiController.dispose(); // dispose confetti controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
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
            child: userData.length >= 2
                ? Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: CardSwiper(
                              initialIndex: userData.isNotEmpty
                                  ? random.nextInt(userData.length)
                                  : 0,
                              threshold: 100,
                              onSwipe:
                                  (previousIndex, currentIndex, direction) {
                                if (direction == CardSwiperDirection.right) {
                                  confettiController.play();
                                  controller.swipe(CardSwiperDirection.right);
                                }

                                if (direction == CardSwiperDirection.left) {
                                  controller.swipe(CardSwiperDirection.left);
                                }
                                return true;
                              },
                              allowedSwipeDirection: AllowedSwipeDirection.only(
                                left: true,
                                right: true,
                                up: false,
                                down: false,
                              ),
                              maxAngle: 60,
                              isDisabled: false,
                              controller: controller,
                              duration: Duration(milliseconds: 500),
                              numberOfCardsDisplayed: 1,
                              padding: EdgeInsets.only(
                                  left: 5.w,
                                  right: 5.w,
                                  top: 10.h,
                                  bottom: 33.h),
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
                                      left: BorderSide(
                                          color: AppColors.grey, width: 1.w),
                                      right: BorderSide(
                                          color: AppColors.grey, width: 1.w),
                                      bottom: BorderSide(
                                          color: AppColors.grey, width: 1.w),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional.topCenter,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 10.h,
                                      children: [
                                        ImageAndStatus(user: item!),
                                        UserDetails(user: item),
                                        ListOfButtons(
                                            user: item, controller: controller),
                                        SizedBox(
                                          height: 5.h,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              cardsCount: userData.length,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: FloatingActionButton.small(
                                  heroTag: "hero1",
                                  shape: CircleBorder(),
                                  backgroundColor: AppColors.red,
                                  onPressed: () => controller
                                      .swipe(CardSwiperDirection.left),
                                  child: Icon(
                                    Icons.close_outlined,
                                    color: AppColors.floralWhite,
                                  ),
                                ),
                              ),
                              SizedBox(width: 30.w),
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: FloatingActionButton.small(
                                  heroTag: "hero2",
                                  backgroundColor: AppColors.green,
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    confettiController.play();
                                    // Play confetti
                                    controller.swipe(CardSwiperDirection.right);
                                  },
                                  child: Icon(
                                    Icons.check_outlined,
                                    color: AppColors.floralWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                      // Confetti effect
                      Align(
                        alignment: Alignment.topCenter,
                        child: ConfettiWidget(
                          confettiController: confettiController,
                          blastDirectionality: BlastDirectionality.explosive,
                          shouldLoop: false,
                          maxBlastForce: 10,
                          minBlastForce: 5,
                          numberOfParticles: 20,
                          gravity: 0.3,
                          colors: [
                            AppColors.black,
                            AppColors.green,
                            AppColors.green,
                            AppColors.blue,
                            AppColors.yellow,
                            AppColors.primaryColor,
                            AppColors.red,
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      EnumLocale.atLeastTwoUsers.name.tr,
                      style: theme.bodySmall,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
