// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:afriqueen/features/home/model/home_model.dart';
import 'package:equatable/equatable.dart';

//-----------------------------Block State-----------------------------
class BlockState extends Equatable {
  final List<HomeModel> blockUserList;
  const BlockState({required this.blockUserList});

  @override
  List<Object> get props => [blockUserList];
}

final class BlockInitial extends BlockState {
  BlockInitial() : super(blockUserList: []);
}

final class BlockUsersLoading extends BlockState {
  BlockUsersLoading() : super(blockUserList: []);
}

final class BlockUsersError extends BlockState {
  final String errorMessage;

  BlockUsersError.fromState(BlockState state, {required this.errorMessage})
      : super(blockUserList: state.blockUserList);

  @override
  List<Object> get props => [errorMessage];
}

final class BlockDataEmpty extends BlockState {
  BlockDataEmpty() : super(blockUserList: []);
}
