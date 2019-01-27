import 'package:json_annotation/json_annotation.dart';
import '../bean/Item.dart';
import '../bean/Tag.dart';
import '../bean/Consumption.dart';
import '../bean/Provider.dart';
import '../bean/Author.dart';
import '../bean/Cover.dart';
import '../bean/WebUrl.dart';
import '../bean/PlayInfo.dart';
import '../bean/User.dart';
import '../bean/ParentReply.dart';

part 'Data.g.dart';

@JsonSerializable()
class Data {
  String dataType;
  List<Item> itemList;
  num id;
  String title;
  String description;
  String library;
  List<Tag> tags;
  Consumption consumption;
  String resourceType;
  String slogan;
  Provider provider;
  String category;
  Author author;
  Cover cover;
  String playUrl;
  var thumbPlayUrl;
  num duration;
  WebUrl webUrl;
  num releaseTime;
  List<PlayInfo> playInfo;
  String campaign;
  String waterMarks;
  var adTrack;
  String type;
  var titlePgc;
  var descriptionPgc;
  String remark;
  bool ifLimitVideo;
  num searchWeight;
  num idx;
  var shareAdTrack;
  var favoriteAdTrack;
  var webAdTrack;
  num date;
  String promotion;
  String label;
  List labelList;
  String descriptionEditor;
  bool collected;
  bool played;
  List subtitles;
  String lastViewTime;
  String playlists;
  String src;

  String text;
  String font;

  ParentReply parentReply;
  User user;

  Data({
    this.dataType,
    this.itemList,
    this.id,
    this.title,
    this.description,
    this.library,
    this.tags,
    this.consumption,
    this.resourceType,
    this.slogan,
    this.provider,
    this.category,
    this.author,
    this.cover,
    this.playUrl,
    this.thumbPlayUrl,
    this.duration,
    this.webUrl,
    this.releaseTime,
    this.playInfo,
    this.campaign,
    this.waterMarks,
    this.adTrack,
    this.type,
    this.titlePgc,
    this.descriptionPgc,
    this.remark,
    this.ifLimitVideo,
    this.searchWeight,
    this.idx,
    this.shareAdTrack,
    this.favoriteAdTrack,
    this.webAdTrack,
    this.date,
    this.promotion,
    this.label,
    this.labelList,
    this.descriptionEditor,
    this.collected,
    this.played,
    this.subtitles,
    this.lastViewTime,
    this.playlists,
    this.src,
    this.text,
    this.font,
    this.parentReply,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
