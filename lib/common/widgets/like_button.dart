import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/like/bloc/like_bloc.dart';
import 'package:afriqueen/features/like/bloc/like_event.dart';
import 'package:afriqueen/features/like/bloc/like_state.dart';
import 'package:afriqueen/features/like/model/like_model.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LikeButton extends StatelessWidget {
  final String id;
  const LikeButton({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LikeBloc, LikeState, LikeModel>(
      selector: (state) => state.likeUserList,
      builder: (context, likeData) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                if (likeData.likeId.contains(id)) {
                  getIt<LikeBloc>().add(LikeUserRemoved(likeId: id));
                  debugPrint("unLike  ${id}");
                } else {
                  getIt<LikeBloc>().add(LikeUserAdded(likeId: id));
                  debugPrint("Like  ${id}");
                }
              },
              icon: Icon(
                likeData.likeId.contains(id)
                    ? Icons.thumb_up_rounded
                    : Icons.thumb_up_alt_outlined,
                color: likeData.likeId.contains(id)
                    ? AppColors.blue
                    : AppColors.black,
                size: 30,
              ),
            ),
            Text(
              EnumLocale.like.name.tr,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: likeData.likeId.contains(id)
                        ? AppColors.blue
                        : AppColors.black,
                  ),
            )
          ],
        );
      },
    );
  }
}
