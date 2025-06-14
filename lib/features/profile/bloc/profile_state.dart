import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_state.g.dart';

@JsonSerializable()
class ProfileState extends Equatable {
  final ProfileModel data;
  const ProfileState({required this.data});

  ProfileState copyWith({ProfileModel? data}) =>
      ProfileState(data: data ?? this.data);

  factory ProfileState.initial() {
    return ProfileState(data: ProfileModel.empty);
  }
  @override
  List<Object> get props => [data];
  factory ProfileState.fromJson(Map<String, dynamic> json) =>
      _$ProfileStateFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileStateToJson(this);
}

final class ProfileInitial extends ProfileState {
  ProfileInitial() : super(data: ProfileModel.empty);
}

final class Loading extends ProfileState {
  Loading.fromState(ProfileState state) : super(data: state.data);
}

final class Error extends ProfileState {
  final String error;
  Error.fromState(ProfileState state, {required this.error})
      : super(data: state.data);
  @override
  List<Object> get props => [error];
}
