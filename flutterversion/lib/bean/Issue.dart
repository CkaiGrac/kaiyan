import '../bean/Item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Issue.g.dart';

@JsonSerializable()
class Issue {
  List<Item> itemList;
  num count;
  num total;
  String nextPageUrl;
  bool adExist;

  Issue(
      {this.itemList, this.count, this.total, this.nextPageUrl, this.adExist});

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);
}
