import 'dart:async';

import 'package:afriqueen/features/block/bloc/block_event.dart';
import 'package:afriqueen/features/block/bloc/block_state.dart';
import 'package:afriqueen/features/block/model/block_model.dart';
import 'package:afriqueen/features/block/repository/block_repository.dart';
import 'package:afriqueen/features/home/model/home_model.dart';
import 'package:afriqueen/features/home/repository/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//------------------------Block Bloc--------------------------
class BlockBloc extends Bloc<BlockEvent, BlockState> {
  final BlockRepository _blockRepository;
  final HomeRepository _homeRepository = HomeRepository();
  BlockBloc({required BlockRepository repository})
    : _blockRepository = repository,
      super(BlockInitial()) {
    on<BlockUserAdded>(_onblockUserAdded);

    on<BlockUserRemoved>(_onblockUserRemoved);

    on<BlockUsersFetched>(_onblockUsersFetched);
  }
  //-------------------------Fetching data----------------------------
  FutureOr<void> _onblockUsersFetched(
    BlockUsersFetched event,
    Emitter<BlockState> emit,
  ) async {
    emit(BlockUsersLoading());
    try {
      final BlockModel? data = await _blockRepository.fetchblocks();
      final List<HomeModel> homeModelData = await _homeRepository
          .fetchAllExceptCurrentUser();

      if (data != null) {
        final List<HomeModel> blockUserData = homeModelData
            .where((e) => e.id.isNotEmpty && data.blockId.contains(e.id))
            .toList();
        emit(BlockState(blockUserList: blockUserData));
      } else {
        emit(BlockDataEmpty());
      }
    } catch (e) {
      emit(BlockUsersError.fromState(state, errorMessage: e.toString()));
    }
  }

  //-----------------------------Removing user from fav list-------------------------------------------
  FutureOr<void> _onblockUserRemoved(
    BlockUserRemoved event,
    Emitter<BlockState> emit,
  ) async {
    await _blockRepository.removeblock(event.blockId);

    add(BlockUsersFetched());
  }

  //-------------------------------------Adding to fav list----------------------------------
  FutureOr<void> _onblockUserAdded(
    BlockUserAdded event,
    Emitter<BlockState> emit,
  ) async {
    await _blockRepository.addblock(event.blockId);
  }
}
