import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  num uid;
  String nickname;
  String avatar;
  String userType;
  bool ifPgc;

  User({this.uid, this.nickname, this.avatar, this.userType, this.ifPgc});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
