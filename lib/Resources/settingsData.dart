import 'package:json_annotation/json_annotation.dart';

part "settingsData.g.dart";

@JsonSerializable()
class settingsData {
  bool notifications;
  bool lightMode;

  settingsData({
    required this.notifications,
    required this.lightMode
  });

  factory settingsData.fromJson(Map<String, dynamic> json) => _$settingsDataFromJson(json);
  Map<String, dynamic> toJson(settingsData data) => _$settingsDataToJson(data);


}