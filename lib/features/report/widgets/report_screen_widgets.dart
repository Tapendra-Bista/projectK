import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportDescriptionTwo extends StatelessWidget {
  const ReportDescriptionTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.reportDescription2.name.tr,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

class ReportDescriptionOne extends StatelessWidget {
  const ReportDescriptionOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.reportDescription1.name.tr,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

class MiniDescriptionText extends StatelessWidget {
  const MiniDescriptionText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.notRevealIdentity.name.tr,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: AppColors.black,
          ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      EnumLocale.whyAreYouReporting.name.tr,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: AppColors.red,
          ),
    );
    
  }
}
