import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
//------------------Empty Data widget---------------------

class NoData extends StatelessWidget {
  const NoData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        leading: PlatformIconButton(
          onPressed: () => Get.back(),
          icon: Icon(HugeIcons.strokeRoundedMultiplicationSign),
        ),
        title: Text(
          EnumLocale.favorites.name.tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: Center(
        child: Text(
          EnumLocale.noDataAvailable.name.tr,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
