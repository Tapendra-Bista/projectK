import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/snackbar_message.dart';
import 'package:afriqueen/features/email_verification/bloc/email_verification_bloc.dart';
import 'package:afriqueen/features/email_verification/bloc/email_verification_state.dart';
import 'package:afriqueen/features/email_verification/widget/email_verification_widget.dart';
import 'package:afriqueen/routes/app_routes.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  _dispose() async {
    getIt<EmailVerificationBloc>().close();
    await getIt.resetLazySingleton<EmailVerificationBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SafeArea(
        child: BlocProvider<EmailVerificationBloc>(
          create: (context) => getIt<EmailVerificationBloc>(),
          child: BlocListener<EmailVerificationBloc, EmailVerificationState>(
            listener: _listener,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 5.h,
                  children: [
                    //--------------- Title part----------------------
                    const EmailVerificationTitle(),
                    //-------------------Body text part------------------------
                    const EmailVerificationBody(),
                    //-----------------------Logo part---------------------------------------
                    const EmailVerificationImage(),
                    SizedBox(height: 50.h),
                    //-----------------------Email verification Button--------------------------------
                    EmailVerificationButton(),

                    //----------------------------- To  navigate to another page-------------------
                    SizedBox(height: 10.h),
                    //------------------------------- Delete Text ---------------------------------------
                    const EmailVerificationDeleteAccount(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _listener(context, state) {
    if (state is EmailVerifiedError) {
      Get.back();
      snackBarMessage(context, state.error, Theme.of(context));
    }

    if (state is AccountDelete) {
      Get.back();
      snackBarMessage(
        context,
        EnumLocale.deleteSuccessful.name.tr,
        Theme.of(context),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.signup,
        (Route<dynamic> route) => false,
      );
    }
  }
}
