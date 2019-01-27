// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
      id: json['id'] as num,
      name: json['name'] as String,
      actionUrl: json['actionUrl'] as String,
      adTrack: json['adTrack'],
      desc: json['desc'] as String,
      bgPicture: json['bgPicture'] as String,
      headerImage: json['headerImage'] as String);
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'actionUrl': instance.actionUrl,
      'adTrack': instance.adTrack,
      'desc': instance.desc,
      'bgPicture': instance.bgPicture,
      'headerImage': instance.headerImage
    };
