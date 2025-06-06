import 'dart:async';

import 'package:afriqueen/features/like/bloc/like_event.dart';
import 'package:afriqueen/features/like/bloc/like_state.dart';
import 'package:afriqueen/features/like/model/like_model.dart';
import 'package:afriqueen/features/like/repository/like_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeRepository _likeRepository;

  LikeBloc({required LikeRepository repository})
      : _likeRepository = repository,
        super(LikeInitial()) {
    on<LikeUserAdded>(_onLikeUserAdded);

    on<LikeUserRemoved>(_onLikeUserRemoved);

    on<LikeUsersFetched>(_onLikeUsersFetched);
  }
  //-------------------------Fetching data----------------------------
  FutureOr<void> _onLikeUsersFetched(
    LikeUsersFetched event,
    Emitter<LikeState> emit,
  ) async {
    emit(LikeUsersLoading());
    try {
      final LikeModel? likeUserData = await _likeRepository.fetchLikes();

      if (likeUserData != null) {
        emit(LikeState(likeUserList: likeUserData));
      } else {
        emit(LikeDataEmpty());
      }
    } catch (e) {
      emit(LikeUsersError.fromState(state, errorMessage: e.toString()));
    }
  }

  //-----------------------------Removing user from like list-------------------------------------------
  FutureOr<void> _onLikeUserRemoved(
    LikeUserRemoved event,
    Emitter<LikeState> emit,
  ) async {
    await _likeRepository.removeLike(event.likeId);

    add(LikeUsersFetched());
  }

  //-------------------------------------Adding to like list----------------------------------
  FutureOr<void> _onLikeUserAdded(
    LikeUserAdded event,
    Emitter<LikeState> emit,
  ) async {
    await _likeRepository.addLike(event.likeId);
  }
}
