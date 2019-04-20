// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
      id: json['id'] as num,
      name: json['name'] as String,
      description: json['description'] as String,
      bgPicture: json['bgPicture'] as String,
      bgColor: json['bgColor'] as String,
      headerImage: json['headerImage'] as String);
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'bgPicture': instance.bgPicture,
      'bgColor': instance.bgColor,
      'headerImage': instance.headerImage
    };
