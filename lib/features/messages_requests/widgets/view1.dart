import 'package:afriqueen/features/messages_requests/bloc/request_receiver_bloc.dart';

import 'package:afriqueen/features/messages_requests/screen/error_screen.dart';
import 'package:afriqueen/features/messages_requests/screen/no_requests.dart';
import 'package:afriqueen/features/messages_requests/screen/requests_users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//-------Received---------------
class View1 extends StatelessWidget {
  const View1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BlocBuilder<RequestReceiverBloc, RequestReceiverState>(
        builder: (context, state) {
          return switch (state) {
            ErrorInRequests(:final errorMessage) =>
              ErrorInRequestFetch(errorMessage: errorMessage),
            NoRequestsYet() => NoRequests(),
            _ => RequestsReceiverScreen(),
          };
        },
      ),
    );
  }
}
