import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/snackbar_message.dart';
import 'package:afriqueen/features/block/bloc/block_bloc.dart';
import 'package:afriqueen/features/block/bloc/block_event.dart';
import 'package:afriqueen/features/home/model/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

//-------------------- user Image--------------------
class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.Homedata});
  final HomeModel? Homedata;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.6),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(Homedata!.imgURL),
        ),
      ),
    );
  }
}

// ---------block User Name--------------------------
class UserName extends StatelessWidget {
  const UserName({super.key, required this.homeModel});

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return Text(
      homeModel.pseudo,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium,
    );
  }
}

// ---------block User Name--------------------------
class UnBlockedButton extends StatelessWidget {
  const UnBlockedButton({super.key, required this.homeModel});
  final HomeModel homeModel;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context
              .read<BlockBloc>()
              .add(BlockUserRemoved(blockId: homeModel.id));
          snackBarMessage(
            context,
            EnumLocale.removedFromBlock.name.tr,
            Theme.of(context),
          );
        },
        child: Text(
          EnumLocale.unblock.name.tr,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(color: AppColors.primaryColor),
        ));
  }
}
