// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settingsData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

settingsData _$settingsDataFromJson(Map<String, dynamic> json) => settingsData(
      notifications: json['notifications'] as bool,
      lightMode: json['lightMode'] as bool,
    );

Map<String, dynamic> _$settingsDataToJson(settingsData instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'lightMode': instance.lightMode,
    };
