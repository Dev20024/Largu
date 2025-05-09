// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      passWord: json['passWord'] as String,
      dob: json['dob'] as String,
      description: json['description'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'email': instance.email,
      'passWord': instance.passWord,
      'description': instance.description,
      'profilePicture': instance.profilePicture,
      'dob': instance.dob,
    };
