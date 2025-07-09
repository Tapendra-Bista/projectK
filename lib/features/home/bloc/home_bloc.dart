import 'package:afriqueen/features/archive/model/archive_model.dart';
import 'package:afriqueen/features/archive/repository/archive_repository.dart';
import 'package:afriqueen/features/block/model/block_model.dart';
import 'package:afriqueen/features/block/repository/block_repository.dart';
import 'package:afriqueen/features/favorite/model/favorite_model.dart';
import 'package:afriqueen/features/favorite/repository/favorite_repository.dart';
import 'package:afriqueen/features/home/bloc/home_event.dart';
import 'package:afriqueen/features/home/bloc/home_state.dart';
import 'package:afriqueen/features/home/repository/home_repository.dart';
import 'package:afriqueen/features/profile/model/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
  final HomeRepository __repository;
  final FavoriteRepository _favoriteRepository = FavoriteRepository();
  final BlockRepository _blockRepository = BlockRepository();
  final ArchiveRepository _archiveRepository = ArchiveRepository();
  HomeBloc({required HomeRepository repo})
      : __repository = repo,
        super(HomeInitial()) {
    on<HomeUsersFetched>((event, emit) async {
      try {
        emit(Loading.fromState(state));
        final List<ProfileModel?> data =
            await __repository.fetchAllExceptCurrentUser();
        emit(state.copyWith(data: data));
      } catch (e) {
        emit(Error.fromState(state, error: e.toString()));
      }
    });
    on<HomeUsersProfileList>((event, emit) async {
      try {
        emit(Loading.fromState(state));

        // Fetch all users except current
        final List<ProfileModel?> data =
            await __repository.fetchAllExceptCurrentUser();

        // Fetch favorites, blocks, archives for current user
        final FavoriteModel? favData =
            await _favoriteRepository.fetchFavorites();
        final BlockModel? blockData = await _blockRepository.fetchBlocks();
        final ArchiveModel? archiveData =
            await _archiveRepository.fetchArchives();

        // Filter out null or empty id users first
        final List<ProfileModel> validUsers = data
            .where((u) => u != null && u.id.isNotEmpty)
            .cast<ProfileModel>()
            .toList();

        // Fetch other users' block lists in chunks (to check who blocked me)
        final Map<String, List<String>> blockedByOthers = await _blockRepository
            .fetchOtherUsersBlockListsInChunks(validUsers);

        // Now filter user list
        final filteredData = validUsers.where((user) {
          final blockedByMe = blockData?.blockId.contains(user.id) ?? false;
          final archivedByMe =
              archiveData?.archiveId.contains(user.id) ?? false;
          final favoredByMe = favData?.favId.contains(user.id) ?? false;

          // Check if user has blocked me from the batched data
          final blockedMe = blockedByOthers[user.id]
                  ?.contains(FirebaseAuth.instance.currentUser!.uid) ??
              false;

          // Exclude user if any of the conditions apply
          return !(blockedByMe || archivedByMe || favoredByMe || blockedMe);
        }).toList();

        // Emit filtered data, or original if no filters applied
        if (favData == null && blockData == null && archiveData == null) {
          emit(state.copyWith(profileList: data));
        } else {
          print('Filtered user count: ${filteredData.length}');
          emit(state.copyWith(profileList: filteredData));
        }
      } catch (e) {
        print("Error in home screen :${e.toString()}");
        emit(Error.fromState(state, error: e.toString()));
      }
    });
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    try {
      final dataList = (json['data'] as List)
          .map((e) => e == null ? null : ProfileModel.fromJson(e))
          .toList();

      final profileList = (json['profileList'] as List)
          .map((e) => e == null ? null : ProfileModel.fromJson(e))
          .toList();

      return HomeState(
        data: dataList,
        profileList: profileList,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(state) {
    try {
      return {
        'data': state.data.map((e) => e?.toJson()).toList(),
        'profileList': state.profileList.map((e) => e?.toJson()).toList(),
      };
    } catch (e) {
      return null;
    }
  }
}
