import 'package:json_annotation/json_annotation.dart';

part 'Consumption.g.dart';

@JsonSerializable()
class Consumption {
  num collectionCount;
  num shareCount;
  num replyCount;

  Consumption({this.collectionCount, this.shareCount, this.replyCount});

  factory Consumption.fromJson(Map<String, dynamic> json) =>
      _$ConsumptionFromJson(json);
}
