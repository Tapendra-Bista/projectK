// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'block_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BlockModel {
  String get id;
  List<String> get blockId;

  /// Create a copy of BlockModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BlockModelCopyWith<BlockModel> get copyWith =>
      _$BlockModelCopyWithImpl<BlockModel>(this as BlockModel, _$identity);

  /// Serializes this BlockModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BlockModel &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.blockId, blockId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(blockId));

  @override
  String toString() {
    return 'BlockModel(id: $id, blockId: $blockId)';
  }
}

/// @nodoc
abstract mixin class $BlockModelCopyWith<$Res> {
  factory $BlockModelCopyWith(
          BlockModel value, $Res Function(BlockModel) _then) =
      _$BlockModelCopyWithImpl;
  @useResult
  $Res call({String id, List<String> blockId});
}

/// @nodoc
class _$BlockModelCopyWithImpl<$Res> implements $BlockModelCopyWith<$Res> {
  _$BlockModelCopyWithImpl(this._self, this._then);

  final BlockModel _self;
  final $Res Function(BlockModel) _then;

  /// Create a copy of BlockModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? blockId = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      blockId: null == blockId
          ? _self.blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BlockModel].
extension BlockModelPatterns on BlockModel {
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
    TResult Function(_BlockModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BlockModel() when $default != null:
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
    TResult Function(_BlockModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BlockModel():
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
    TResult? Function(_BlockModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BlockModel() when $default != null:
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
    TResult Function(String id, List<String> blockId)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BlockModel() when $default != null:
        return $default(_that.id, _that.blockId);
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
    TResult Function(String id, List<String> blockId) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BlockModel():
        return $default(_that.id, _that.blockId);
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
    TResult? Function(String id, List<String> blockId)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BlockModel() when $default != null:
        return $default(_that.id, _that.blockId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BlockModel implements BlockModel {
  const _BlockModel({required this.id, required final List<String> blockId})
      : _blockId = blockId;
  factory _BlockModel.fromJson(Map<String, dynamic> json) =>
      _$BlockModelFromJson(json);

  @override
  final String id;
  final List<String> _blockId;
  @override
  List<String> get blockId {
    if (_blockId is EqualUnmodifiableListView) return _blockId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockId);
  }

  /// Create a copy of BlockModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BlockModelCopyWith<_BlockModel> get copyWith =>
      __$BlockModelCopyWithImpl<_BlockModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BlockModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BlockModel &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._blockId, _blockId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_blockId));

  @override
  String toString() {
    return 'BlockModel(id: $id, blockId: $blockId)';
  }
}

/// @nodoc
abstract mixin class _$BlockModelCopyWith<$Res>
    implements $BlockModelCopyWith<$Res> {
  factory _$BlockModelCopyWith(
          _BlockModel value, $Res Function(_BlockModel) _then) =
      __$BlockModelCopyWithImpl;
  @override
  @useResult
  $Res call({String id, List<String> blockId});
}

/// @nodoc
class __$BlockModelCopyWithImpl<$Res> implements _$BlockModelCopyWith<$Res> {
  __$BlockModelCopyWithImpl(this._self, this._then);

  final _BlockModel _self;
  final $Res Function(_BlockModel) _then;

  /// Create a copy of BlockModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? blockId = null,
  }) {
    return _then(_BlockModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      blockId: null == blockId
          ? _self._blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
