import 'package:json_annotation/json_annotation.dart';
import '../bean/User.dart';

part 'ParentReply.g.dart';

@JsonSerializable()
class ParentReply {
  User user;
  String message;

  ParentReply({this.user, this.message});

  factory ParentReply.fromJson(Map<String, dynamic> json) => _$ParentReplyFromJson(json);
}
