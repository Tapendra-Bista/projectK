import 'package:afriqueen/common/widgets/circular_indicator.dart';
import 'package:afriqueen/features/block/bloc/block_bloc.dart';
import 'package:afriqueen/features/block/bloc/block_state.dart';
import 'package:afriqueen/features/block/screen/empty_data_screen.dart';
import 'package:afriqueen/features/block/screen/error_screen.dart';
import 'package:afriqueen/features/block/screen/block_fetched_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockScreen extends StatelessWidget {
  const BlockScreen({super.key});
  //-----------------------------Fav Screeen----------------------------------------
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlockBloc, BlockState>(
      builder: (context, state) {
        print("state name :${state}");
        return switch (state) {
          //-----------initial loading---------------------------
          BlockUsersLoading() => const CustomCircularIndicator(),
          //------------------Error Screening -----------------------------
          BlockUsersError() => const ErrorScreen(),
          //------------empty---------------
          BlockDataEmpty() => const NoData(),
          //-------------Data Fetch screen -------------------
          _ => const FetchedScreen(),
        };
      },
    );
  }
}
