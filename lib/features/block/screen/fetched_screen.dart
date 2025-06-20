import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/common/widgets/divider.dart';
import 'package:afriqueen/features/block/bloc/block_bloc.dart';
import 'package:afriqueen/features/block/bloc/block_state.dart';
import 'package:afriqueen/features/block/widgets/fetched_screen_widgets.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class FetchedScreen extends StatelessWidget {
  const FetchedScreen({super.key});
//------------------Fetch Screen--------------------------
  @override
  Widget build(BuildContext context) {
    return BlocSelector<BlockBloc, BlockState, List<ProfileModel>>(
      selector: (state) => state.blockUserList,
      builder: (context, blockData) {
        return PlatformScaffold(
            appBar: PlatformAppBar(
              material: (context, platform) {
                return MaterialAppBarData(centerTitle: true);
              },
              leading: PlatformIconButton(
                onPressed: () => Get.back(),
                icon: Icon(HugeIcons.strokeRoundedMultiplicationSign),
              ),
              title: Text(
                EnumLocale.block.name.tr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            body: CustomScrollView(
              slivers: [
                //-----------divider--------------
                SliverToBoxAdapter(child: const CustomDivider()),
                SliverList.builder(
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
            ));
      },
    );
  }
}
