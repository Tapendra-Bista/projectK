import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

//-----------------------block AppBar--------------
class BlockScreenAppBar extends StatelessWidget {
  const BlockScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(HugeIcons.strokeRoundedMultiplicationSign),
      ),
      title: Text(
        EnumLocale.block.name.tr,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
    );
  }
}
