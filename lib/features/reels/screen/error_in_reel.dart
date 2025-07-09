import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/reels/bloc/reel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ErrorInReel extends StatelessWidget {
  const ErrorInReel({
    super.key,
  });
//-----------Error While fetching------------
  @override
  Widget build(BuildContext context) {    final theme = Theme.of(context).textTheme;
    return BlocSelector<ReelBloc, ReelState, String?>(
      selector: (state) {
        if (state is ReelError) return state.errorMessage;

        return null;
      },
      builder: (context, error) {
        return Center(
          child: Text(
            error ?? EnumLocale.defaultError.name.tr,
            style: theme.bodyMedium,
          ),
        );
      },
    );
  }
}
