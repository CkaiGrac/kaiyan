// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
      type: json['type'] as String,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      tag: json['tag'] as String,
      id: json['id'] as num,
      adIndex: json['adIndex'] as num);
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
      'tag': instance.tag,
      'id': instance.id,
      'adIndex': instance.adIndex
    };
