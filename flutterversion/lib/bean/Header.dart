import 'package:json_annotation/json_annotation.dart';

part 'Header.g.dart';

@JsonSerializable()
class Header {
  int id;
  String title;
  String font;
  String subTitle;
  String subTitleFont;
  String textAlign;
  String cover;
  String label;
  String actionUrl;
  var labelList;
  String rightText;

  Header({
    this.id,
    this.title,
    this.font,
    this.subTitle,
    this.subTitleFont,
    this.textAlign,
    this.cover,
    this.label,
    this.actionUrl,
    this.labelList,
    this.rightText,
  });

  factory Header.fromJson(Map<String, dynamic> json) => _$HeaderFromJson(json);
}
