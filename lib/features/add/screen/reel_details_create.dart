import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/utils/validators.dart';
import 'package:afriqueen/common/widgets/divider.dart';
import 'package:afriqueen/common/widgets/loading.dart';
import 'package:afriqueen/common/widgets/snackbar_message.dart';
import 'package:afriqueen/features/add/bloc/add_bloc.dart';
import 'package:afriqueen/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:video_trimmer/video_trimmer.dart';

class ReelDetailsCreate extends StatefulWidget {
  const ReelDetailsCreate(
      {super.key, required this.url, required this.trimmer});
  final String url;
  final Trimmer trimmer;

  @override
  State<ReelDetailsCreate> createState() => _ReelDetailsCreateState();
}

//-------------------Reel post screen-------------------------
class _ReelDetailsCreateState extends State<ReelDetailsCreate> {
  final reelsDescriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    reelsDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        height: 40.h, // Slightly increased height for better touch target
        width: 100.w,
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          tooltip: EnumLocale.postReels.name.tr,
          heroTag: 'heroPost',
          shape: RoundedRectangleBorder(
              side:
                  BorderSide(color: AppColors.greyContainerColor, width: 0.5.w),
              borderRadius: BorderRadiusGeometry.circular(8.r)),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AddBloc>().add(PostReel(
                  trimVideoUrl: widget.url,
                  description: reelsDescriptionController.text.trim()));
            }
          },
          child: Center(
              child: Text(
            EnumLocale.postReels.name.tr,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.white),
          )),
        ),
      ),
      appBar: AppBar(
        leading: PlatformIconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            HugeIcons.strokeRoundedMultiplicationSign,
            color: AppColors.black,
          ),
        ),
        title: Text(
          EnumLocale.newReel.name.tr,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(
                fontSize: 20.sp,
              ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: BlocListener<AddBloc, AddState>(
          listener: _listener,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 10.h,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: 400.h,
                        child: Expanded(
                          child: VideoViewer(trimmer: widget.trimmer),
                        ),
                      ),
                      CustomDivider(),
                      TextFormField(
                        validator: AppValidator.validateDescription,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.black),
                        // Fills available vertical space
                        maxLines: 5, // Must be null when expands is true
                        minLines: 1,
                        keyboardType: TextInputType.text,
                        controller: reelsDescriptionController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: EnumLocale.reelHintText.name.tr),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                ),
              ))),
    );
  }

  void _listener(context, state) {
    if (state is AddReelLoading) {
      return customLoading(context);
    }

    if (state is PostingError) {
      Get.back();
      return snackBarMessage(context, state.errorMessage, Theme.of(context));
    }

    if (state is AddReelSuccess) {
      Get.back();
      snackBarMessage(
          context, EnumLocale.reelPosted.name.tr, Theme.of(context));
      Get.offAllNamed(AppRoutes.main);
    }
  }
}
