// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParentReply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentReply _$ParentReplyFromJson(Map<String, dynamic> json) {
  return ParentReply(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      message: json['message'] as String);
}

Map<String, dynamic> _$ParentReplyToJson(ParentReply instance) =>
    <String, dynamic>{'user': instance.user, 'message': instance.message};
