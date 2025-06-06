// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class LikeModel extends Equatable {
  final String id;
  final List<String> likeId;

  LikeModel({required this.id, required this.likeId});

  @override
  List<Object> get props => [id, likeId];

  LikeModel copyWith({String? id, List<String>? likeId}) {
    return LikeModel(id: id ?? this.id, likeId: likeId ?? this.likeId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'likeId': likeId};
  }

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      id: map['id'] as String,
      likeId: List<String>.from(map['likeId'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory LikeModel.fromJson(String source) =>
      LikeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  static LikeModel empty = LikeModel(id: '', likeId: []);
}
