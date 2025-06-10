import 'package:afriqueen/common/widgets/divider.dart';
import 'package:afriqueen/features/block/bloc/block_bloc.dart';
import 'package:afriqueen/features/block/bloc/block_state.dart';
import 'package:afriqueen/features/block/widgets/block_widgets.dart';
import 'package:afriqueen/features/block/widgets/fetched_screen_widgets.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FetchedScreen extends StatelessWidget {
  const FetchedScreen({super.key});
//------------------Fetch Screen--------------------------
  @override
  Widget build(BuildContext context) {
    return BlocSelector<BlockBloc, BlockState, List<ProfileModel>>(
      selector: (state) => state.blockUserList,
      builder: (context, blockData) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.h),
            child: BlockScreenAppBar(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //-----------divider--------------
                const CustomDivider(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  itemCount: blockData.length,
                  itemBuilder: (context, index) {
                    final item = blockData[index];
                    final hasValidUrl = item.imgURL.isNotEmpty &&
                        Uri.tryParse(item.imgURL)?.hasAbsolutePath == true;

                    return hasValidUrl
                        ? Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 2.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      spacing: 8.w,
                                      children: [
                                        //--------User Image---------------
                                        UserImage(Homedata: item),
                                        //-----------User name------------
                                        UserName(profileModel: item),
                                      ],
                                    ),
                                    //-----------------Button---------------
                                    UnBlockedButton(profileModel: item),
                                  ],
                                ),
                              ),
                              //-----------divider--------------
                              const CustomDivider()
                            ],
                          )
                        : null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
