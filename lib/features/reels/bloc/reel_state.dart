part of 'reel_bloc.dart';

//-------------------State------------------
@freezed
abstract class ReelState with _$ReelState {
  const factory ReelState.initial({@Default([]) List<ReelModel> reelModel}) =
      Initial;

  const factory ReelState.reelError({required String errorMessage}) = ReelError;

  const factory ReelState.reelEmpty() = ReelEmpty;

  factory ReelState.fromJson(Map<String, dynamic> json) =>
      _$ReelStateFromJson(json);
}
