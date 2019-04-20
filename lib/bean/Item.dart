import 'package:json_annotation/json_annotation.dart';
import '../bean/Data.dart';

part 'Item.g.dart';

@JsonSerializable()
class Item {
  String type;
  Data data;
  String tag;
  num id;
  num adIndex;

  Item({this.type, this.data, this.tag, this.id, this.adIndex});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
