import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/services/service_locator/service_locator.dart';
import 'package:afriqueen/services/status/bloc/status_bloc.dart';
import 'package:afriqueen/services/status/bloc/status_event.dart';
import 'package:afriqueen/services/status/bloc/status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserStatus extends StatefulWidget {
  const UserStatus({
    super.key,
    this.height = 20,
    this.width = 20,
    required this.id,
  });
  final double height;
  final double width;
  final String id;
  @override
  State<UserStatus> createState() => _UserStatusState();
}

//---------------To check user is online or offline
class _UserStatusState extends State<UserStatus> {
  @override
  void initState() {
    getIt<StatusBloc>().add(GetStatus(uid: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StatusBloc, StatusState, bool>(
      selector: (state) => state.status.state,
      builder: (context, value) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: value ? AppColors.green : AppColors.grey,
              width: 2.w,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 1.r,
                spreadRadius: 1.r,
                blurStyle: BlurStyle.outer,
                color: value ? AppColors.green : AppColors.grey,
              ),
            ],
            color: value ? AppColors.green : AppColors.grey,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
