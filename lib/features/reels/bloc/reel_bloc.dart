import 'dart:async';

import 'package:afriqueen/features/reels/model/reel_model.dart';
import 'package:afriqueen/features/reels/repository/reel_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'reel_bloc.freezed.dart';
part 'reel_bloc.g.dart';
part 'reel_event.dart';
part 'reel_state.dart';

//-------- Bloc ---------
class ReelBloc extends HydratedBloc<ReelEvent, ReelState> {
  final ReelRepository _reelRepository;
  ReelBloc({required ReelRepository repository})
      : _reelRepository = repository,
        super(ReelState.initial()) {
    on<ReelLoaded>(_onReelLoaded);
  }

  ///------ fetch data -----------
  Future<void> _onReelLoaded(ReelLoaded event, Emitter<ReelState> emit) async {
    try {
      final List<ReelModel> reelModel = await _reelRepository.getReels();
      if (reelModel.isEmpty) emit(ReelState.reelEmpty());

      emit(ReelState.initial(reelModel: reelModel));
    } catch (e) {
      emit(ReelState.reelError(errorMessage: e.toString()));
    }
  }

  @override
  ReelState? fromJson(Map<String, dynamic> json) {
    try {
      return ReelState.fromJson(json);
    } catch (e, stackTrace) {
      print('Error deserializing ReelState: $e');
      print('StackTrace: $stackTrace');
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ReelState state) {
    try {
      return state.toJson();
    } catch (e, stackTrace) {
      print('Error serializing ReelState: $e');
      print('StackTrace: $stackTrace');
      return null;
    }
  }
}
