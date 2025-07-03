import 'package:afriqueen/common/constant/constant_colors.dart';
import 'package:afriqueen/features/messages_requests/bloc/request_receiver_bloc.dart';
import 'package:afriqueen/features/messages_requests/bloc/request_sender_bloc.dart';
import 'package:afriqueen/features/messages_requests/widgets/messages_requests_screen_widgets.dart';
import 'package:afriqueen/features/messages_requests/widgets/tabs_list_widgets.dart';
import 'package:afriqueen/features/messages_requests/widgets/view1.dart';
import 'package:afriqueen/features/messages_requests/widgets/view2.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestSenderScreen extends StatefulWidget {
  const RequestSenderScreen({super.key});

  @override
  State<RequestSenderScreen> createState() => _RequestSenderScreenState();
}

class _RequestSenderScreenState extends State<RequestSenderScreen> {
//----------------------- Message Requests Screen-------------------

  @override
  void initState() {
    context.read<RequestSenderBloc>().add(TotalRequestSenderSend());
    context.read<RequestReceiverBloc>().add(RequestReceiverGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.h), child: RequestSenderAppBar()),
        body: ContainedTabBarView(
          tabBarViewProperties: TabBarViewProperties(
              physics: NeverScrollableScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down),
          tabBarProperties: TabBarProperties(
              indicatorColor: AppColors.primaryColor,
              indicatorSize: TabBarIndicatorSize.label),
          tabs: [
            Tab1(),
            Tab2(),
          ],
          views: [View1(), View2()],
        ));
  }
}
