import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<ProfileModel?> data;
  final List<ProfileModel?> profileList;
  const HomeState({required this.data, required this.profileList});

  HomeState copyWith(
          {List<ProfileModel?>? data, List<ProfileModel?>? profileList}) =>
      HomeState(
          data: data ?? this.data,
          profileList: profileList ?? this.profileList);

  factory HomeState.initial() {
    return HomeState(data: [], profileList: []);
  }
  @override
  List<Object> get props => [data, profileList];
}

final class HomeInitial extends HomeState {
  HomeInitial() : super(data: [], profileList: []);
}

final class Loading extends HomeState {
  Loading.fromState(HomeState state)
      : super(data: state.data, profileList: state.profileList);
}

final class Error extends HomeState {
  final String error;
  Error.fromState(HomeState state, {required this.error})
      : super(data: state.data, profileList: state.profileList);
  @override
  List<Object> get props => [error];
}

final class HomeDataIsEmpty extends HomeState {
  HomeDataIsEmpty.fromState(HomeState state)
      : super(data: state.data, profileList: state.profileList);
}
