// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      uid: json['uid'] as num,
      nickname: json['nickname'] as String,
      avatar: json['avatar'] as String,
      userType: json['userType'] as String,
      ifPgc: json['ifPgc'] as bool);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'userType': instance.userType,
      'ifPgc': instance.ifPgc
    };
