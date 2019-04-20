// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Header _$HeaderFromJson(Map<String, dynamic> json) {
  return Header(
      id: json['id'] as int,
      title: json['title'] as String,
      font: json['font'] as String,
      subTitle: json['subTitle'] as String,
      subTitleFont: json['subTitleFont'] as String,
      textAlign: json['textAlign'] as String,
      cover: json['cover'] as String,
      label: json['label'] as String,
      actionUrl: json['actionUrl'] as String,
      labelList: json['labelList'],
      rightText: json['rightText'] as String);
}

Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'font': instance.font,
      'subTitle': instance.subTitle,
      'subTitleFont': instance.subTitleFont,
      'textAlign': instance.textAlign,
      'cover': instance.cover,
      'label': instance.label,
      'actionUrl': instance.actionUrl,
      'labelList': instance.labelList,
      'rightText': instance.rightText
    };
