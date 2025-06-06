import 'package:afriqueen/common/widgets/circular_indicator.dart';
import 'package:afriqueen/features/profile/bloc/profile_bloc.dart';
import 'package:afriqueen/features/profile/bloc/profile_state.dart';
import 'package:afriqueen/features/profile/screen/error_screen.dart';
import 'package:afriqueen/features/profile/screen/fetch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          //----------Loading--------------------
          Loading() => const CustomCircularIndicator(),
          //----------------- Get Error--------------------
          Error() => const ProfileErrorContent(),
          //---------------After Data Fetched--------------------
          _ => const ProfileDataContent(),
        };
      },
    );
  }
}
