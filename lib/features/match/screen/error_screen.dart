import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/home/bloc/home_bloc.dart';
import 'package:afriqueen/features/home/bloc/home_state.dart';
import 'package:afriqueen/routes/app_routes.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ErrorWhileFetching extends StatelessWidget {
  const ErrorWhileFetching({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, String?>(
      bloc: getIt<HomeBloc>(),
      selector: (state) {
        if (state is Error) {
          return state.error;
        }
        return EnumLocale.defaultError.name.tr;
      },
      builder: (context, message) {
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
          body: Center(
            child:
                Text(message!, style: Theme.of(context).textTheme.bodyMedium),
          ),
        );
      },
    );
  }
}
