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

        final List<ProfileModel?> data =
            await __repository.fetchAllExceptCurrentUser();
        if (data.isEmpty) {
          emit(HomeDataIsEmpty.fromState(state));
        }
        final FavoriteModel? favData =
            await _favoriteRepository.fetchFavorites();

        final BlockModel? blockData = await _blockRepository.fetchBlocks();
        final ArchiveModel? archiveData =
            await _archiveRepository.fetchArchives();

        if (favData == null && blockData == null && archiveData == null) {
          emit(state.copyWith(profileList: data));
        } else {
          final filterData = data
              .where((item) =>
                  item != null &&
                  item.id.isNotEmpty &&
                  !(favData?.favId.contains(item.id) ?? false) &&
                  !(blockData?.blockId.contains(item.id) ?? false) &&
                  !(archiveData?.archiveId.contains(item.id) ?? false))
              .toList();
          print(filterData.length);
          emit(state.copyWith(profileList: filterData));
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
