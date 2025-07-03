// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Requestmodel {
  String get senderProfile;
  String get senderName;
  String get senderId;
  ResponseStatus get responseStatus;
  RequestStatus get requestStatus;
  String get receiverId;
  String get receiverProfile;
  String get receiverName;
  @TimestampConverter()
  Timestamp get createdAt;

  /// Create a copy of Requestmodel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RequestmodelCopyWith<Requestmodel> get copyWith =>
      _$RequestmodelCopyWithImpl<Requestmodel>(
          this as Requestmodel, _$identity);

  /// Serializes this Requestmodel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Requestmodel &&
            (identical(other.senderProfile, senderProfile) ||
                other.senderProfile == senderProfile) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.responseStatus, responseStatus) ||
                other.responseStatus == responseStatus) &&
            (identical(other.requestStatus, requestStatus) ||
                other.requestStatus == requestStatus) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.receiverProfile, receiverProfile) ||
                other.receiverProfile == receiverProfile) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      senderProfile,
      senderName,
      senderId,
      responseStatus,
      requestStatus,
      receiverId,
      receiverProfile,
      receiverName,
      createdAt);

  @override
  String toString() {
    return 'Requestmodel(senderProfile: $senderProfile, senderName: $senderName, senderId: $senderId, responseStatus: $responseStatus, requestStatus: $requestStatus, receiverId: $receiverId, receiverProfile: $receiverProfile, receiverName: $receiverName, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $RequestmodelCopyWith<$Res> {
  factory $RequestmodelCopyWith(
          Requestmodel value, $Res Function(Requestmodel) _then) =
      _$RequestmodelCopyWithImpl;
  @useResult
  $Res call(
      {String senderProfile,
      String senderName,
      String senderId,
      ResponseStatus responseStatus,
      RequestStatus requestStatus,
      String receiverId,
      String receiverProfile,
      String receiverName,
      @TimestampConverter() Timestamp createdAt});
}

/// @nodoc
class _$RequestmodelCopyWithImpl<$Res> implements $RequestmodelCopyWith<$Res> {
  _$RequestmodelCopyWithImpl(this._self, this._then);

  final Requestmodel _self;
  final $Res Function(Requestmodel) _then;

  /// Create a copy of Requestmodel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderProfile = null,
    Object? senderName = null,
    Object? senderId = null,
    Object? responseStatus = null,
    Object? requestStatus = null,
    Object? receiverId = null,
    Object? receiverProfile = null,
    Object? receiverName = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      senderProfile: null == senderProfile
          ? _self.senderProfile
          : senderProfile // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _self.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      responseStatus: null == responseStatus
          ? _self.responseStatus
          : responseStatus // ignore: cast_nullable_to_non_nullable
              as ResponseStatus,
      requestStatus: null == requestStatus
          ? _self.requestStatus
          : requestStatus // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
      receiverId: null == receiverId
          ? _self.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverProfile: null == receiverProfile
          ? _self.receiverProfile
          : receiverProfile // ignore: cast_nullable_to_non_nullable
              as String,
      receiverName: null == receiverName
          ? _self.receiverName
          : receiverName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Requestmodel implements Requestmodel {
  const _Requestmodel(
      {required this.senderProfile,
      required this.senderName,
      required this.senderId,
      required this.responseStatus,
      required this.requestStatus,
      required this.receiverId,
      required this.receiverProfile,
      required this.receiverName,
      @TimestampConverter() required this.createdAt});
  factory _Requestmodel.fromJson(Map<String, dynamic> json) =>
      _$RequestmodelFromJson(json);

  @override
  final String senderProfile;
  @override
  final String senderName;
  @override
  final String senderId;
  @override
  final ResponseStatus responseStatus;
  @override
  final RequestStatus requestStatus;
  @override
  final String receiverId;
  @override
  final String receiverProfile;
  @override
  final String receiverName;
  @override
  @TimestampConverter()
  final Timestamp createdAt;

  /// Create a copy of Requestmodel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RequestmodelCopyWith<_Requestmodel> get copyWith =>
      __$RequestmodelCopyWithImpl<_Requestmodel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestmodelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Requestmodel &&
            (identical(other.senderProfile, senderProfile) ||
                other.senderProfile == senderProfile) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.responseStatus, responseStatus) ||
                other.responseStatus == responseStatus) &&
            (identical(other.requestStatus, requestStatus) ||
                other.requestStatus == requestStatus) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.receiverProfile, receiverProfile) ||
                other.receiverProfile == receiverProfile) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      senderProfile,
      senderName,
      senderId,
      responseStatus,
      requestStatus,
      receiverId,
      receiverProfile,
      receiverName,
      createdAt);

  @override
  String toString() {
    return 'Requestmodel(senderProfile: $senderProfile, senderName: $senderName, senderId: $senderId, responseStatus: $responseStatus, requestStatus: $requestStatus, receiverId: $receiverId, receiverProfile: $receiverProfile, receiverName: $receiverName, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$RequestmodelCopyWith<$Res>
    implements $RequestmodelCopyWith<$Res> {
  factory _$RequestmodelCopyWith(
          _Requestmodel value, $Res Function(_Requestmodel) _then) =
      __$RequestmodelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String senderProfile,
      String senderName,
      String senderId,
      ResponseStatus responseStatus,
      RequestStatus requestStatus,
      String receiverId,
      String receiverProfile,
      String receiverName,
      @TimestampConverter() Timestamp createdAt});
}

/// @nodoc
class __$RequestmodelCopyWithImpl<$Res>
    implements _$RequestmodelCopyWith<$Res> {
  __$RequestmodelCopyWithImpl(this._self, this._then);

  final _Requestmodel _self;
  final $Res Function(_Requestmodel) _then;

  /// Create a copy of Requestmodel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? senderProfile = null,
    Object? senderName = null,
    Object? senderId = null,
    Object? responseStatus = null,
    Object? requestStatus = null,
    Object? receiverId = null,
    Object? receiverProfile = null,
    Object? receiverName = null,
    Object? createdAt = null,
  }) {
    return _then(_Requestmodel(
      senderProfile: null == senderProfile
          ? _self.senderProfile
          : senderProfile // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: null == senderName
          ? _self.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      responseStatus: null == responseStatus
          ? _self.responseStatus
          : responseStatus // ignore: cast_nullable_to_non_nullable
              as ResponseStatus,
      requestStatus: null == requestStatus
          ? _self.requestStatus
          : requestStatus // ignore: cast_nullable_to_non_nullable
              as RequestStatus,
      receiverId: null == receiverId
          ? _self.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverProfile: null == receiverProfile
          ? _self.receiverProfile
          : receiverProfile // ignore: cast_nullable_to_non_nullable
              as String,
      receiverName: null == receiverName
          ? _self.receiverName
          : receiverName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
    ));
  }
}

// dart format on
