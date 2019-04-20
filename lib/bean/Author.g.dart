// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(
      id: json['id'] as num,
      icon: json['icon'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      link: json['link'] as String,
      latestReleaseTime: json['latestReleaseTime'] as num,
      videonum: json['videonum'] as num,
      adTrack: json['adTrack'],
      follow: json['follow'] == null
          ? null
          : Follow.fromJson(json['follow'] as Map<String, dynamic>),
      shield: json['shield'] == null
          ? null
          : Shield.fromJson(json['shield'] as Map<String, dynamic>),
      approvedNotReadyVideoCount: json['approvedNotReadyVideoCount'] as num,
      ifPgc: json['ifPgc'] as bool);
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'name': instance.name,
      'description': instance.description,
      'link': instance.link,
      'latestReleaseTime': instance.latestReleaseTime,
      'videonum': instance.videonum,
      'adTrack': instance.adTrack,
      'follow': instance.follow,
      'shield': instance.shield,
      'approvedNotReadyVideoCount': instance.approvedNotReadyVideoCount,
      'ifPgc': instance.ifPgc
    };
