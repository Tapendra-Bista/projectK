import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';



class TimestampConverter implements JsonConverter<Timestamp, Object?> {
  const TimestampConverter();

  @override
  Timestamp fromJson(Object? json) {
    if (json is Timestamp) return json;
    if (json is Map<String, dynamic>) {
      return Timestamp.fromMillisecondsSinceEpoch(
        (json['_seconds'] ?? json['seconds'] ?? 0) * 1000 +
        ((json['_nanoseconds'] ?? json['nanoseconds'] ?? 0) / 1000000).round(),
      );
    }
    throw ArgumentError('Invalid timestamp json: $json');
  }

  @override
  Object toJson(Timestamp timestamp) => timestamp;
}
