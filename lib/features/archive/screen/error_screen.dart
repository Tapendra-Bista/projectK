import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/archive/bloc/archive_bloc.dart';
import 'package:afriqueen/features/archive/bloc/archive_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

//------------------Error widget---------------------

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ArchiveBloc, ArchiveState, String?>(
      selector: (state) {
        if (state is ArchiveUsersError) {
          return state.errorMessage;
        }

        return null;
      },
      builder: (context, error) {
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
              EnumLocale.archive.name.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          body: Center(
            child: Text(error!, style: Theme.of(context).textTheme.bodyMedium),
          ),
        );
      },
    );
  }
}
