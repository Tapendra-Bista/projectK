// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeState _$HomeStateFromJson(Map<String, dynamic> json) => HomeState(
      data: (json['data'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : ProfileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      profileList: (json['profileList'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : ProfileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeStateToJson(HomeState instance) => <String, dynamic>{
      'data': instance.data,
      'profileList': instance.profileList,
    };
