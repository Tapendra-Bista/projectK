import 'package:afriqueen/features/reels/bloc/reel_bloc.dart';
import 'package:afriqueen/features/reels/screen/error_in_reel.dart';
import 'package:afriqueen/features/reels/screen/no_reel_data.dart';
import 'package:afriqueen/features/reels/screen/reel_view_screen.dart';
import 'package:afriqueen/features/reels/widget/top_action_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});
//-------------------Reels Screen------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<ReelBloc, ReelState>(
        builder: (context, state) {
          return switch (state) {
            ReelError() => ErrorInReel(),
            ReelEmpty() => NoReelAvailable(),
            _ => Stack(
                children: [
                  //-----------Reel View-------------------
                  ReelsView(),
                  //----------------Top Action----------
                  TopActionWdgets(),
                ],
              )
          };
        },
      ),
    ));
  }
}
