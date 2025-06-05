import 'package:afriqueen/common/localization/enums/enums.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:afriqueen/features/profile/repository/profile_repository.dart';
import 'package:afriqueen/features/stories/bloc/stories_event.dart';
import 'package:afriqueen/features/stories/bloc/stories_state.dart';
import 'package:afriqueen/features/stories/model/stories_model.dart';
import 'package:afriqueen/features/stories/repository/stories_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class StoriesBloc extends HydratedBloc<StoriesEvent, StoriesState> {
  final StoriesRepository _storiesRepository;
  final ProfileRepository _profileRepository = ProfileRepository();
  StoriesModel _model = StoriesModel.empty;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StoriesBloc({required StoriesRepository repo})
      : _storiesRepository = repo,
        super(StoriesInitial()) {
    //-----------for Stories image-----------------------
    on<StoriesImage>((StoriesImage event, Emitter<StoriesState> emit) async {
      final image = await _storiesRepository.addStoriesImageToCloudinary();
      if (image != null) {
        final id = await _auth.currentUser!.uid;
        Set<String> images = {};
        Set<DateTime> date = {DateTime.now()};
        images.add(image);
        _model = _model.copyWith(uid: id);
        _model = _model.copyWith(userName: event.name);
        _model = _model.copyWith(userImg: event.img);
        _model = _model.copyWith(createdDate: date.toList());
        _model = _model.copyWith(containUrl: images.toList());
        await _storiesRepository.uploadStoriesToFirebase(_model);

        emit(StoriesFetchSuccss.fromState(state));
      }
    });

    // ------------------------Fetching stories storiesDataa---------------------------------
    on<StoriesFetching>((
      StoriesFetching event,
      Emitter<StoriesState> emit,
    ) async {
      try {
        final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
        if (currentUserId.isEmpty) return null;
        final profileData = await _profileRepository.fetchProfileData();

        final List<StoriesFetchModel>? storiesData =
            await _storiesRepository.fetchAllStoriesData();

        final StoriesFetchModel? currentUserStoriesData =
            storiesData!.firstWhere(
          (item) => item.id.isNotEmpty && item.id == currentUserId,
          orElse: () =>
              StoriesFetchModel.empty, // or handle however appropriate
        );

        final List<StoriesFetchModel> fetchAllExceptCurrentUser = storiesData
            .where((item) => item.id.isNotEmpty && item.id != currentUserId)
            .toList();

        emit(StoriesState(
            storiesData: fetchAllExceptCurrentUser,
            profileData: profileData!,
            currentUserStoriesData: currentUserStoriesData!));
      } catch (e) {
        emit(
          StoriesError.fromState(
            state,
            errorMessage: EnumLocale.defaultError.name.tr,
          ),
        );
      }
    });
  }

  @override
  StoriesState? fromJson(Map<String, dynamic> json) {
    try {
      final storiesData = (json['storiesData'] as List)
          .map((e) => e == null ? null : StoriesFetchModel.fromJson(e))
          .whereType<StoriesFetchModel>()
          .toList();
      final profileData = json['profileData'] as ProfileModel;
      final currentUserStoriesData =
          json['currentUserStories'] as StoriesFetchModel;
      return StoriesState(
          storiesData: storiesData,
          profileData: profileData,
          currentUserStoriesData: currentUserStoriesData);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(StoriesState state) {
    try {
      return {
        'storiesData': state.storiesData.map((e) => e.toJson()).toList(),
        'profileData': state.profileData.toJson(),
        'currentUserStories': state.currentUserStoriesData.toJson(),
      };
    } catch (e) {
      return null;
    }
  }
}
