// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DataHub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataHub _$DataHubFromJson(Map<String, dynamic> json) {
  return DataHub(
      issueList: (json['issueList'] as List)
          ?.map((e) =>
              e == null ? null : Issue.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      nextPageUrl: json['nextPageUrl'] as String);
}

Map<String, dynamic> _$DataHubToJson(DataHub instance) => <String, dynamic>{
      'issueList': instance.issueList,
      'nextPageUrl': instance.nextPageUrl
    };
