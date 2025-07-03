// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

//---------------------Follow model-----------------------
class FollowModel extends Equatable {
  final String id;
  final List<String> followId;

  FollowModel({required this.id, required this.followId});

  @override
  List<Object> get props => [id, followId];

  FollowModel copyWith({String? id, List<String>? followId}) {
    return FollowModel(id: id ?? this.id, followId: followId ?? this.followId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'followId': followId};
  }

  factory FollowModel.fromMap(Map<String, dynamic> map) {
    return FollowModel(
      id: map['id'] as String,
      followId: List<String>.from(map['followId'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory FollowModel.fromJson(String source) =>
      FollowModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  static FollowModel empty = FollowModel(id: '', followId: []);
}
