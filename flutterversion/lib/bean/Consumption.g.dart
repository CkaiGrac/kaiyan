// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Consumption.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Consumption _$ConsumptionFromJson(Map<String, dynamic> json) {
  return Consumption(
      collectionCount: json['collectionCount'] as num,
      shareCount: json['shareCount'] as num,
      replyCount: json['replyCount'] as num);
}

Map<String, dynamic> _$ConsumptionToJson(Consumption instance) =>
    <String, dynamic>{
      'collectionCount': instance.collectionCount,
      'shareCount': instance.shareCount,
      'replyCount': instance.replyCount
    };
