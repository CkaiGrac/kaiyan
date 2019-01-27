// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Follow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follow _$FollowFromJson(Map<String, dynamic> json) {
  return Follow(
      itemType: json['itemType'] as String,
      itemId: json['itemId'] as num,
      followed: json['followed'] as bool);
}

Map<String, dynamic> _$FollowToJson(Follow instance) => <String, dynamic>{
      'itemType': instance.itemType,
      'itemId': instance.itemId,
      'followed': instance.followed
    };
