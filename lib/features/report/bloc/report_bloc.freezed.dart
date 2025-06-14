// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ReportEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ReportEvent()';
  }
}

/// @nodoc
class $ReportEventCopyWith<$Res> {
  $ReportEventCopyWith(ReportEvent _, $Res Function(ReportEvent) __);
}

/// @nodoc

class _Started implements ReportEvent {
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
    return 'ReportEvent.started()';
  }
}

/// @nodoc

class ViolationChoosen implements ReportEvent {
  const ViolationChoosen({required this.violation});

  final String violation;

  /// Create a copy of ReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViolationChoosenCopyWith<ViolationChoosen> get copyWith =>
      _$ViolationChoosenCopyWithImpl<ViolationChoosen>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ViolationChoosen &&
            (identical(other.violation, violation) ||
                other.violation == violation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, violation);

  @override
  String toString() {
    return 'ReportEvent.violationChoosen(violation: $violation)';
  }
}

/// @nodoc
abstract mixin class $ViolationChoosenCopyWith<$Res>
    implements $ReportEventCopyWith<$Res> {
  factory $ViolationChoosenCopyWith(
          ViolationChoosen value, $Res Function(ViolationChoosen) _then) =
      _$ViolationChoosenCopyWithImpl;
  @useResult
  $Res call({String violation});
}

/// @nodoc
class _$ViolationChoosenCopyWithImpl<$Res>
    implements $ViolationChoosenCopyWith<$Res> {
  _$ViolationChoosenCopyWithImpl(this._self, this._then);

  final ViolationChoosen _self;
  final $Res Function(ViolationChoosen) _then;

  /// Create a copy of ReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? violation = null,
  }) {
    return _then(ViolationChoosen(
      violation: null == violation
          ? _self.violation
          : violation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class IllegalChoosen implements ReportEvent {
  const IllegalChoosen({required this.illegal});

  final String illegal;

  /// Create a copy of ReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IllegalChoosenCopyWith<IllegalChoosen> get copyWith =>
      _$IllegalChoosenCopyWithImpl<IllegalChoosen>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IllegalChoosen &&
            (identical(other.illegal, illegal) || other.illegal == illegal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, illegal);

  @override
  String toString() {
    return 'ReportEvent.illegalChoosen(illegal: $illegal)';
  }
}

/// @nodoc
abstract mixin class $IllegalChoosenCopyWith<$Res>
    implements $ReportEventCopyWith<$Res> {
  factory $IllegalChoosenCopyWith(
          IllegalChoosen value, $Res Function(IllegalChoosen) _then) =
      _$IllegalChoosenCopyWithImpl;
  @useResult
  $Res call({String illegal});
}

/// @nodoc
class _$IllegalChoosenCopyWithImpl<$Res>
    implements $IllegalChoosenCopyWith<$Res> {
  _$IllegalChoosenCopyWithImpl(this._self, this._then);

  final IllegalChoosen _self;
  final $Res Function(IllegalChoosen) _then;

  /// Create a copy of ReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? illegal = null,
  }) {
    return _then(IllegalChoosen(
      illegal: null == illegal
          ? _self.illegal
          : illegal // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class AgreeCondition implements ReportEvent {
  const AgreeCondition({required this.agree});

  final bool agree;

  /// Create a copy of ReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AgreeConditionCopyWith<AgreeCondition> get copyWith =>
      _$AgreeConditionCopyWithImpl<AgreeCondition>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AgreeCondition &&
            (identical(other.agree, agree) || other.agree == agree));
  }

  @override
  int get hashCode => Object.hash(runtimeType, agree);

  @override
  String toString() {
    return 'ReportEvent.agreeCondition(agree: $agree)';
  }
}

/// @nodoc
abstract mixin class $AgreeConditionCopyWith<$Res>
    implements $ReportEventCopyWith<$Res> {
  factory $AgreeConditionCopyWith(
          AgreeCondition value, $Res Function(AgreeCondition) _then) =
      _$AgreeConditionCopyWithImpl;
  @useResult
  $Res call({bool agree});
}

/// @nodoc
class _$AgreeConditionCopyWithImpl<$Res>
    implements $AgreeConditionCopyWith<$Res> {
  _$AgreeConditionCopyWithImpl(this._self, this._then);

  final AgreeCondition _self;
  final $Res Function(AgreeCondition) _then;

  /// Create a copy of ReportEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? agree = null,
  }) {
    return _then(AgreeCondition(
      agree: null == agree
          ? _self.agree
          : agree // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
mixin _$ReportState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ReportState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ReportState()';
  }
}

/// @nodoc
class $ReportStateCopyWith<$Res> {
  $ReportStateCopyWith(ReportState _, $Res Function(ReportState) __);
}

/// @nodoc

class Initial implements ReportState {
  const Initial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ReportState.initial()';
  }
}

/// @nodoc

class Violation implements ReportState {
  const Violation(this.violation);

  final String violation;

  /// Create a copy of ReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ViolationCopyWith<Violation> get copyWith =>
      _$ViolationCopyWithImpl<Violation>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Violation &&
            (identical(other.violation, violation) ||
                other.violation == violation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, violation);

  @override
  String toString() {
    return 'ReportState.violation(violation: $violation)';
  }
}

/// @nodoc
abstract mixin class $ViolationCopyWith<$Res>
    implements $ReportStateCopyWith<$Res> {
  factory $ViolationCopyWith(Violation value, $Res Function(Violation) _then) =
      _$ViolationCopyWithImpl;
  @useResult
  $Res call({String violation});
}

/// @nodoc
class _$ViolationCopyWithImpl<$Res> implements $ViolationCopyWith<$Res> {
  _$ViolationCopyWithImpl(this._self, this._then);

  final Violation _self;
  final $Res Function(Violation) _then;

  /// Create a copy of ReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? violation = null,
  }) {
    return _then(Violation(
      null == violation
          ? _self.violation
          : violation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Illegal implements ReportState {
  const Illegal(this.illegal);

  final String illegal;

  /// Create a copy of ReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IllegalCopyWith<Illegal> get copyWith =>
      _$IllegalCopyWithImpl<Illegal>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Illegal &&
            (identical(other.illegal, illegal) || other.illegal == illegal));
  }

  @override
  int get hashCode => Object.hash(runtimeType, illegal);

  @override
  String toString() {
    return 'ReportState.illegal(illegal: $illegal)';
  }
}

/// @nodoc
abstract mixin class $IllegalCopyWith<$Res>
    implements $ReportStateCopyWith<$Res> {
  factory $IllegalCopyWith(Illegal value, $Res Function(Illegal) _then) =
      _$IllegalCopyWithImpl;
  @useResult
  $Res call({String illegal});
}

/// @nodoc
class _$IllegalCopyWithImpl<$Res> implements $IllegalCopyWith<$Res> {
  _$IllegalCopyWithImpl(this._self, this._then);

  final Illegal _self;
  final $Res Function(Illegal) _then;

  /// Create a copy of ReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? illegal = null,
  }) {
    return _then(Illegal(
      null == illegal
          ? _self.illegal
          : illegal // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class Agree implements ReportState {
  const Agree(this.agree);

  final bool agree;

  /// Create a copy of ReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AgreeCopyWith<Agree> get copyWith =>
      _$AgreeCopyWithImpl<Agree>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Agree &&
            (identical(other.agree, agree) || other.agree == agree));
  }

  @override
  int get hashCode => Object.hash(runtimeType, agree);

  @override
  String toString() {
    return 'ReportState.agree(agree: $agree)';
  }
}

/// @nodoc
abstract mixin class $AgreeCopyWith<$Res>
    implements $ReportStateCopyWith<$Res> {
  factory $AgreeCopyWith(Agree value, $Res Function(Agree) _then) =
      _$AgreeCopyWithImpl;
  @useResult
  $Res call({bool agree});
}

/// @nodoc
class _$AgreeCopyWithImpl<$Res> implements $AgreeCopyWith<$Res> {
  _$AgreeCopyWithImpl(this._self, this._then);

  final Agree _self;
  final $Res Function(Agree) _then;

  /// Create a copy of ReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? agree = null,
  }) {
    return _then(Agree(
      null == agree
          ? _self.agree
          : agree // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
