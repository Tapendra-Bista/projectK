// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AddEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AddEvent()';
  }
}

/// @nodoc
class $AddEventCopyWith<$Res> {
  $AddEventCopyWith(AddEvent _, $Res Function(AddEvent) __);
}

/// @nodoc

class _Started implements AddEvent {
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
    return 'AddEvent.started()';
  }
}

/// @nodoc

class PickVideo implements AddEvent {
  const PickVideo();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PickVideo);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AddEvent.pickVideo()';
  }
}

/// @nodoc

class RecordVideo implements AddEvent {
  const RecordVideo({required this.videoPath});

  final String videoPath;

  /// Create a copy of AddEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecordVideoCopyWith<RecordVideo> get copyWith =>
      _$RecordVideoCopyWithImpl<RecordVideo>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecordVideo &&
            (identical(other.videoPath, videoPath) ||
                other.videoPath == videoPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, videoPath);

  @override
  String toString() {
    return 'AddEvent.recordVideo(videoPath: $videoPath)';
  }
}

/// @nodoc
abstract mixin class $RecordVideoCopyWith<$Res>
    implements $AddEventCopyWith<$Res> {
  factory $RecordVideoCopyWith(
          RecordVideo value, $Res Function(RecordVideo) _then) =
      _$RecordVideoCopyWithImpl;
  @useResult
  $Res call({String videoPath});
}

/// @nodoc
class _$RecordVideoCopyWithImpl<$Res> implements $RecordVideoCopyWith<$Res> {
  _$RecordVideoCopyWithImpl(this._self, this._then);

  final RecordVideo _self;
  final $Res Function(RecordVideo) _then;

  /// Create a copy of AddEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? videoPath = null,
  }) {
    return _then(RecordVideo(
      videoPath: null == videoPath
          ? _self.videoPath
          : videoPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class PostReel implements AddEvent {
  const PostReel({required this.trimVideoUrl, required this.description});

  final String trimVideoUrl;
  final String description;

  /// Create a copy of AddEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostReelCopyWith<PostReel> get copyWith =>
      _$PostReelCopyWithImpl<PostReel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostReel &&
            (identical(other.trimVideoUrl, trimVideoUrl) ||
                other.trimVideoUrl == trimVideoUrl) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, trimVideoUrl, description);

  @override
  String toString() {
    return 'AddEvent.post(trimVideoUrl: $trimVideoUrl, description: $description)';
  }
}

/// @nodoc
abstract mixin class $PostReelCopyWith<$Res>
    implements $AddEventCopyWith<$Res> {
  factory $PostReelCopyWith(PostReel value, $Res Function(PostReel) _then) =
      _$PostReelCopyWithImpl;
  @useResult
  $Res call({String trimVideoUrl, String description});
}

/// @nodoc
class _$PostReelCopyWithImpl<$Res> implements $PostReelCopyWith<$Res> {
  _$PostReelCopyWithImpl(this._self, this._then);

  final PostReel _self;
  final $Res Function(PostReel) _then;

  /// Create a copy of AddEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? trimVideoUrl = null,
    Object? description = null,
  }) {
    return _then(PostReel(
      trimVideoUrl: null == trimVideoUrl
          ? _self.trimVideoUrl
          : trimVideoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$AddState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AddState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AddState()';
  }
}

/// @nodoc
class $AddStateCopyWith<$Res> {
  $AddStateCopyWith(AddState _, $Res Function(AddState) __);
}

/// @nodoc

class _AddState implements AddState {
  const _AddState();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _AddState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AddState()';
  }
}

/// @nodoc

class AddReelLoading implements AddState {
  const AddReelLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AddReelLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AddState.loading()';
  }
}

/// @nodoc

class AddReelSuccess implements AddState {
  const AddReelSuccess();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AddReelSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AddState.success()';
  }
}

/// @nodoc

class PostingError implements AddState {
  const PostingError({required this.errorMessage});

  final String errorMessage;

  /// Create a copy of AddState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostingErrorCopyWith<PostingError> get copyWith =>
      _$PostingErrorCopyWithImpl<PostingError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PostingError &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @override
  String toString() {
    return 'AddState.error(errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $PostingErrorCopyWith<$Res>
    implements $AddStateCopyWith<$Res> {
  factory $PostingErrorCopyWith(
          PostingError value, $Res Function(PostingError) _then) =
      _$PostingErrorCopyWithImpl;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class _$PostingErrorCopyWithImpl<$Res> implements $PostingErrorCopyWith<$Res> {
  _$PostingErrorCopyWithImpl(this._self, this._then);

  final PostingError _self;
  final $Res Function(PostingError) _then;

  /// Create a copy of AddState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(PostingError(
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ValidUrl implements AddState {
  const ValidUrl({this.videoUrl = ''});

  @JsonKey()
  final String videoUrl;

  /// Create a copy of AddState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ValidUrlCopyWith<ValidUrl> get copyWith =>
      _$ValidUrlCopyWithImpl<ValidUrl>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ValidUrl &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, videoUrl);

  @override
  String toString() {
    return 'AddState.validUrl(videoUrl: $videoUrl)';
  }
}

/// @nodoc
abstract mixin class $ValidUrlCopyWith<$Res>
    implements $AddStateCopyWith<$Res> {
  factory $ValidUrlCopyWith(ValidUrl value, $Res Function(ValidUrl) _then) =
      _$ValidUrlCopyWithImpl;
  @useResult
  $Res call({String videoUrl});
}

/// @nodoc
class _$ValidUrlCopyWithImpl<$Res> implements $ValidUrlCopyWith<$Res> {
  _$ValidUrlCopyWithImpl(this._self, this._then);

  final ValidUrl _self;
  final $Res Function(ValidUrl) _then;

  /// Create a copy of AddState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? videoUrl = null,
  }) {
    return _then(ValidUrl(
      videoUrl: null == videoUrl
          ? _self.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
