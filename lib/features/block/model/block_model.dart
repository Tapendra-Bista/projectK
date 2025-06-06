// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';
//---------------------Block model-----------------------
class BlockModel extends Equatable {
  final String id;
  final List<String> blockId;

  BlockModel({required this.id, required this.blockId});

  @override
  List<Object> get props => [id, blockId];

  BlockModel copyWith({String? id, List<String>? blockId}) {
    return BlockModel(id: id ?? this.id, blockId: blockId ?? this.blockId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'blockId': blockId};
  }

  factory BlockModel.fromMap(Map<String, dynamic> map) {
    return BlockModel(
      id: map['id'] as String,
      blockId: List<String>.from(map['blockId'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory BlockModel.fromJson(String source) =>
      BlockModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  static BlockModel empty = BlockModel(id: '', blockId: []);
}
