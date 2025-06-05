import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/features/block/bloc/block_bloc.dart';
import 'package:afriqueen/features/block/bloc/block_state.dart';
import 'package:afriqueen/features/block/widgets/favorite_widgets.dart';

import 'package:afriqueen/features/block/widgets/fetched_screen_widgets.dart';
import 'package:afriqueen/features/home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FetchedScreen extends StatelessWidget {
  const FetchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BlockBloc, BlockState, List<HomeModel>>(
      selector: (state) => state.blockUserList,
      builder: (context, blockData) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.h),
            child: BlockScreenAppBar(),
          ),
          body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            itemCount: blockData.length,
            itemBuilder: (context, index) {
              final item = blockData[index];
              final hasValidUrl = item.imgURL.isNotEmpty &&
                  Uri.tryParse(item.imgURL)?.hasAbsolutePath == true;

              return hasValidUrl
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColors.floralWhite.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.grey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //--------User Image---------------
                          UserImage(Homedata: item),
                          //-----------User name------------
                          UserName(homeModel: item),
                          //-----------------Button---------------
                          UnBlockedButton(homeModel: item),
                        ],
                      ),
                    )
                  : null;
            },
          ),
        );
      },
    );
  }
}
