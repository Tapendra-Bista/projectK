// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class ReelLikeModel extends Equatable {
  final String id;
  final List<String> reelLikeId;

  ReelLikeModel({required this.id, required this.reelLikeId});

  @override
  List<Object> get props => [id, reelLikeId];

  ReelLikeModel copyWith({String? id, List<String>? reelLikeId}) {
    return ReelLikeModel(
      id: id ?? this.id,
      reelLikeId: reelLikeId ?? this.reelLikeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'reelLikeId': reelLikeId};
  }

  factory ReelLikeModel.fromMap(Map<String, dynamic> map) {
    return ReelLikeModel(
      id: map['id'] as String,
      reelLikeId: List<String>.from(map['reelLikeId'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReelLikeModel.fromJson(String source) =>
      ReelLikeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  static ReelLikeModel empty = ReelLikeModel(id: '', reelLikeId: []);
}
