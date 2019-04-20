// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlayInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayInfo _$PlayInfoFromJson(Map<String, dynamic> json) {
  return PlayInfo(
      height: json['height'] as num,
      width: json['width'] as num,
      urlList: (json['urlList'] as List)
          ?.map(
              (e) => e == null ? null : Url.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      name: json['name'] as String,
      type: json['type'] as String,
      url: json['url'] as String);
}

Map<String, dynamic> _$PlayInfoToJson(PlayInfo instance) => <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'urlList': instance.urlList,
      'name': instance.name,
      'type': instance.type,
      'url': instance.url
    };
