// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue _$IssueFromJson(Map<String, dynamic> json) {
  return Issue(
      itemList: (json['itemList'] as List)
          ?.map((e) =>
              e == null ? null : Item.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      count: json['count'] as num,
      total: json['total'] as num,
      nextPageUrl: json['nextPageUrl'] as String,
      adExist: json['adExist'] as bool);
}

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'itemList': instance.itemList,
      'count': instance.count,
      'total': instance.total,
      'nextPageUrl': instance.nextPageUrl,
      'adExist': instance.adExist
    };
