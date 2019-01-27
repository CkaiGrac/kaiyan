import 'package:json_annotation/json_annotation.dart';

part 'Shield.g.dart';

@JsonSerializable()
class Shield {
  String itemType;
  num itemId;
  bool shielded;

  Shield({this.itemType, this.itemId, this.shielded});

  factory Shield.fromJson(Map<String, dynamic> json) => _$ShieldFromJson(json);
}
