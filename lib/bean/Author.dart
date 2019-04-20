import 'package:json_annotation/json_annotation.dart';
import '../bean/Follow.dart';
import '../bean/Shield.dart';

part 'Author.g.dart';

@JsonSerializable()
class Author {
  num id;
  String icon;
  String name;
  String description;
  String link;
  num latestReleaseTime;
  num videonum;
  var adTrack;
  Follow follow;
  Shield shield;
  num approvedNotReadyVideoCount;
  bool ifPgc;

  Author(
      {this.id,
      this.icon,
      this.name,
      this.description,
      this.link,
      this.latestReleaseTime,
      this.videonum,
      this.adTrack,
      this.follow,
      this.shield,
      this.approvedNotReadyVideoCount,
      this.ifPgc});

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}
