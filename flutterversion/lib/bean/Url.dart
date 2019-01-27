import 'package:json_annotation/json_annotation.dart';

part 'Url.g.dart';

@JsonSerializable()
class Url {
  String name;
  String url;
  num size;

  Url({this.name, this.url, this.size});

  factory Url.fromJson(Map<String, dynamic> json) =>
      _$UrlFromJson(json);
}
