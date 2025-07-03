import 'package:afriqueen/common/utils/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_model.freezed.dart';
part 'request_model.g.dart';

//------------ model-------------------

@freezed
abstract class Requestmodel with _$Requestmodel {
  const factory Requestmodel({
    required String senderProfile,
    required String senderName,
    required String senderId,
    required ResponseStatus responseStatus,
    required RequestStatus requestStatus,
    required String receiverId,
    required String receiverProfile,
    required String receiverName,
    @TimestampConverter() required Timestamp createdAt,
  }) = _Requestmodel;

  factory Requestmodel.fromJson(Map<String, dynamic> json) =>
      _$RequestmodelFromJson(json);
}

extension RequestmodelToMap on Requestmodel {
  Map<String, dynamic> toMap() => toJson();
}

enum ResponseStatus { initial, accept, reject }

enum RequestStatus { send, read }
