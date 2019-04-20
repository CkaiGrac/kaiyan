// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Url _$UrlFromJson(Map<String, dynamic> json) {
  return Url(
      name: json['name'] as String,
      url: json['url'] as String,
      size: json['size'] as num);
}

Map<String, dynamic> _$UrlToJson(Url instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'size': instance.size
    };
