import 'package:json_annotation/json_annotation.dart';

part 'Cover.g.dart';

@JsonSerializable()
class Cover {
  String feed;
  String detail;
  String blurred;
  String sharing;
  String homepage;

  Cover({this.feed, this.detail, this.blurred, this.sharing, this.homepage});

  factory Cover.fromJson(Map<String, dynamic> json) => _$CoverFromJson(json);
}
