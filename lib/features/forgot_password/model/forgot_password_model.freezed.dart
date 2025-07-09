// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ForgotPasswordModel {
  String get email;

  /// Create a copy of ForgotPasswordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ForgotPasswordModelCopyWith<ForgotPasswordModel> get copyWith =>
      _$ForgotPasswordModelCopyWithImpl<ForgotPasswordModel>(
          this as ForgotPasswordModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ForgotPasswordModel &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @override
  String toString() {
    return 'ForgotPasswordModel(email: $email)';
  }
}

/// @nodoc
abstract mixin class $ForgotPasswordModelCopyWith<$Res> {
  factory $ForgotPasswordModelCopyWith(
          ForgotPasswordModel value, $Res Function(ForgotPasswordModel) _then) =
      _$ForgotPasswordModelCopyWithImpl;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$ForgotPasswordModelCopyWithImpl<$Res>
    implements $ForgotPasswordModelCopyWith<$Res> {
  _$ForgotPasswordModelCopyWithImpl(this._self, this._then);

  final ForgotPasswordModel _self;
  final $Res Function(ForgotPasswordModel) _then;

  /// Create a copy of ForgotPasswordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_self.copyWith(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ForgotPasswordModel].
extension ForgotPasswordModelPatterns on ForgotPasswordModel {
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
    TResult Function(_ForgotPasswordModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ForgotPasswordModel() when $default != null:
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
    TResult Function(_ForgotPasswordModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ForgotPasswordModel():
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
    TResult? Function(_ForgotPasswordModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ForgotPasswordModel() when $default != null:
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
    TResult Function(String email)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ForgotPasswordModel() when $default != null:
        return $default(_that.email);
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
    TResult Function(String email) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ForgotPasswordModel():
        return $default(_that.email);
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
    TResult? Function(String email)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ForgotPasswordModel() when $default != null:
        return $default(_that.email);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ForgotPasswordModel implements ForgotPasswordModel {
  const _ForgotPasswordModel({required this.email});

  @override
  final String email;

  /// Create a copy of ForgotPasswordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ForgotPasswordModelCopyWith<_ForgotPasswordModel> get copyWith =>
      __$ForgotPasswordModelCopyWithImpl<_ForgotPasswordModel>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ForgotPasswordModel &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @override
  String toString() {
    return 'ForgotPasswordModel(email: $email)';
  }
}

/// @nodoc
abstract mixin class _$ForgotPasswordModelCopyWith<$Res>
    implements $ForgotPasswordModelCopyWith<$Res> {
  factory _$ForgotPasswordModelCopyWith(_ForgotPasswordModel value,
          $Res Function(_ForgotPasswordModel) _then) =
      __$ForgotPasswordModelCopyWithImpl;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$ForgotPasswordModelCopyWithImpl<$Res>
    implements _$ForgotPasswordModelCopyWith<$Res> {
  __$ForgotPasswordModelCopyWithImpl(this._self, this._then);

  final _ForgotPasswordModel _self;
  final $Res Function(_ForgotPasswordModel) _then;

  /// Create a copy of ForgotPasswordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? email = null,
  }) {
    return _then(_ForgotPasswordModel(
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
