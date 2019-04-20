// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      dataType: json['dataType'] as String,
      itemList: (json['itemList'] as List)
          ?.map((e) =>
              e == null ? null : Item.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      id: json['id'] as num,
      title: json['title'] as String,
      likeCount: json['likeCount'] as num,
      createTime: json['createTime'] as num,
      header: json['header'] == null
          ? null
          : Header.fromJson(json['header'] as Map<String, dynamic>),
      description: json['description'] as String,
      library: json['library'] as String,
      tags: (json['tags'] as List)
          ?.map(
              (e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      consumption: json['consumption'] == null
          ? null
          : Consumption.fromJson(json['consumption'] as Map<String, dynamic>),
      resourceType: json['resourceType'] as String,
      slogan: json['slogan'] as String,
      provider: json['provider'] == null
          ? null
          : Provider.fromJson(json['provider'] as Map<String, dynamic>),
      category: json['category'] as String,
      author: json['author'] == null
          ? null
          : Author.fromJson(json['author'] as Map<String, dynamic>),
      cover: json['cover'] == null
          ? null
          : Cover.fromJson(json['cover'] as Map<String, dynamic>),
      playUrl: json['playUrl'] as String,
      thumbPlayUrl: json['thumbPlayUrl'],
      duration: json['duration'] as num,
      webUrl: json['webUrl'] == null
          ? null
          : WebUrl.fromJson(json['webUrl'] as Map<String, dynamic>),
      releaseTime: json['releaseTime'] as num,
      playInfo: (json['playInfo'] as List)
          ?.map((e) =>
              e == null ? null : PlayInfo.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      campaign: json['campaign'] as String,
      waterMarks: json['waterMarks'] as String,
      adTrack: json['adTrack'],
      type: json['type'] as String,
      titlePgc: json['titlePgc'],
      descriptionPgc: json['descriptionPgc'],
      remark: json['remark'] as String,
      ifLimitVideo: json['ifLimitVideo'] as bool,
      searchWeight: json['searchWeight'] as num,
      idx: json['idx'] as num,
      shareAdTrack: json['shareAdTrack'],
      favoriteAdTrack: json['favoriteAdTrack'],
      webAdTrack: json['webAdTrack'],
      date: json['date'] as num,
      promotion: json['promotion'] as String,
      label: json['label'] as String,
      labelList: json['labelList'] as List,
      descriptionEditor: json['descriptionEditor'] as String,
      collected: json['collected'] as bool,
      played: json['played'] as bool,
      subtitles: json['subtitles'] as List,
      lastViewTime: json['lastViewTime'] as String,
      playlists: json['playlists'] as String,
      src: json['src'] as String,
      text: json['text'] as String,
      font: json['font'] as String,
      parentReply: json['parentReply'] == null
          ? null
          : ParentReply.fromJson(json['parentReply'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>))
    ..message = json['message'] as String;
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'dataType': instance.dataType,
      'itemList': instance.itemList,
      'id': instance.id,
      'likeCount': instance.likeCount,
      'createTime': instance.createTime,
      'message': instance.message,
      'title': instance.title,
      'description': instance.description,
      'library': instance.library,
      'tags': instance.tags,
      'consumption': instance.consumption,
      'resourceType': instance.resourceType,
      'slogan': instance.slogan,
      'provider': instance.provider,
      'category': instance.category,
      'author': instance.author,
      'cover': instance.cover,
      'playUrl': instance.playUrl,
      'thumbPlayUrl': instance.thumbPlayUrl,
      'duration': instance.duration,
      'webUrl': instance.webUrl,
      'releaseTime': instance.releaseTime,
      'playInfo': instance.playInfo,
      'campaign': instance.campaign,
      'waterMarks': instance.waterMarks,
      'adTrack': instance.adTrack,
      'type': instance.type,
      'titlePgc': instance.titlePgc,
      'descriptionPgc': instance.descriptionPgc,
      'remark': instance.remark,
      'ifLimitVideo': instance.ifLimitVideo,
      'searchWeight': instance.searchWeight,
      'idx': instance.idx,
      'shareAdTrack': instance.shareAdTrack,
      'favoriteAdTrack': instance.favoriteAdTrack,
      'webAdTrack': instance.webAdTrack,
      'date': instance.date,
      'promotion': instance.promotion,
      'label': instance.label,
      'labelList': instance.labelList,
      'descriptionEditor': instance.descriptionEditor,
      'collected': instance.collected,
      'played': instance.played,
      'subtitles': instance.subtitles,
      'lastViewTime': instance.lastViewTime,
      'playlists': instance.playlists,
      'src': instance.src,
      'text': instance.text,
      'font': instance.font,
      'parentReply': instance.parentReply,
      'user': instance.user,
      'header': instance.header
    };
