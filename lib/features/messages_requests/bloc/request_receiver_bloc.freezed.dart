// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_receiver_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestReceiverEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RequestReceiverEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RequestReceiverEvent()';
  }
}

/// @nodoc
class $RequestReceiverEventCopyWith<$Res> {
  $RequestReceiverEventCopyWith(
      RequestReceiverEvent _, $Res Function(RequestReceiverEvent) __);
}

/// @nodoc

class _Started implements RequestReceiverEvent {
  const _Started();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RequestReceiverEvent.started()';
  }
}

/// @nodoc

class RequestReceiverGet implements RequestReceiverEvent {
  const RequestReceiverGet();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RequestReceiverGet);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RequestReceiverEvent.messagesRequestsGet()';
  }
}

/// @nodoc

class RequestReceiverUnreadCount implements RequestReceiverEvent {
  const RequestReceiverUnreadCount();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RequestReceiverUnreadCount);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RequestReceiverEvent.messagesRequestsUnreadCount()';
  }
}

/// @nodoc
mixin _$RequestReceiverState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RequestReceiverState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RequestReceiverState()';
  }
}

/// @nodoc
class $RequestReceiverStateCopyWith<$Res> {
  $RequestReceiverStateCopyWith(
      RequestReceiverState _, $Res Function(RequestReceiverState) __);
}

/// @nodoc

class _Initial implements RequestReceiverState {
  const _Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RequestReceiverState.initial()';
  }
}

/// @nodoc

class NoRequestsYet implements RequestReceiverState {
  const NoRequestsYet();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is NoRequestsYet);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RequestReceiverState.noRequestsYet()';
  }
}

/// @nodoc

class GetRequests implements RequestReceiverState {
  const GetRequests({required final List<Requestmodel> receiverData})
      : _receiverData = receiverData;

  final List<Requestmodel> _receiverData;
  List<Requestmodel> get receiverData {
    if (_receiverData is EqualUnmodifiableListView) return _receiverData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_receiverData);
  }

  /// Create a copy of RequestReceiverState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GetRequestsCopyWith<GetRequests> get copyWith =>
      _$GetRequestsCopyWithImpl<GetRequests>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GetRequests &&
            const DeepCollectionEquality()
                .equals(other._receiverData, _receiverData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_receiverData));

  @override
  String toString() {
    return 'RequestReceiverState.getRequests(receiverData: $receiverData)';
  }
}

/// @nodoc
abstract mixin class $GetRequestsCopyWith<$Res>
    implements $RequestReceiverStateCopyWith<$Res> {
  factory $GetRequestsCopyWith(
          GetRequests value, $Res Function(GetRequests) _then) =
      _$GetRequestsCopyWithImpl;
  @useResult
  $Res call({List<Requestmodel> receiverData});
}

/// @nodoc
class _$GetRequestsCopyWithImpl<$Res> implements $GetRequestsCopyWith<$Res> {
  _$GetRequestsCopyWithImpl(this._self, this._then);

  final GetRequests _self;
  final $Res Function(GetRequests) _then;

  /// Create a copy of RequestReceiverState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? receiverData = null,
  }) {
    return _then(GetRequests(
      receiverData: null == receiverData
          ? _self._receiverData
          : receiverData // ignore: cast_nullable_to_non_nullable
              as List<Requestmodel>,
    ));
  }
}

/// @nodoc

class GetUnreadCount implements RequestReceiverState {
  const GetUnreadCount({required this.count});

  final int count;

  /// Create a copy of RequestReceiverState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GetUnreadCountCopyWith<GetUnreadCount> get copyWith =>
      _$GetUnreadCountCopyWithImpl<GetUnreadCount>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GetUnreadCount &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count);

  @override
  String toString() {
    return 'RequestReceiverState.getUnreadCount(count: $count)';
  }
}

/// @nodoc
abstract mixin class $GetUnreadCountCopyWith<$Res>
    implements $RequestReceiverStateCopyWith<$Res> {
  factory $GetUnreadCountCopyWith(
          GetUnreadCount value, $Res Function(GetUnreadCount) _then) =
      _$GetUnreadCountCopyWithImpl;
  @useResult
  $Res call({int count});
}

/// @nodoc
class _$GetUnreadCountCopyWithImpl<$Res>
    implements $GetUnreadCountCopyWith<$Res> {
  _$GetUnreadCountCopyWithImpl(this._self, this._then);

  final GetUnreadCount _self;
  final $Res Function(GetUnreadCount) _then;

  /// Create a copy of RequestReceiverState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? count = null,
  }) {
    return _then(GetUnreadCount(
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class ErrorInRequests implements RequestReceiverState {
  const ErrorInRequests({required this.errorMessage});

  final String errorMessage;

  /// Create a copy of RequestReceiverState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ErrorInRequestsCopyWith<ErrorInRequests> get copyWith =>
      _$ErrorInRequestsCopyWithImpl<ErrorInRequests>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ErrorInRequests &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'RequestReceiverState.errorInRequests(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ErrorInRequestsCopyWith<$Res>
    implements $RequestReceiverStateCopyWith<$Res> {
  factory $ErrorInRequestsCopyWith(
          ErrorInRequests value, $Res Function(ErrorInRequests) _then) =
      _$ErrorInRequestsCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$ErrorInRequestsCopyWithImpl<$Res>
    implements $ErrorInRequestsCopyWith<$Res> {
  _$ErrorInRequestsCopyWithImpl(this._self, this._then);

  final ErrorInRequests _self;
  final $Res Function(ErrorInRequests) _then;

  /// Create a copy of RequestReceiverState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(ErrorInRequests(
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
