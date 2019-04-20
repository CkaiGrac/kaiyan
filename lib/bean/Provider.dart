import 'package:json_annotation/json_annotation.dart';

part 'Provider.g.dart';

@JsonSerializable()
class Provider {
  String name;
  String alias;
  String icon;

  Provider({this.name, this.alias, this.icon});

  factory Provider.fromJson(Map<String, dynamic> json) =>
      _$ProviderFromJson(json);
}
