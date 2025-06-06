// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:afriqueen/features/home/model/home_model.dart';
import 'package:equatable/equatable.dart';

//-----------------------------archive State-----------------------------
class ArchiveState extends Equatable {
  final List<HomeModel> favUserList;
  const ArchiveState({required this.favUserList});

  @override
  List<Object> get props => [favUserList];
}

final class ArchiveInitial extends ArchiveState {
  ArchiveInitial() : super(favUserList: []);
}

final class ArchiveUsersLoading extends ArchiveState {
  ArchiveUsersLoading() : super(favUserList: []);
}

final class ArchiveUsersError extends ArchiveState {
  final String errorMessage;

  ArchiveUsersError.fromState(ArchiveState state, {required this.errorMessage})
    : super(favUserList: state.favUserList);

  @override
  List<Object> get props => [errorMessage];
}

final class ArchiveDataEmpty extends ArchiveState {
  ArchiveDataEmpty() : super(favUserList: []);
}
