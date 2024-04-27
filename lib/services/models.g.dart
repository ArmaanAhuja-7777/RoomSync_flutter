// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      name: json['name'] as String? ?? '',
      detail: json['detail'] as String? ?? '',
      isFaculty: json['isFaculty'] as bool? ?? false,
      roll: json['roll'] as String? ?? '',
      room_no: json['room_no'] as String? ?? '',
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'detail': instance.detail,
      'room_no': instance.room_no,
      'roll': instance.roll,
      'isFaculty': instance.isFaculty,
    };
