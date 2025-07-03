import 'dart:async';
import 'package:afriqueen/features/follow/bloc/follow_event.dart';
import 'package:afriqueen/features/follow/bloc/follow_state.dart';
import 'package:afriqueen/features/follow/model/follow_model.dart';
import 'package:afriqueen/features/follow/repository/follow_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//------------------------Follow Bloc--------------------------
class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final FollowRepository _followRepository;

  FollowBloc({required FollowRepository repository})
      : _followRepository = repository,
        super(FollowInitial()) {
    on<FollowUserAdded>(_onfollowUserAdded);

    on<FollowUserRemoved>(_onfollowUserRemoved);

    on<FollowUsersFetched>(_onfollowUsersFetched);
  }

  //-------------------------Fetching data----------------------------
  FutureOr<void> _onfollowUsersFetched(
    FollowUsersFetched event,
    Emitter<FollowState> emit,
  ) async {
    emit(FollowUsersLoading());
    try {
      final FollowModel? data = await _followRepository.fetchFollows();

      if (data != null) {
        emit(
          FollowState(followUserList: data),
        );
      } else {
        emit(FollowDataEmpty());
      }
    } catch (e) {
      emit(FollowUsersError.fromState(state, errorMessage: e.toString()));
    }
  }

  //-----------------------------Removing user from fav list-------------------------------------------
  FutureOr<void> _onfollowUserRemoved(
    FollowUserRemoved event,
    Emitter<FollowState> emit,
  ) async {
    await _followRepository.removeFollow(event.followId);

    add(FollowUsersFetched());
  }

  //-------------------------------------Adding to fav list----------------------------------
  FutureOr<void> _onfollowUserAdded(
    FollowUserAdded event,
    Emitter<FollowState> emit,
  ) async {
    await _followRepository.addFollow(event.followId);
    add(FollowUsersFetched());
  }
}
