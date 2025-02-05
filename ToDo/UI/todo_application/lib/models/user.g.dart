// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['id'] as num?)?.toInt(),
      json['firstName'] as String?,
      json['lastName'] as String?,
      json['email'] as String?,
      json['phoneNumber'] as String?,
      json['biography'] as String?,
      json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      json['lastTimeSignIn'] == null
          ? null
          : DateTime.parse(json['lastTimeSignIn'] as String),
      $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      json['country'] == null
          ? null
          : Country.fromJson(json['country'] as Map<String, dynamic>),
      (json['countryId'] as num?)?.toInt(),
      $enumDecodeNullable(_$RoleEnumMap, json['role']),
      json['profilePhoto'] == null
          ? null
          : Photo.fromJson(json['profilePhoto'] as Map<String, dynamic>),
      (json['profilePhotoId'] as num?)?.toInt(),
      json['isActive'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'lastTimeSignIn': instance.lastTimeSignIn?.toIso8601String(),
      'biography': instance.biography,
      'birthDate': instance.birthDate?.toIso8601String(),
      'gender': _$GenderEnumMap[instance.gender],
      'countryId': instance.countryId,
      'country': instance.country,
      'role': _$RoleEnumMap[instance.role],
      'profilePhotoId': instance.profilePhotoId,
      'profilePhoto': instance.profilePhoto,
      'isActive': instance.isActive,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};

const _$RoleEnumMap = {
  Role.administrator: 'administrator',
  Role.user: 'user',
};
