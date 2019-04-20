import 'package:json_annotation/json_annotation.dart';
import '../bean/Url.dart';

part 'PlayInfo.g.dart';

@JsonSerializable()
class PlayInfo {
  num height;
  num width;
  List<Url> urlList;
  String name;
  String type;
  String url;
  PlayInfo(
      {this.height, this.width, this.urlList, this.name, this.type, this.url});

  factory PlayInfo.fromJson(Map<String, dynamic> json) =>
      _$PlayInfoFromJson(json);
}
