// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cover.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cover _$CoverFromJson(Map<String, dynamic> json) {
  return Cover(
      feed: json['feed'] as String,
      detail: json['detail'] as String,
      blurred: json['blurred'] as String,
      sharing: json['sharing'] as String,
      homepage: json['homepage'] as String);
}

Map<String, dynamic> _$CoverToJson(Cover instance) => <String, dynamic>{
      'feed': instance.feed,
      'detail': instance.detail,
      'blurred': instance.blurred,
      'sharing': instance.sharing,
      'homepage': instance.homepage
    };
