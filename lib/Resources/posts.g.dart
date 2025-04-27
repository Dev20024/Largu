// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      fundsRequested: (json['fundsRequested'] as num).toInt(),
      fundsReceived: (json['fundsReceived'] as num).toInt(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'fundsRequested': instance.fundsRequested,
      'fundsReceived': instance.fundsReceived,
    };
