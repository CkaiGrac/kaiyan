import 'package:json_annotation/json_annotation.dart';

part 'Follow.g.dart';

@JsonSerializable()
class Follow {
  String itemType;
  num itemId;
  bool followed;

  Follow({this.itemType, this.itemId, this.followed});

  factory Follow.fromJson(Map<String, dynamic> json) => _$FollowFromJson(json);
}
