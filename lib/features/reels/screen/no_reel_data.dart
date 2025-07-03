import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoReelAvailable extends StatelessWidget {
  const NoReelAvailable({
    super.key,
  });
//--------- no reel available------------
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        EnumLocale.noDataAvailable.name.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
