// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reel_like_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReelLikeModel {
  String get id;
  List<String> get reelLikeId;

  /// Create a copy of ReelLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReelLikeModelCopyWith<ReelLikeModel> get copyWith =>
      _$ReelLikeModelCopyWithImpl<ReelLikeModel>(
          this as ReelLikeModel, _$identity);

  /// Serializes this ReelLikeModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReelLikeModel &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other.reelLikeId, reelLikeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(reelLikeId));

  @override
  String toString() {
    return 'ReelLikeModel(id: $id, reelLikeId: $reelLikeId)';
  }
}

/// @nodoc
abstract mixin class $ReelLikeModelCopyWith<$Res> {
  factory $ReelLikeModelCopyWith(
          ReelLikeModel value, $Res Function(ReelLikeModel) _then) =
      _$ReelLikeModelCopyWithImpl;
  @useResult
  $Res call({String id, List<String> reelLikeId});
}

/// @nodoc
class _$ReelLikeModelCopyWithImpl<$Res>
    implements $ReelLikeModelCopyWith<$Res> {
  _$ReelLikeModelCopyWithImpl(this._self, this._then);

  final ReelLikeModel _self;
  final $Res Function(ReelLikeModel) _then;

  /// Create a copy of ReelLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reelLikeId = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      reelLikeId: null == reelLikeId
          ? _self.reelLikeId
          : reelLikeId // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [ReelLikeModel].
extension ReelLikeModelPatterns on ReelLikeModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ReelLikeModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReelLikeModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ReelLikeModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReelLikeModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ReelLikeModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReelLikeModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, List<String> reelLikeId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ReelLikeModel() when $default != null:
        return $default(_that.id, _that.reelLikeId);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, List<String> reelLikeId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReelLikeModel():
        return $default(_that.id, _that.reelLikeId);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, List<String> reelLikeId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ReelLikeModel() when $default != null:
        return $default(_that.id, _that.reelLikeId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ReelLikeModel implements ReelLikeModel {
  const _ReelLikeModel(
      {required this.id, required final List<String> reelLikeId})
      : _reelLikeId = reelLikeId;
  factory _ReelLikeModel.fromJson(Map<String, dynamic> json) =>
      _$ReelLikeModelFromJson(json);

  @override
  final String id;
  final List<String> _reelLikeId;
  @override
  List<String> get reelLikeId {
    if (_reelLikeId is EqualUnmodifiableListView) return _reelLikeId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reelLikeId);
  }

  /// Create a copy of ReelLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReelLikeModelCopyWith<_ReelLikeModel> get copyWith =>
      __$ReelLikeModelCopyWithImpl<_ReelLikeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReelLikeModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReelLikeModel &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._reelLikeId, _reelLikeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_reelLikeId));

  @override
  String toString() {
    return 'ReelLikeModel(id: $id, reelLikeId: $reelLikeId)';
  }
}

/// @nodoc
abstract mixin class _$ReelLikeModelCopyWith<$Res>
    implements $ReelLikeModelCopyWith<$Res> {
  factory _$ReelLikeModelCopyWith(
          _ReelLikeModel value, $Res Function(_ReelLikeModel) _then) =
      __$ReelLikeModelCopyWithImpl;
  @override
  @useResult
  $Res call({String id, List<String> reelLikeId});
}

/// @nodoc
class __$ReelLikeModelCopyWithImpl<$Res>
    implements _$ReelLikeModelCopyWith<$Res> {
  __$ReelLikeModelCopyWithImpl(this._self, this._then);

  final _ReelLikeModel _self;
  final $Res Function(_ReelLikeModel) _then;

  /// Create a copy of ReelLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? reelLikeId = null,
  }) {
    return _then(_ReelLikeModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      reelLikeId: null == reelLikeId
          ? _self._reelLikeId
          : reelLikeId // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
