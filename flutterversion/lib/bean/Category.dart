import 'package:json_annotation/json_annotation.dart';
/*
 * @Created Date: 2019-02-07 11:06
 * @Author: Ckai
 * @Description: 
 */
part 'Category.g.dart';

@JsonSerializable()
class Category {
  num id;
  String name;
  String description;
  String bgPicture;
  String bgColor;
  String headerImage;

  Category({
    this.id,
    this.name,
    this.description,
    this.bgPicture,
    this.bgColor,
    this.headerImage,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
