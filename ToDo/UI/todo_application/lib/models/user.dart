import 'package:todo_application/enums/gender_enum.dart';
import 'package:todo_application/enums/role_enum.dart';

import '../models/country.dart';
import '../models/photo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  DateTime? lastTimeSignIn;
  String? biography;
  DateTime? birthDate;
  Gender? gender;
  int? countryId;
  Country? country;
  Role? role;
  int? profilePhotoId;
  Photo? profilePhoto;
  bool isActive;

  User(
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.biography,
      this.birthDate,
      this.lastTimeSignIn,
      this.gender,
      this.country,
      this.countryId,
      this.role,
      this.profilePhoto,
      this.profilePhotoId,
      this.isActive);

  //factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromJson(Map<String, dynamic> json) =>_$UserFromJson(json);

  

  Map<String, dynamic> toJson() => _$UserToJson(this);
}