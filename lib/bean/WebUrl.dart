import 'package:json_annotation/json_annotation.dart';

part 'WebUrl.g.dart';

@JsonSerializable()
class WebUrl {
  String raw;
  String forWeibo;

  WebUrl({this.raw, this.forWeibo});

  factory WebUrl.fromJson(Map<String, dynamic> json) => _$WebUrlFromJson(json);
}
