import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/common_button.dart';
import 'package:afriqueen/features/report/bloc/report_bloc.dart';
import 'package:afriqueen/features/report/screen/guideline_violation_screen.dart';
import 'package:afriqueen/features/report/screen/illegal_contant_screen.dart';
import 'package:afriqueen/features/report/widgets/report_screen_widgets.dart';
import 'package:afriqueen/routes/app_routes.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class ReportScreen extends StatefulWidget {
  ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      
      buildWhen: (previous, current) {
        if (current is Violation || current is Illegal) {
          return _show = true;
        }
        return _show;
      },
      bloc: getIt<ReportBloc>(),
      builder: (context, state) {
        return PlatformScaffold(
          appBar: PlatformAppBar(
            automaticallyImplyLeading: false,
            leading: PlatformIconButton(
                onPressed: () => Get.back(),
                icon: Icon(HugeIcons.strokeRoundedMultiplicationSign)),
          ),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  //----------- title text------------
                  const TitleText(),
                  //---------description---------------
                  const MiniDescriptionText(),
                  SizedBox(
                    height: 5.h,
                  ),
                  //---------Guideline Violation-----------
                  const GuidelinesViolation(),
                  //--------Report description ----------------------
                  const ReportDescriptionOne(),
                  SizedBox(
                    height: 10.h,
                  ),
                  //------------------ Illegal Contant------------------------
                  const IllegalContant(),
                  //--------Report description ----------------------
                  const ReportDescriptionTwo(),
                  SizedBox(
                    height: 10.h,
                  ),
                  _show
                      ? CommonButton(
                          onPressed: () => Get.toNamed(AppRoutes.sendReport),
                          buttonText: EnumLocale.next.name.tr,
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
