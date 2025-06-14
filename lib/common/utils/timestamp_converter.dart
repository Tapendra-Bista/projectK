import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<Timestamp?, dynamic> {
  const TimestampConverter();

  @override
  Timestamp? fromJson(dynamic json) {
    if (json is Timestamp) return json;
    if (json is Map<String, dynamic> && json.containsKey('_seconds')) {
      return Timestamp(json['_seconds'], json['_nanoseconds']);
    }
    return null;
  }

  @override
  dynamic toJson(Timestamp? timestamp) => timestamp;
}
