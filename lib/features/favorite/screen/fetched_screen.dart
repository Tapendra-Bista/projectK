import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_bloc.dart';
import 'package:afriqueen/features/favorite/bloc/favorite_state.dart';
import 'package:afriqueen/features/favorite/widgets/favorite_widgets.dart';
import 'package:afriqueen/features/favorite/widgets/fetched_screen_widgets.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FetchedScreen extends StatelessWidget {
  const FetchedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteBloc, FavoriteState, List<ProfileModel>>(
      selector: (state) => state.favUserList,
      builder: (context, favData) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(55.h),
            child: FavoriteScreenAppBar(),
          ),
          body: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            itemCount: favData.length,
            itemBuilder: (context, index) {
              final item = favData[index];
              final hasValidUrl = item.imgURL.isNotEmpty &&
                  Uri.tryParse(item.imgURL)?.hasAbsolutePath == true;

              return hasValidUrl
                  ? Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.grey),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10.h,
                        children: [
                          UserImage(Homedata: item),
                          CreatedDate(Homedata: item),
                          ButtonsList(Homedata: item),
                          UserDetails(
                            profileModel: item,
                          ),
                          Interests(
                            profileModel: item,
                          ),
                          Description(
                            profileModel: item,
                          ),
                          SizedBox(
                            height: 3.h,
                          )
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
