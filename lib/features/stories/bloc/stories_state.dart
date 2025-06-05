import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:equatable/equatable.dart';

import 'package:afriqueen/features/stories/model/stories_model.dart';

class StoriesState extends Equatable {
  final List<StoriesFetchModel> storiesData;
  final StoriesFetchModel currentUserStoriesData;
  final ProfileModel profileData;
  const StoriesState(
      {required this.storiesData,
      required this.profileData,
      required this.currentUserStoriesData});

  StoriesState copyWith(
          {List<StoriesFetchModel>? storiesData,
          ProfileModel? profileData,
          StoriesFetchModel? currentUserStoriesData}) =>
      StoriesState(
          storiesData: storiesData ?? this.storiesData,
          profileData: profileData ?? this.profileData,
          currentUserStoriesData:
              currentUserStoriesData ?? this.currentUserStoriesData);

  factory StoriesState.initial() {
    return StoriesState(
        storiesData: [],
        profileData: ProfileModel.empty,
        currentUserStoriesData: StoriesFetchModel.empty);
  }
  @override
  List<Object> get props => [storiesData, profileData, currentUserStoriesData];
}

final class StoriesInitial extends StoriesState {
  StoriesInitial()
      : super(
            storiesData: [],
            profileData: ProfileModel.empty,
            currentUserStoriesData: StoriesFetchModel.empty);
}

final class StoriesError extends StoriesState {
  final String errorMessage;
  StoriesError.fromState(StoriesState state, {required this.errorMessage})
      : super(
            storiesData: state.storiesData,
            profileData: state.profileData,
            currentUserStoriesData: StoriesFetchModel.empty);
}

final class StoriesFetchSuccss extends StoriesState {
  StoriesFetchSuccss.fromState(
    StoriesState state,
  ) : super(
            storiesData: state.storiesData,
            profileData: state.profileData,
            currentUserStoriesData: StoriesFetchModel.empty);
}
