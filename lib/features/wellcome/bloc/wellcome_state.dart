import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wellcome_state.g.dart';

//------------------------------------------------ State------------------------------------
@JsonSerializable()
class WellcomeState extends Equatable {
  final String? languageCode;
  const WellcomeState({this.languageCode});

  factory WellcomeState.initial() {
    return WellcomeState(languageCode: 'fr');
  }

  WellcomeState copyWith({String? languageCode}) {
    return WellcomeState(languageCode: languageCode ?? this.languageCode);
  }

  @override
  List<Object?> get props => [languageCode];

  /// factory.
  factory WellcomeState.fromJson(Map<String, dynamic> json) =>
      _$WellcomeStateFromJson(json);

  Map<String, dynamic> toJson() => _$WellcomeStateToJson(this);
}

class WellcomeInitial extends WellcomeState {}
