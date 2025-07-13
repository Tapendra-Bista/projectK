import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/constant/constant_strings.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/wellcome/bloc/wellcome_bloc.dart';
import 'package:afriqueen/routes/app_routes.dart';
import 'package:afriqueen/services/storage/get_storage.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//------------------------Next Button ----------------------------------
// pure isolate-safe function
Future<void> simpleDelay(_) async {
  await Future.delayed(Duration(milliseconds: 1500));
}

class NextButton extends StatefulWidget {
  NextButton({super.key});

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  final AppGetStorage _appGetStorage = AppGetStorage();
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40.h, // Slightly increased height for better touch target
        width: 200.w,
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              isClicked = true;
            });

            await compute(simpleDelay, null); // isolate-safe

            // This runs on the main isolate (safe)
            _appGetStorage.setHasOpenedApp();
            if (context.mounted) {
              Get.offAllNamed(AppRoutes.login);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            fixedSize: Size(200.w, 40.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Container(
              alignment: Alignment.center,
              child: isClicked
                  ? CircularProgressIndicator(color: AppColors.floralWhite)
                  : PlatformText(
                      EnumLocale.next.name.tr,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                    ),

              // Show indicator if loading and it's the login button
            ),
          ),
        ),
      ),
    );
  }
}

//--------------------Welcome page description----------------------------
class WelcomeDescription extends StatelessWidget {
  const WelcomeDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Text(
      EnumLocale.welcomeDescriptionText.name.tr,
      style: theme.bodySmall,
    );
  }
}

//-----------------Wellcome Text      and  langugage selector drop down-----------------------------
class WellcomeTextAndDropDown extends StatelessWidget {
  const WellcomeTextAndDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(EnumLocale.welcome.name.tr, style: theme.bodyLarge),
        DropDownForLanguage(),
      ],
    );
  }
}

//------------------Languages of _appGetStorage------------------------
class DropDownForLanguage extends StatelessWidget {
  DropDownForLanguage({super.key});

  final DropdownController controller = DropdownController();

  final List<CoolDropdownItem<String>> country = [
    CoolDropdownItem(
      label: "Français",
      value: "fr",
      icon: Image.asset(AppStrings.fr, height: 30.h, width: 30.w),
      selectedIcon: Image.asset(AppStrings.fr, height: 30.h, width: 30.w),
    ),
    CoolDropdownItem(
      label: "English",
      value: "en",
      icon: Image.asset(AppStrings.us, height: 30.h, width: 30.w),
      selectedIcon: Image.asset(AppStrings.us, height: 30.h, width: 30.w),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WellcomeBloc, WellcomeState>(
      builder: (context, state) {
        final defaultItem = country.firstWhere(
          (item) => item.value == state.languageCode,
          orElse: () => country[0],
        );

        return SizedBox(
          height: 50.h,
          width: 90.w,
          child: CoolDropdown(
            controller: controller,
            dropdownList: country,
            defaultItem: defaultItem,
            onChange: (value) {
              context.read<WellcomeBloc>().add(
                ChangeLanguage(languageCode: value),
              );

              controller.close();
            },
            dropdownItemOptions: DropdownItemOptions(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            dropdownOptions: DropdownOptions(width: 130.w),
            resultOptions: ResultOptions(
              render: ResultRender.icon,
              placeholder: "Select Language",
              alignment: Alignment.centerRight,
              placeholderTextStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
              boxDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.primaryColor),
              ),
            ),
          ),
        );
      },
    );
  }
}

//-------------------center image logo----------------------------

class CenterImage extends StatefulWidget {
  const CenterImage({super.key});

  @override
  State<CenterImage> createState() => _CenterImageState();
}

class _CenterImageState extends State<CenterImage> {
  final image = AssetImage(AppStrings.couple);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(image, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Image(image: image));
  }
}
