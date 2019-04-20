import '../bean/Issue.dart';
import 'package:json_annotation/json_annotation.dart';
part 'DataHub.g.dart';

/*
 * @Created Date: 2019-01-28 19:42
 * @Author: Ckai
 * @Description: 
 */
@JsonSerializable()
class DataHub {
  List<Issue> issueList;
  String nextPageUrl;

  DataHub({this.issueList, this.nextPageUrl});

  factory DataHub.fromJson(Map<String, dynamic> json) => _$DataHubFromJson(json);
}
