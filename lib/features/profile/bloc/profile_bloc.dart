import 'package:afriqueen/features/profile/bloc/profile_event.dart';
import 'package:afriqueen/features/profile/bloc/profile_state.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/features/profile/repository/profile_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ProfileBloc extends HydratedBloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;
  ProfileBloc({required ProfileRepository repo})
      : _repository = repo,
        super(ProfileInitial()) {
    on<ProfileFetch>((event, emit) async {
      try {
        emit(Loading.fromState(state));
        final ProfileModel? data = await _repository.fetchProfileData();
        if (data != null) return emit(ProfileState(data: data));
      } catch (e) {
        emit(Error.fromState(state, error: e.toString()));
      }
    });
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    try {
      final data = ProfileModel.fromJson(json['data']);
      return ProfileState(data: data);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    try {
      return {
        'data': state.data.toJson(),
      };
    } catch (e) {
      return null;
    }
  }
}
