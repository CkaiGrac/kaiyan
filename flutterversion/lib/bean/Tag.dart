import 'package:json_annotation/json_annotation.dart';

part 'Tag.g.dart';

@JsonSerializable()
class Tag {
  num id;
  String name;
  String actionUrl;
  var adTrack;
  String desc;
  String bgPicture;
  String headerImage;

  Tag(
      {this.id,
      this.name,
      this.actionUrl,
      this.adTrack,
      this.desc,
      this.bgPicture,
      this.headerImage});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
