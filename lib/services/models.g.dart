// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      name: json['name'] as String? ?? '',
      detail: json['detail'] as String? ?? '',
      isFaculty: json['isFaculty'] as bool? ?? false,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'detail': instance.detail,
      'isFaculty': instance.isFaculty,
    };
